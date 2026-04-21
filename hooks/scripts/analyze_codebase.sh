#!/usr/bin/env bash
# =============================================================================
# Brownfield Codebase Analyzer
# Scans existing codebase and generates detailed improvement report in Markdown
# =============================================================================
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Defaults
TARGET_DIR="${1:-.}"
OUTPUT_DIR="${OUTPUT_DIR:-./lint-reports}"
REPORT_FILE="${OUTPUT_DIR}/codebase_health_report.md"
FIX_LEVEL="${FIX_LEVEL:-moderate}"  # conservative, moderate, aggressive
SKIP_SECURITY="${SKIP_SECURITY:-false}"
PARALLEL_JOBS="${PARALLEL_JOBS:-4}"

# Script directory for config
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

show_help() {
    cat << EOF
Usage: $(basename "$0") [TARGET_DIR] [OPTIONS]

Analyze a brownfield codebase and generate improvement reports.

Arguments:
    TARGET_DIR          Directory to analyze (default: current directory)

Environment Variables:
    OUTPUT_DIR          Output directory for reports (default: ./lint-reports)
    FIX_LEVEL           Auto-fix aggressiveness: conservative|moderate|aggressive (default: moderate)
    SKIP_SECURITY       Skip security scans (default: false)
    PARALLEL_JOBS       Number of parallel jobs (default: 4)

Examples:
    $(basename "$0") /path/to/project
    FIX_LEVEL=conservative $(basename "$0") .
    OUTPUT_DIR=/tmp/reports SKIP_SECURITY=true $(basename "$0") ./src
EOF
    exit 0
}

[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && show_help

# Resolve to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" 2>/dev/null && pwd)" || {
    print_error "Target directory does not exist: $1"
    exit 1
}

# Initialize
mkdir -p "$OUTPUT_DIR"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
TOTAL_FILES=0
TOTAL_ISSUES=0

declare -A FILE_COUNTS
declare -A ISSUE_COUNTS

# Temporary files for storing detailed issues
ISSUES_DIR=$(mktemp -d)
trap "rm -rf $ISSUES_DIR" EXIT

# =============================================================================
# File Discovery
# =============================================================================
discover_files() {
    print_status "Discovering files in $TARGET_DIR..."
    
    # Count files by extension
    while IFS= read -r -d '' file; do
        ext="${file##*.}"
        ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
        
        # Handle files without extensions
        [[ "$ext" == "$file" ]] && ext_lower="no_extension"
        
        # Special cases
        basename_file=$(basename "$file")
        case "$basename_file" in
            Dockerfile*) ext_lower="dockerfile" ;;
            Makefile|makefile) ext_lower="makefile" ;;
            Gemfile|Rakefile) ext_lower="rb" ;;
        esac
        
        FILE_COUNTS[$ext_lower]=$((${FILE_COUNTS[$ext_lower]:-0} + 1))
        ((TOTAL_FILES++)) || true
    done < <(find "$TARGET_DIR" -type f \
        ! -path '*/.git/*' \
        ! -path '*/node_modules/*' \
        ! -path '*/__pycache__/*' \
        ! -path '*/.venv/*' \
        ! -path '*/venv/*' \
        ! -path '*/target/*' \
        ! -path '*/build/*' \
        ! -path '*/dist/*' \
        ! -path '*/.next/*' \
        ! -path '*/.nuxt/*' \
        ! -path '*/vendor/*' \
        ! -path '*/.terraform/*' \
        -print0 2>/dev/null)
    
    print_success "Found $TOTAL_FILES files"
}

# =============================================================================
# Run Tool and Capture Output
# =============================================================================
run_tool() {
    local tool_name="$1"
    local tool_cmd="$2"
    local file_type="$3"
    local temp_output="${ISSUES_DIR}/${file_type}_${tool_name}.txt"
    
    if eval "$tool_cmd" > "$temp_output" 2>&1; then
        # Tool passed - no issues
        rm -f "$temp_output"
        return 0
    else
        local exit_code=$?
        local issue_count
        issue_count=$(wc -l < "$temp_output" 2>/dev/null | tr -d ' ' || echo "0")
        
        if [[ $issue_count -gt 0 && -s "$temp_output" ]]; then
            ISSUE_COUNTS[$file_type]=$((${ISSUE_COUNTS[$file_type]:-0} + issue_count))
            ((TOTAL_ISSUES += issue_count)) || true
            # Keep the file for report generation
            return 1
        else
            rm -f "$temp_output"
            return $exit_code
        fi
    fi
}

# =============================================================================
# Language-Specific Analysis
# =============================================================================
analyze_python() {
    local py_files
    py_files=$(find "$TARGET_DIR" -name "*.py" -type f \
        ! -path '*/.venv/*' ! -path '*/venv/*' ! -path '*/__pycache__/*' \
        2>/dev/null | head -500)
    [[ -z "$py_files" ]] && return 0
    
    local py_count
    py_count=$(echo "$py_files" | wc -l | tr -d ' ')
    print_status "Analyzing $py_count Python files..."
    
    # Ruff (fast, comprehensive)
    if command -v ruff &>/dev/null; then
        run_tool "ruff" "ruff check $TARGET_DIR --output-format=text 2>/dev/null || true" "python" || true
    fi
    
    # Type checking with mypy
    if command -v mypy &>/dev/null; then
        run_tool "mypy" "mypy $TARGET_DIR --ignore-missing-imports --no-error-summary 2>/dev/null || true" "python" || true
    fi
    
    # Security with bandit
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v bandit &>/dev/null; then
        run_tool "bandit" "bandit -r $TARGET_DIR -f txt -q 2>/dev/null || true" "python_security" || true
    fi
    
    # Docstring coverage
    if command -v interrogate &>/dev/null; then
        run_tool "interrogate" "interrogate $TARGET_DIR -v 2>/dev/null || true" "python_docs" || true
    fi
}

analyze_javascript() {
    local js_files
    js_files=$(find "$TARGET_DIR" \( -name "*.js" -o -name "*.jsx" -o -name "*.ts" -o -name "*.tsx" \) \
        -type f ! -path '*/node_modules/*' ! -path '*/dist/*' ! -path '*/build/*' \
        2>/dev/null | head -500)
    [[ -z "$js_files" ]] && return 0
    
    local js_count
    js_count=$(echo "$js_files" | wc -l | tr -d ' ')
    print_status "Analyzing $js_count JavaScript/TypeScript files..."
    
    if command -v eslint &>/dev/null; then
        run_tool "eslint" "eslint $TARGET_DIR --ext .js,.jsx,.ts,.tsx --format unix --no-error-on-unmatched-pattern 2>/dev/null || true" "javascript" || true
    fi
    
    # TypeScript type checking
    if [[ -f "$TARGET_DIR/tsconfig.json" ]] && command -v tsc &>/dev/null; then
        run_tool "tsc" "tsc --noEmit --project $TARGET_DIR 2>/dev/null || true" "typescript" || true
    fi
    
    # Dependency check
    if command -v depcheck &>/dev/null && [[ -f "$TARGET_DIR/package.json" ]]; then
        run_tool "depcheck" "depcheck $TARGET_DIR 2>/dev/null || true" "javascript_deps" || true
    fi
}

analyze_go() {
    local go_files
    go_files=$(find "$TARGET_DIR" -name "*.go" -type f 2>/dev/null | head -500)
    [[ -z "$go_files" ]] && return 0
    
    local go_count
    go_count=$(echo "$go_files" | wc -l | tr -d ' ')
    print_status "Analyzing $go_count Go files..."
    
    if command -v golangci-lint &>/dev/null; then
        run_tool "golangci-lint" "golangci-lint run $TARGET_DIR/... 2>/dev/null || true" "go" || true
    fi
    
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v gosec &>/dev/null; then
        run_tool "gosec" "gosec -fmt=text -quiet $TARGET_DIR/... 2>/dev/null || true" "go_security" || true
    fi
    
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v govulncheck &>/dev/null; then
        run_tool "govulncheck" "govulncheck $TARGET_DIR/... 2>/dev/null || true" "go_vulns" || true
    fi
}

analyze_rust() {
    [[ ! -f "$TARGET_DIR/Cargo.toml" ]] && return 0
    
    print_status "Analyzing Rust project..."
    
    if command -v cargo &>/dev/null; then
        run_tool "clippy" "(cd $TARGET_DIR && cargo clippy --message-format=short 2>/dev/null) || true" "rust" || true
        
        if [[ "$SKIP_SECURITY" != "true" ]]; then
            run_tool "cargo-audit" "(cd $TARGET_DIR && cargo audit 2>/dev/null) || true" "rust_security" || true
        fi
    fi
}

analyze_cpp() {
    local cpp_files
    cpp_files=$(find "$TARGET_DIR" \( -name "*.c" -o -name "*.cpp" -o -name "*.cc" -o -name "*.h" -o -name "*.hpp" \) \
        -type f ! -path '*/build/*' 2>/dev/null | head -500)
    [[ -z "$cpp_files" ]] && return 0
    
    local cpp_count
    cpp_count=$(echo "$cpp_files" | wc -l | tr -d ' ')
    print_status "Analyzing $cpp_count C/C++ files..."
    
    if command -v cppcheck &>/dev/null; then
        run_tool "cppcheck" "cppcheck --enable=all --quiet --template='{file}:{line}: {severity}: {message}' $TARGET_DIR 2>&1 || true" "cpp" || true
    fi
}

analyze_java() {
    local java_files
    java_files=$(find "$TARGET_DIR" -name "*.java" -type f ! -path '*/target/*' ! -path '*/build/*' 2>/dev/null | head -500)
    [[ -z "$java_files" ]] && return 0
    
    local java_count
    java_count=$(echo "$java_files" | wc -l | tr -d ' ')
    print_status "Analyzing $java_count Java files..."
    
    if command -v checkstyle &>/dev/null || [[ -f /usr/local/bin/checkstyle.jar ]]; then
        # Note: checkstyle needs a config file, skip if not available
        print_warning "Checkstyle available but requires configuration"
    fi
    
    if command -v pmd &>/dev/null; then
        run_tool "pmd" "pmd check -d $TARGET_DIR -R rulesets/java/quickstart.xml -f text 2>/dev/null || true" "java" || true
    fi
}

analyze_ruby() {
    local rb_files
    rb_files=$(find "$TARGET_DIR" \( -name "*.rb" -o -name "Gemfile" -o -name "Rakefile" \) \
        -type f ! -path '*/vendor/*' 2>/dev/null | head -500)
    [[ -z "$rb_files" ]] && return 0
    
    local rb_count
    rb_count=$(echo "$rb_files" | wc -l | tr -d ' ')
    print_status "Analyzing $rb_count Ruby files..."
    
    if command -v rubocop &>/dev/null; then
        run_tool "rubocop" "rubocop $TARGET_DIR --format simple 2>/dev/null || true" "ruby" || true
    fi
    
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v brakeman &>/dev/null; then
        if [[ -f "$TARGET_DIR/config/application.rb" ]]; then
            run_tool "brakeman" "brakeman $TARGET_DIR -q 2>/dev/null || true" "ruby_security" || true
        fi
    fi
}

analyze_php() {
    local php_files
    php_files=$(find "$TARGET_DIR" -name "*.php" -type f ! -path '*/vendor/*' 2>/dev/null | head -500)
    [[ -z "$php_files" ]] && return 0
    
    local php_count
    php_count=$(echo "$php_files" | wc -l | tr -d ' ')
    print_status "Analyzing $php_count PHP files..."
    
    if command -v phpstan &>/dev/null; then
        run_tool "phpstan" "phpstan analyse $TARGET_DIR --error-format=raw 2>/dev/null || true" "php" || true
    fi
}

analyze_shell() {
    local sh_files
    sh_files=$(find "$TARGET_DIR" \( -name "*.sh" -o -name "*.bash" \) -type f 2>/dev/null | head -200)
    [[ -z "$sh_files" ]] && return 0
    
    local sh_count
    sh_count=$(echo "$sh_files" | wc -l | tr -d ' ')
    print_status "Analyzing $sh_count shell scripts..."
    
    if command -v shellcheck &>/dev/null; then
        run_tool "shellcheck" "shellcheck -f gcc $sh_files 2>/dev/null || true" "shell" || true
    fi
}

analyze_docker() {
    local dockerfiles
    dockerfiles=$(find "$TARGET_DIR" -name "Dockerfile*" -type f 2>/dev/null)
    [[ -z "$dockerfiles" ]] && return 0
    
    local docker_count
    docker_count=$(echo "$dockerfiles" | wc -l | tr -d ' ')
    print_status "Analyzing $docker_count Dockerfiles..."
    
    if command -v hadolint &>/dev/null; then
        run_tool "hadolint" "hadolint $dockerfiles 2>/dev/null || true" "dockerfile" || true
    fi
    
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v trivy &>/dev/null; then
        for df in $dockerfiles; do
            run_tool "trivy" "trivy config $df 2>/dev/null || true" "dockerfile_security" || true
        done
    fi
}

analyze_terraform() {
    local tf_files
    tf_files=$(find "$TARGET_DIR" -name "*.tf" -type f ! -path '*/.terraform/*' 2>/dev/null | head -200)
    [[ -z "$tf_files" ]] && return 0
    
    local tf_count
    tf_count=$(echo "$tf_files" | wc -l | tr -d ' ')
    print_status "Analyzing $tf_count Terraform files..."
    
    if command -v tflint &>/dev/null; then
        run_tool "tflint" "tflint $TARGET_DIR 2>/dev/null || true" "terraform" || true
    fi
    
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v tfsec &>/dev/null; then
        run_tool "tfsec" "tfsec $TARGET_DIR --format=text 2>/dev/null || true" "terraform_security" || true
    fi
}

analyze_kubernetes() {
    local k8s_files
    k8s_files=$(find "$TARGET_DIR" \( -path '*/k8s/*' -o -path '*/kubernetes/*' -o -path '*/manifests/*' \) \
        \( -name "*.yaml" -o -name "*.yml" \) -type f 2>/dev/null | head -200)
    [[ -z "$k8s_files" ]] && return 0
    
    local k8s_count
    k8s_count=$(echo "$k8s_files" | wc -l | tr -d ' ')
    print_status "Analyzing $k8s_count Kubernetes manifests..."
    
    if command -v kubeconform &>/dev/null; then
        run_tool "kubeconform" "kubeconform -summary $k8s_files 2>/dev/null || true" "kubernetes" || true
    fi
}

analyze_yaml() {
    local yaml_files
    yaml_files=$(find "$TARGET_DIR" \( -name "*.yaml" -o -name "*.yml" \) \
        -type f ! -path '*/node_modules/*' ! -path '*/.git/*' 2>/dev/null | head -200)
    [[ -z "$yaml_files" ]] && return 0
    
    local yaml_count
    yaml_count=$(echo "$yaml_files" | wc -l | tr -d ' ')
    print_status "Analyzing $yaml_count YAML files..."
    
    if command -v yamllint &>/dev/null; then
        run_tool "yamllint" "yamllint -f parsable $TARGET_DIR 2>/dev/null || true" "yaml" || true
    fi
}

analyze_markdown() {
    local md_files
    md_files=$(find "$TARGET_DIR" -name "*.md" -type f ! -path '*/node_modules/*' 2>/dev/null | head -200)
    [[ -z "$md_files" ]] && return 0
    
    local md_count
    md_count=$(echo "$md_files" | wc -l | tr -d ' ')
    print_status "Analyzing $md_count Markdown files..."
    
    if command -v markdownlint-cli2 &>/dev/null; then
        run_tool "markdownlint" "markdownlint-cli2 '$TARGET_DIR/**/*.md' 2>/dev/null || true" "markdown" || true
    fi
}

analyze_github_actions() {
    local action_files
    action_files=$(find "$TARGET_DIR" -path '*/.github/workflows/*' \( -name "*.yml" -o -name "*.yaml" \) -type f 2>/dev/null)
    [[ -z "$action_files" ]] && return 0
    
    local action_count
    action_count=$(echo "$action_files" | wc -l | tr -d ' ')
    print_status "Analyzing $action_count GitHub Actions workflows..."
    
    if command -v actionlint &>/dev/null; then
        run_tool "actionlint" "actionlint $action_files 2>/dev/null || true" "github_actions" || true
    fi
}

# =============================================================================
# Universal Checks
# =============================================================================
run_universal_checks() {
    print_status "Running universal checks..."
    
    # Secrets scanning
    if [[ "$SKIP_SECURITY" != "true" ]] && command -v gitleaks &>/dev/null; then
        print_status "Scanning for secrets..."
        run_tool "gitleaks" "gitleaks detect --source=$TARGET_DIR --no-git -v 2>/dev/null || true" "secrets" || true
    fi
    
    # Spelling
    if command -v codespell &>/dev/null; then
        run_tool "codespell" "codespell $TARGET_DIR --skip='*.git,node_modules,*.lock,*.min.js,vendor,venv,.venv,target,build,dist' -q 3 2>/dev/null || true" "spelling" || true
    fi
    
    # Typos (faster Rust-based spell checker)
    if command -v typos &>/dev/null; then
        run_tool "typos" "typos $TARGET_DIR 2>/dev/null || true" "spelling" || true
    fi
}

# =============================================================================
# Generate Report
# =============================================================================
generate_report() {
    print_status "Generating Markdown report..."
    
    cat > "$REPORT_FILE" << EOF
# Codebase Health Report

**Generated:** $TIMESTAMP  
**Target:** \`$TARGET_DIR\`  
**Fix Level:** $FIX_LEVEL  

---

## Executive Summary

| Metric | Count |
|--------|-------|
| **Total Files Scanned** | $TOTAL_FILES |
| **Total Issues Found** | $TOTAL_ISSUES |
| **Security Scan** | $([ "$SKIP_SECURITY" == "true" ] && echo "Skipped" || echo "Enabled") |

EOF

    # Calculate health score
    local health_score=100
    if [[ $TOTAL_FILES -gt 0 ]]; then
        local issue_ratio=$((TOTAL_ISSUES * 100 / TOTAL_FILES))
        health_score=$((100 - issue_ratio))
        [[ $health_score -lt 0 ]] && health_score=0
    fi
    
    local health_status="🟢 Excellent"
    [[ $health_score -lt 90 ]] && health_status="🟡 Good"
    [[ $health_score -lt 70 ]] && health_status="🟠 Needs Attention"
    [[ $health_score -lt 50 ]] && health_status="🔴 Critical"
    
    cat >> "$REPORT_FILE" << EOF
### Health Score: $health_score/100 $health_status

---

## Files by Type

| Extension | Count | Percentage |
|-----------|-------|------------|
EOF

    # Sort and output file counts
    for ext in $(echo "${!FILE_COUNTS[@]}" | tr ' ' '\n' | sort); do
        local count=${FILE_COUNTS[$ext]}
        local pct=$((count * 100 / TOTAL_FILES))
        echo "| \`.$ext\` | $count | ${pct}% |" >> "$REPORT_FILE"
    done

    cat >> "$REPORT_FILE" << EOF

---

## Issues by Category

| Category | Issues | Severity |
|----------|--------|----------|
EOF

    # Sort and output issue counts with severity
    for type in $(echo "${!ISSUE_COUNTS[@]}" | tr ' ' '\n' | sort); do
        local severity="⚠️ Medium"
        [[ "$type" == *"security"* ]] && severity="🔴 Critical"
        [[ "$type" == *"typescript"* || "$type" == *"mypy"* ]] && severity="🟠 High"
        [[ "$type" == *"spelling"* || "$type" == *"markdown"* ]] && severity="🟢 Low"
        
        echo "| **$type** | ${ISSUE_COUNTS[$type]} | $severity |" >> "$REPORT_FILE"
    done

    cat >> "$REPORT_FILE" << EOF

---

## Detailed Findings

EOF

    # Output detailed issues from temp files
    for issue_file in "$ISSUES_DIR"/*.txt; do
        [[ ! -f "$issue_file" ]] && continue
        
        local filename=$(basename "$issue_file" .txt)
        local file_type="${filename%_*}"
        local tool_name="${filename#*_}"
        
        # Limit output to first 100 lines per tool
        local line_count=$(wc -l < "$issue_file" | tr -d ' ')
        local truncated=""
        [[ $line_count -gt 100 ]] && truncated=" (showing first 100 of $line_count)"
        
        cat >> "$REPORT_FILE" << EOF
### ${file_type^} - $tool_name$truncated

\`\`\`
$(head -100 "$issue_file")
\`\`\`

EOF
    done

    cat >> "$REPORT_FILE" << EOF
---

## Recommended Actions

### 🔴 Priority 1: Security Issues
- Address any secrets detected by gitleaks/trufflehog immediately
- Fix security vulnerabilities flagged by bandit/gosec/tfsec/brakeman
- Update vulnerable dependencies identified by audit tools

### 🟠 Priority 2: Type Errors & Bugs
- Resolve type checking errors (mypy/pyright/tsc)
- Fix static analysis errors (clippy/golangci-lint/cppcheck)
- Add missing type annotations for better code safety

### 🟡 Priority 3: Code Quality
- Fix linting errors by severity (errors first, then warnings)
- Reduce cyclomatic complexity in flagged functions
- Remove unused imports and dead code

### 🟢 Priority 4: Style & Formatting
- Run formatters to ensure consistent style
- Fix spelling errors in comments and documentation
- Apply project-specific style guide rules

---

## Auto-Fix Commands

Run these commands to automatically fix issues:

\`\`\`bash
# Conservative (formatting only - safe for any codebase)
FIX_LEVEL=conservative ./agentic_precommit.sh

# Moderate (safe auto-fixes) - RECOMMENDED DEFAULT
FIX_LEVEL=moderate ./agentic_precommit.sh

# Aggressive (all auto-fixable - review changes carefully)
FIX_LEVEL=aggressive ./agentic_precommit.sh
\`\`\`

### Language-Specific Quick Fixes

\`\`\`bash
# Python
ruff check --fix $TARGET_DIR
ruff format $TARGET_DIR
isort $TARGET_DIR

# JavaScript/TypeScript
prettier --write "$TARGET_DIR/**/*.{js,jsx,ts,tsx}"
eslint --fix "$TARGET_DIR/**/*.{js,jsx,ts,tsx}"

# Go
gofmt -w $TARGET_DIR
goimports -w $TARGET_DIR

# Rust
cargo fmt
cargo clippy --fix --allow-dirty

# Shell
shfmt -w $TARGET_DIR/**/*.sh
\`\`\`

---

## Tool Versions

\`\`\`
EOF

    # Capture tool versions
    {
        command -v ruff &>/dev/null && echo "ruff: $(ruff --version 2>/dev/null || echo 'unknown')"
        command -v eslint &>/dev/null && echo "eslint: $(eslint --version 2>/dev/null || echo 'unknown')"
        command -v golangci-lint &>/dev/null && echo "golangci-lint: $(golangci-lint --version 2>/dev/null | head -1 || echo 'unknown')"
        command -v cargo &>/dev/null && echo "cargo: $(cargo --version 2>/dev/null || echo 'unknown')"
        command -v shellcheck &>/dev/null && echo "shellcheck: $(shellcheck --version 2>/dev/null | head -2 | tail -1 || echo 'unknown')"
        command -v hadolint &>/dev/null && echo "hadolint: $(hadolint --version 2>/dev/null || echo 'unknown')"
        command -v gitleaks &>/dev/null && echo "gitleaks: $(gitleaks version 2>/dev/null || echo 'unknown')"
    } >> "$REPORT_FILE"
    
    echo '```' >> "$REPORT_FILE"
    
    cat >> "$REPORT_FILE" << EOF

---

*Report generated by analyze_codebase.sh - Comprehensive Linting Toolkit*
EOF

    print_success "Report saved to $REPORT_FILE"
}

# =============================================================================
# Main
# =============================================================================
main() {
    echo ""
    echo -e "${CYAN}════════════════════════════════════════════${NC}"
    echo -e "${CYAN}   Brownfield Codebase Analyzer${NC}"
    echo -e "${CYAN}════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  Target:     ${YELLOW}$TARGET_DIR${NC}"
    echo -e "  Output:     ${YELLOW}$OUTPUT_DIR${NC}"
    echo -e "  Fix Level:  ${YELLOW}$FIX_LEVEL${NC}"
    echo -e "  Security:   ${YELLOW}$([ "$SKIP_SECURITY" == "true" ] && echo "Disabled" || echo "Enabled")${NC}"
    echo ""
    
    discover_files
    
    echo ""
    print_status "Running analyzers..."
    echo ""
    
    # Run all analyzers
    analyze_python
    analyze_javascript
    analyze_go
    analyze_rust
    analyze_cpp
    analyze_java
    analyze_ruby
    analyze_php
    analyze_shell
    analyze_docker
    analyze_terraform
    analyze_kubernetes
    analyze_yaml
    analyze_markdown
    analyze_github_actions
    run_universal_checks
    
    generate_report
    
    echo ""
    echo -e "${CYAN}════════════════════════════════════════════${NC}"
    echo -e "${GREEN}   Analysis Complete!${NC}"
    echo -e "${CYAN}════════════════════════════════════════════${NC}"
    echo ""
    echo -e "  Files scanned:  ${GREEN}$TOTAL_FILES${NC}"
    echo -e "  Issues found:   ${YELLOW}$TOTAL_ISSUES${NC}"
    echo -e "  Report:         ${BLUE}$REPORT_FILE${NC}"
    echo ""
    
    # Exit with error if critical issues found
    if [[ ${ISSUE_COUNTS[secrets]:-0} -gt 0 ]]; then
        print_error "CRITICAL: Secrets detected in codebase!"
        exit 1
    fi
}

main "$@"
