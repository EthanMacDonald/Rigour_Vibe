#!/usr/bin/env bash
# =============================================================================
# Agentic Pre-Commit Hook
# Detects changed files, runs appropriate formatters/linters based on file type
# Designed for use after agentic programming sessions
# =============================================================================
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Configuration
FIX_LEVEL="${FIX_LEVEL:-moderate}"  # conservative, moderate, aggressive
CHECK_ONLY="${CHECK_ONLY:-false}"    # If true, don't auto-fix
VERBOSE="${VERBOSE:-false}"
STAGED_ONLY="${STAGED_ONLY:-true}"   # Only check staged files
FAIL_ON_ERROR="${FAIL_ON_ERROR:-true}"
RUN_TESTS="${RUN_TESTS:-true}"
TEST_COMMAND="${TEST_COMMAND:-}"

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_debug() { [[ "$VERBOSE" == "true" ]] && echo -e "${MAGENTA}[DEBUG]${NC} $1" || true; }

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Intelligent pre-commit hook for agentic programming workflows.
Detects changed files, identifies types, and runs appropriate tools.

Environment Variables:
    FIX_LEVEL       Auto-fix level: conservative|moderate|aggressive (default: moderate)
    CHECK_ONLY      Only check, don't fix: true|false (default: false)
    VERBOSE         Verbose output: true|false (default: false)
    STAGED_ONLY     Only check staged files: true|false (default: true)
    FAIL_ON_ERROR   Exit with error on issues: true|false (default: true)
    RUN_TESTS       Run tests as part of hook: true|false (default: true)
    TEST_COMMAND    Override auto-detected test command

Fix Levels:
    conservative    Formatting only (whitespace, line endings, imports order)
    moderate        Safe auto-fixes (unused imports, simple lint fixes) [DEFAULT]
    aggressive      All auto-fixable issues (may change code behavior - review!)

Examples:
    $(basename "$0")                           # Default: moderate fixes on staged files
    FIX_LEVEL=conservative $(basename "$0")    # Format only
    CHECK_ONLY=true $(basename "$0")           # Lint without fixing
    STAGED_ONLY=false $(basename "$0")         # Check all changed files (staged + unstaged)
    
Install as Git Hook:
    cp $(basename "$0") .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
EOF
    exit 0
}

detect_test_command() {
    if [[ -n "$TEST_COMMAND" ]]; then
        echo "$TEST_COMMAND"
        return 0
    fi

    if [[ -f "package.json" ]]; then
        echo "npm test"
        return 0
    fi
    if [[ -f "pyproject.toml" || -f "requirements.txt" || -f "requirements-dev.txt" ]]; then
        echo "pytest -q"
        return 0
    fi
    if [[ -f "Cargo.toml" ]]; then
        echo "cargo test"
        return 0
    fi
    if [[ -f "go.mod" ]]; then
        echo "go test ./..."
        return 0
    fi
    if [[ -f "Gemfile" ]]; then
        echo "bundle exec rspec"
        return 0
    fi
    if [[ -f "composer.json" ]]; then
        echo "vendor/bin/phpunit"
        return 0
    fi

    echo ""
}

is_docker_project() {
    [[ -f "Dockerfile" || -f "docker-compose.yml" || -f "docker-compose.yaml" || -f "compose.yml" || -f "compose.yaml" ]]
}

print_test_metrics() {
    local output="$1"
    local status="$2"
    local total="unknown"
    local passed="unknown"
    local failed="unknown"

    if [[ "$output" =~ Tests:[[:space:]]*([0-9]+)[[:space:]]+passed,[[:space:]]*([0-9]+)[[:space:]]+total ]]; then
        passed="${BASH_REMATCH[1]}"
        total="${BASH_REMATCH[2]}"
        failed="$((total - passed))"
    elif [[ "$output" =~ ([0-9]+)[[:space:]]+passed ]] || [[ "$output" =~ ([0-9]+)[[:space:]]+failed ]]; then
        local passed_match
        local failed_match
        passed_match=$(echo "$output" | grep -Eo '[0-9]+[[:space:]]+passed' | tail -1 | awk '{print $1}')
        failed_match=$(echo "$output" | grep -Eo '[0-9]+[[:space:]]+failed' | tail -1 | awk '{print $1}')

        [[ -n "$passed_match" ]] && passed="$passed_match"
        [[ -n "$failed_match" ]] && failed="$failed_match"
        [[ -z "$failed_match" && -n "$passed_match" ]] && failed="0"

        if [[ "$passed" =~ ^[0-9]+$ && "$failed" =~ ^[0-9]+$ ]]; then
            total="$((passed + failed))"
        fi
    elif [[ "$output" =~ ([0-9]+)[[:space:]]+passed ]]; then
        passed="${BASH_REMATCH[1]}"
        failed="0"
        total="$passed"
    fi

    if [[ "$status" == "PASS" ]]; then
        print_success "Tests: Total: $total | Passed: $passed | Failed: $failed | Status: PASS"
    else
        print_error "Tests: Total: $total | Passed: $passed | Failed: $failed | Status: FAIL"
    fi
}

run_test_guardrail() {
    [[ "$RUN_TESTS" != "true" ]] && {
        print_warning "Skipping tests (RUN_TESTS=false)"
        return 0
    }

    local detected_cmd
    detected_cmd=$(detect_test_command)
    if [[ -z "$detected_cmd" ]]; then
        print_warning "No known test command detected; set TEST_COMMAND to enforce tests"
        return 0
    fi

    local run_cmd
    local environment
    if is_docker_project; then
        environment="docker"
        print_status "Docker project detected; enforcing containerized test execution"
        if ! command -v docker &>/dev/null; then
            print_error "Docker project detected but docker CLI is unavailable"
            ((ERRORS++)) || true
            return 1
        fi
        if [[ ! -f "docker-compose.yml" && ! -f "docker-compose.yaml" && ! -f "compose.yml" && ! -f "compose.yaml" ]]; then
            print_error "Docker project detected but no compose file found for test execution"
            ((ERRORS++)) || true
            return 1
        fi
        run_cmd="docker compose run --rm -e TEST_COMMAND=\"$detected_cmd\" tests"
    else
        environment="native"
        run_cmd="$detected_cmd"
    fi

    print_status "Running tests in $environment environment"
    print_status "Command: $run_cmd"

    local test_output
    if test_output=$(eval "$run_cmd" 2>&1); then
        echo "$test_output"
        print_test_metrics "$test_output" "PASS"
    else
        echo "$test_output"
        print_test_metrics "$test_output" "FAIL"
        ((ERRORS++)) || true
        return 1
    fi

    return 0
}

[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && show_help

# =============================================================================
# File Detection
# =============================================================================
declare -a CHANGED_FILES=()
declare -A FILES_BY_TYPE

get_changed_files() {
    print_status "Detecting changed files..."
    
    if [[ "$STAGED_ONLY" == "true" ]]; then
        # Get staged files
        while IFS= read -r file; do
            [[ -f "$file" ]] && CHANGED_FILES+=("$file")
        done < <(git diff --cached --name-only --diff-filter=ACMR 2>/dev/null || true)
    else
        # Get all changed files (staged + unstaged)
        while IFS= read -r file; do
            [[ -f "$file" ]] && CHANGED_FILES+=("$file")
        done < <(git diff --name-only --diff-filter=ACMR HEAD 2>/dev/null || true)
        
        # Also include untracked files
        while IFS= read -r file; do
            [[ -f "$file" ]] && CHANGED_FILES+=("$file")
        done < <(git ls-files --others --exclude-standard 2>/dev/null || true)
    fi
    
    if [[ ${#CHANGED_FILES[@]} -eq 0 ]]; then
        print_success "No changed files to process"
        exit 0
    fi
    
    print_status "Found ${#CHANGED_FILES[@]} changed file(s)"
}

classify_files() {
    print_status "Classifying files by type..."
    
    for file in "${CHANGED_FILES[@]}"; do
        local ext="${file##*.}"
        local basename_file
        basename_file=$(basename "$file")
        local file_type=""
        
        # Determine file type by extension
        case "$ext" in
            py|pyi) file_type="python" ;;
            js|jsx|mjs|cjs) file_type="javascript" ;;
            ts|tsx) file_type="typescript" ;;
            go) file_type="go" ;;
            rs) file_type="rust" ;;
            c|cpp|cc|cxx|h|hpp|hxx) file_type="cpp" ;;
            java) file_type="java" ;;
            kt|kts) file_type="kotlin" ;;
            rb|rake) file_type="ruby" ;;
            php) file_type="php" ;;
            sh|bash|zsh) file_type="shell" ;;
            sql) file_type="sql" ;;
            md|markdown) file_type="markdown" ;;
            yaml|yml) file_type="yaml" ;;
            json) file_type="json" ;;
            toml) file_type="toml" ;;
            tf|tfvars) file_type="terraform" ;;
            ipynb) file_type="notebook" ;;
            R|r|Rmd) file_type="r" ;;
            *) 
                # Check by filename pattern
                case "$basename_file" in
                    Dockerfile*|*.dockerfile) file_type="dockerfile" ;;
                    Gemfile|Rakefile) file_type="ruby" ;;
                    Makefile|makefile|GNUmakefile) file_type="makefile" ;;
                    .eslintrc*|.prettierrc*) file_type="json" ;;
                    *) file_type="unknown" ;;
                esac
                ;;
        esac
        
        # Special path-based detection
        if [[ "$file" == *".github/workflows/"* ]]; then
            file_type="github_actions"
        elif [[ "$file" == *"/k8s/"* || "$file" == *"/kubernetes/"* || "$file" == *"/manifests/"* ]]; then
            [[ "$ext" == "yaml" || "$ext" == "yml" ]] && file_type="kubernetes"
        fi
        
        # Add to type bucket
        if [[ -n "$file_type" && "$file_type" != "unknown" ]]; then
            FILES_BY_TYPE[$file_type]="${FILES_BY_TYPE[$file_type]:-} $file"
            print_debug "  $file -> $file_type"
        else
            print_debug "  $file -> (skipped, unknown type)"
        fi
    done
    
    # Summary
    print_status "File types detected: ${!FILES_BY_TYPE[*]}"
}

# =============================================================================
# Tool Runners
# =============================================================================
ERRORS=0
WARNINGS=0
FIXED=0

run_formatter() {
    local name="$1"
    local cmd="$2"
    shift 2
    local files=("$@")
    
    [[ ${#files[@]} -eq 0 ]] && return 0
    
    # Extract base command for availability check
    local base_cmd="${cmd%% *}"
    if ! command -v "$base_cmd" &>/dev/null; then
        print_warning "Skipping $name (not installed: $base_cmd)"
        return 0
    fi
    
    if [[ "$CHECK_ONLY" == "true" ]]; then
        print_status "Checking with $name..."
        local check_cmd="$cmd"
        # Modify command for check mode where possible
        case "$name" in
            "ruff format") check_cmd="ruff format --check" ;;
            "black") check_cmd="black --check" ;;
            "prettier") check_cmd="prettier --check" ;;
            "gofmt") check_cmd="gofmt -l" ;;
            "cargo fmt") check_cmd="cargo fmt -- --check" ;;
            "shfmt") check_cmd="shfmt -d" ;;
        esac
        
        if ! eval "$check_cmd ${files[*]}" &>/dev/null; then
            print_warning "$name would make changes"
            ((WARNINGS++)) || true
        else
            print_success "$name: no changes needed"
        fi
    else
        print_status "Running $name..."
        if eval "$cmd ${files[*]}" &>/dev/null; then
            print_success "$name applied"
            ((FIXED++)) || true
        else
            print_warning "$name completed with warnings"
        fi
    fi
}

run_linter() {
    local name="$1"
    local cmd="$2"
    shift 2
    local files=("$@")
    
    [[ ${#files[@]} -eq 0 ]] && return 0
    
    local base_cmd="${cmd%% *}"
    if ! command -v "$base_cmd" &>/dev/null; then
        print_warning "Skipping $name (not installed: $base_cmd)"
        return 0
    fi
    
    print_status "Linting with $name..."
    
    local output
    if output=$(eval "$cmd ${files[*]}" 2>&1); then
        print_success "$name: passed"
        return 0
    else
        local line_count
        line_count=$(echo "$output" | wc -l | tr -d ' ')
        print_error "$name: $line_count issue(s)"
        
        # Show first few issues in verbose mode
        if [[ "$VERBOSE" == "true" ]]; then
            echo "$output" | head -10
            [[ $line_count -gt 10 ]] && echo "  ... and $((line_count - 10)) more"
        fi
        
        ((ERRORS++)) || true
        return 1
    fi
}

run_fixer() {
    local name="$1"
    local cmd="$2"
    shift 2
    local files=("$@")
    
    [[ ${#files[@]} -eq 0 ]] && return 0
    [[ "$CHECK_ONLY" == "true" ]] && return 0
    
    local base_cmd="${cmd%% *}"
    if ! command -v "$base_cmd" &>/dev/null; then
        return 0
    fi
    
    print_status "Auto-fixing with $name..."
    if eval "$cmd ${files[*]}" &>/dev/null; then
        print_success "$name: fixes applied"
        ((FIXED++)) || true
    fi
}

# =============================================================================
# Language Handlers
# =============================================================================
process_python() {
    local files_str="${FILES_BY_TYPE[python]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Python (${#files[@]} files) ━━━${NC}"
    
    # Formatters based on fix level
    case "$FIX_LEVEL" in
        conservative)
            run_formatter "ruff format" "ruff format" "${files[@]}"
            run_formatter "isort" "isort" "${files[@]}"
            ;;
        moderate)
            run_formatter "ruff format" "ruff format" "${files[@]}"
            run_formatter "isort" "isort" "${files[@]}"
            run_fixer "ruff fix" "ruff check --fix --select=F401,F841,I" "${files[@]}"
            ;;
        aggressive)
            run_formatter "ruff format" "ruff format" "${files[@]}"
            run_formatter "isort" "isort" "${files[@]}"
            run_fixer "ruff fix (all)" "ruff check --fix --unsafe-fixes" "${files[@]}"
            ;;
    esac
    
    # Always lint
    run_linter "ruff" "ruff check" "${files[@]}"
    run_linter "mypy" "mypy --ignore-missing-imports" "${files[@]}"
}

process_javascript() {
    local files_str="${FILES_BY_TYPE[javascript]:-} ${FILES_BY_TYPE[typescript]:-}"
    [[ -z "${files_str// }" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ JavaScript/TypeScript (${#files[@]} files) ━━━${NC}"
    
    run_formatter "prettier" "prettier --write" "${files[@]}"
    
    if [[ "$FIX_LEVEL" != "conservative" ]]; then
        run_fixer "eslint fix" "eslint --fix" "${files[@]}"
    fi
    
    run_linter "eslint" "eslint" "${files[@]}"
    
    # TypeScript type checking
    local ts_files="${FILES_BY_TYPE[typescript]:-}"
    if [[ -n "$ts_files" ]] && [[ -f "tsconfig.json" ]]; then
        run_linter "tsc" "tsc --noEmit"
    fi
}

process_go() {
    local files_str="${FILES_BY_TYPE[go]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Go (${#files[@]} files) ━━━${NC}"
    
    run_formatter "gofmt" "gofmt -w" "${files[@]}"
    
    if [[ "$FIX_LEVEL" != "conservative" ]]; then
        run_formatter "goimports" "goimports -w" "${files[@]}"
    fi
    
    run_linter "golangci-lint" "golangci-lint run" "${files[@]}"
}

process_rust() {
    local files_str="${FILES_BY_TYPE[rust]:-}"
    [[ -z "$files_str" ]] && return 0
    
    echo ""
    echo -e "${CYAN}━━━ Rust ━━━${NC}"
    
    if [[ -f "Cargo.toml" ]]; then
        run_formatter "cargo fmt" "cargo fmt --"
        
        if [[ "$FIX_LEVEL" != "conservative" && "$CHECK_ONLY" != "true" ]]; then
            run_fixer "clippy fix" "cargo clippy --fix --allow-dirty --allow-staged"
        fi
        
        run_linter "cargo clippy" "cargo clippy -- -D warnings"
    fi
}

process_cpp() {
    local files_str="${FILES_BY_TYPE[cpp]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ C/C++ (${#files[@]} files) ━━━${NC}"
    
    run_formatter "clang-format" "clang-format -i" "${files[@]}"
    run_linter "cppcheck" "cppcheck --enable=warning,style,performance --error-exitcode=1" "${files[@]}"
}

process_java() {
    local files_str="${FILES_BY_TYPE[java]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Java (${#files[@]} files) ━━━${NC}"
    
    if command -v google-java-format &>/dev/null; then
        run_formatter "google-java-format" "google-java-format -i" "${files[@]}"
    fi
}

process_kotlin() {
    local files_str="${FILES_BY_TYPE[kotlin]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Kotlin (${#files[@]} files) ━━━${NC}"
    
    run_formatter "ktlint" "ktlint -F" "${files[@]}"
    run_linter "ktlint" "ktlint" "${files[@]}"
}

process_ruby() {
    local files_str="${FILES_BY_TYPE[ruby]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Ruby (${#files[@]} files) ━━━${NC}"
    
    case "$FIX_LEVEL" in
        aggressive)
            run_formatter "rubocop" "rubocop -A" "${files[@]}"
            ;;
        *)
            run_formatter "rubocop" "rubocop -a" "${files[@]}"
            ;;
    esac
    
    run_linter "rubocop" "rubocop" "${files[@]}"
}

process_php() {
    local files_str="${FILES_BY_TYPE[php]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ PHP (${#files[@]} files) ━━━${NC}"
    
    if [[ "$FIX_LEVEL" == "aggressive" ]]; then
        run_formatter "php-cs-fixer" "php-cs-fixer fix --risky" "${files[@]}"
    else
        run_formatter "php-cs-fixer" "php-cs-fixer fix" "${files[@]}"
    fi
    
    run_linter "phpstan" "phpstan analyse --error-format=raw" "${files[@]}"
}

process_shell() {
    local files_str="${FILES_BY_TYPE[shell]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Shell (${#files[@]} files) ━━━${NC}"
    
    run_formatter "shfmt" "shfmt -w -i 4" "${files[@]}"
    run_linter "shellcheck" "shellcheck" "${files[@]}"
}

process_sql() {
    local files_str="${FILES_BY_TYPE[sql]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ SQL (${#files[@]} files) ━━━${NC}"
    
    run_formatter "sqlfluff" "sqlfluff fix" "${files[@]}"
    run_linter "sqlfluff" "sqlfluff lint" "${files[@]}"
}

process_docker() {
    local files_str="${FILES_BY_TYPE[dockerfile]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Dockerfile (${#files[@]} files) ━━━${NC}"
    
    run_linter "hadolint" "hadolint" "${files[@]}"
}

process_terraform() {
    local files_str="${FILES_BY_TYPE[terraform]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Terraform (${#files[@]} files) ━━━${NC}"
    
    run_formatter "terraform fmt" "terraform fmt" "${files[@]}"
    run_linter "tflint" "tflint" "${files[@]}"
    run_linter "tfsec" "tfsec --soft-fail" "${files[@]}"
}

process_kubernetes() {
    local files_str="${FILES_BY_TYPE[kubernetes]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Kubernetes (${#files[@]} files) ━━━${NC}"
    
    run_formatter "prettier" "prettier --write" "${files[@]}"
    run_linter "kubeconform" "kubeconform" "${files[@]}"
}

process_yaml() {
    local files_str="${FILES_BY_TYPE[yaml]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ YAML (${#files[@]} files) ━━━${NC}"
    
    run_formatter "prettier" "prettier --write" "${files[@]}"
    run_linter "yamllint" "yamllint -f parsable" "${files[@]}"
}

process_json() {
    local files_str="${FILES_BY_TYPE[json]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ JSON (${#files[@]} files) ━━━${NC}"
    
    run_formatter "prettier" "prettier --write" "${files[@]}"
    
    # Validate JSON syntax
    for file in "${files[@]}"; do
        if ! jq empty "$file" 2>/dev/null; then
            print_error "Invalid JSON: $file"
            ((ERRORS++)) || true
        fi
    done
}

process_toml() {
    local files_str="${FILES_BY_TYPE[toml]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ TOML (${#files[@]} files) ━━━${NC}"
    
    run_formatter "taplo" "taplo fmt" "${files[@]}"
    run_linter "taplo" "taplo lint" "${files[@]}"
}

process_markdown() {
    local files_str="${FILES_BY_TYPE[markdown]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Markdown (${#files[@]} files) ━━━${NC}"
    
    run_formatter "prettier" "prettier --write" "${files[@]}"
    run_linter "markdownlint" "markdownlint-cli2" "${files[@]}"
}

process_notebook() {
    local files_str="${FILES_BY_TYPE[notebook]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ Jupyter Notebooks (${#files[@]} files) ━━━${NC}"
    
    # Strip outputs
    run_formatter "nbstripout" "nbstripout" "${files[@]}"
    
    if [[ "$FIX_LEVEL" != "conservative" ]]; then
        run_formatter "nbqa ruff" "nbqa ruff format" "${files[@]}"
        run_fixer "nbqa ruff fix" "nbqa ruff check --fix" "${files[@]}"
    fi
    
    run_linter "nbqa ruff" "nbqa ruff check" "${files[@]}"
}

process_github_actions() {
    local files_str="${FILES_BY_TYPE[github_actions]:-}"
    [[ -z "$files_str" ]] && return 0
    
    local files=($files_str)
    
    echo ""
    echo -e "${CYAN}━━━ GitHub Actions (${#files[@]} files) ━━━${NC}"
    
    run_formatter "prettier" "prettier --write" "${files[@]}"
    run_linter "actionlint" "actionlint" "${files[@]}"
}

# =============================================================================
# Universal Checks
# =============================================================================
run_universal_checks() {
    echo ""
    echo -e "${CYAN}━━━ Universal Checks ━━━${NC}"
    
    # Secrets detection on all changed files
    if command -v gitleaks &>/dev/null; then
        print_status "Checking for secrets..."
        if ! gitleaks protect --staged --no-banner 2>/dev/null; then
            print_error "CRITICAL: Potential secrets detected!"
            ((ERRORS++)) || true
        else
            print_success "No secrets detected"
        fi
    fi
    
    # Spelling check (warning only, don't fail)
    if command -v codespell &>/dev/null && [[ ${#CHANGED_FILES[@]} -gt 0 ]]; then
        print_status "Checking spelling..."
        local spell_output
        if ! spell_output=$(codespell "${CHANGED_FILES[@]}" 2>/dev/null); then
            local spell_count
            spell_count=$(echo "$spell_output" | wc -l | tr -d ' ')
            print_warning "Spelling issues: $spell_count"
            if [[ "$VERBOSE" == "true" ]]; then
                echo "$spell_output" | head -5
            fi
            # Don't increment errors for spelling
        else
            print_success "No spelling issues"
        fi
    fi
}

# =============================================================================
# Re-stage Fixed Files
# =============================================================================
restage_files() {
    if [[ "$CHECK_ONLY" != "true" && "$STAGED_ONLY" == "true" && $FIXED -gt 0 ]]; then
        print_status "Re-staging fixed files..."
        
        for file in "${CHANGED_FILES[@]}"; do
            if [[ -f "$file" ]]; then
                git add "$file" 2>/dev/null || true
            fi
        done
        
        print_success "Fixed files re-staged for commit"
    fi
}

# =============================================================================
# Main
# =============================================================================
main() {
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║     Agentic Pre-Commit Hook                ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  Fix Level:   ${YELLOW}$FIX_LEVEL${NC}"
    echo -e "  Mode:        ${YELLOW}$([ "$CHECK_ONLY" == "true" ] && echo "Check Only" || echo "Fix & Check")${NC}"
    echo -e "  Scope:       ${YELLOW}$([ "$STAGED_ONLY" == "true" ] && echo "Staged Files" || echo "All Changed")${NC}"
    echo ""
    
    get_changed_files
    classify_files
    
    # Process each file type
    process_python
    process_javascript
    process_go
    process_rust
    process_cpp
    process_java
    process_kotlin
    process_ruby
    process_php
    process_shell
    process_sql
    process_docker
    process_terraform
    process_kubernetes
    process_yaml
    process_json
    process_toml
    process_markdown
    process_notebook
    process_github_actions
    
    run_universal_checks
    run_test_guardrail
    restage_files
    
    # Summary
    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║     Summary                                ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  Files processed: ${GREEN}${#CHANGED_FILES[@]}${NC}"
    echo -e "  Fixes applied:   ${GREEN}$FIXED${NC}"
    echo -e "  Warnings:        ${YELLOW}$WARNINGS${NC}"
    echo -e "  Errors:          ${RED}$ERRORS${NC}"
    echo ""
    
    if [[ $ERRORS -gt 0 ]]; then
        echo -e "${RED}╔════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║  Pre-commit FAILED - $ERRORS error(s) found       ║${NC}"
        echo -e "${RED}╚════════════════════════════════════════════╝${NC}"
        echo ""
        echo "Fix the errors above before committing."
        echo "Run with VERBOSE=true for more details."
        echo ""
        
        if [[ "$FAIL_ON_ERROR" == "true" ]]; then
            exit 1
        fi
    else
        echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║  All checks passed! Ready to commit.       ║${NC}"
        echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
        echo ""
        exit 0
    fi
}

main "$@"
