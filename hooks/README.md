# Comprehensive Linting Toolkit

A Docker-based linting environment containing **all tools** from the [survey of hooks](survey_of_hooks.md), plus intelligent scripts for brownfield codebase analysis and agentic pre-commit workflows.

## Features

- **50+ linting/formatting tools** across 15+ languages
- **Brownfield analyzer** - Generate detailed health reports for existing codebases
- **Agentic pre-commit hook** - Smart file-type detection with configurable fix levels
- **Docker-first test guardrails** - Docker projects run tests in containers before commit
- **Test status reporting** - Prints test totals/status when detectable
- **Docker-based** - Consistent environment, no local installation required
- **Three fix levels** - Conservative, moderate, and aggressive auto-fixing

## Quick Start

### 1. Build the Docker Image

```bash
cd hooks/docker
docker build -t linting-toolkit -f Dockerfile.linting .
```

Or use docker-compose:

```bash
docker compose build
```

### 2. Analyze a Codebase

Generate a comprehensive health report for an existing project:

```bash
# Using docker-compose
TARGET_DIR=/path/to/your/project docker compose run analyze

# Or directly with docker
docker run -v /path/to/project:/workspace -v $(pwd)/reports:/output \
    linting-toolkit bash /scripts/analyze_codebase.sh /workspace
```

The report is saved to `./reports/codebase_health_report.md`

### 3. Run Pre-Commit Hook

Check and fix changed files before committing:

```bash
# Using docker-compose (checks all files, not just staged)
TARGET_DIR=/path/to/project docker compose run precommit

# Format only (conservative)
TARGET_DIR=/path/to/project docker compose run format

# Check only (no modifications)
TARGET_DIR=/path/to/project docker compose run check
```

### 3a. Enforced Test Guardrail

`agentic_precommit.sh` now enforces test execution as part of pre-commit:

1. Detects Docker markers (`Dockerfile`, `docker-compose.yml`, `docker-compose.yaml`, `compose.yml`, `compose.yaml`)
2. If Docker markers exist, runs tests in Docker using the `tests` compose service
3. If Docker markers do not exist, runs native tests
4. Blocks commit when tests fail

Example:

```bash
TARGET_DIR=/path/to/project TEST_COMMAND="npm test" docker compose run precommit
```

### 4. Interactive Shell

Access all tools interactively:

```bash
TARGET_DIR=/path/to/project docker compose run lint
```

## Fix Levels

| Level | Description | When to Use |
|-------|-------------|-------------|
| `conservative` | Formatting only: whitespace, line endings, import ordering | CI/CD pipelines, team-wide standards |
| `moderate` | Safe auto-fixes: unused imports, simple lint fixes | **Default** - Daily development |
| `aggressive` | All auto-fixable issues, may change code behavior | Major cleanups - **review changes!** |

```bash
# Examples
FIX_LEVEL=conservative docker compose run precommit
FIX_LEVEL=aggressive docker compose run precommit
```

## Install as Git Hook

To use the agentic pre-commit hook in your project:

```bash
# Copy the script
cp hooks/scripts/agentic_precommit.sh /path/to/project/.git/hooks/pre-commit
chmod +x /path/to/project/.git/hooks/pre-commit

# Or create a wrapper that uses Docker
cat > /path/to/project/.git/hooks/pre-commit << 'EOF'
#!/bin/bash
docker run --rm -v "$(pwd)":/workspace -w /workspace \
    linting-toolkit bash /scripts/agentic_precommit.sh
EOF
chmod +x /path/to/project/.git/hooks/pre-commit
```

## Tools Included

### Python
| Category | Tools |
|----------|-------|
| Formatting | ruff format, black, isort |
| Linting | ruff, flake8, pylint |
| Type Checking | mypy, pyright |
| Security | bandit, pip-audit, safety |
| Testing | pytest, coverage, hypothesis |
| Docs | pydocstyle, interrogate |

### JavaScript / TypeScript
| Category | Tools |
|----------|-------|
| Formatting | prettier |
| Linting | eslint, @typescript-eslint, stylelint |
| Type Checking | tsc |
| Dependencies | depcheck, license-checker, lockfile-lint |

### Go
| Category | Tools |
|----------|-------|
| Formatting | gofmt, goimports |
| Linting | golangci-lint, staticcheck |
| Security | gosec, govulncheck |

### Rust
| Category | Tools |
|----------|-------|
| Formatting | rustfmt |
| Linting | clippy |
| Security | cargo-audit, cargo-deny |
| Testing | cargo-nextest |

### C/C++
| Category | Tools |
|----------|-------|
| Formatting | clang-format |
| Linting | clang-tidy, cppcheck |

### Java/Kotlin
| Category | Tools |
|----------|-------|
| Formatting | google-java-format, ktlint |
| Linting | checkstyle, PMD, spotbugs |

### Ruby
rubocop, brakeman, bundler-audit

### PHP
php-cs-fixer, phpstan, psalm

### R
styler, lintr

### Shell
shellcheck, shfmt

### SQL
sqlfluff

### Infrastructure
| Category | Tools |
|----------|-------|
| Docker | hadolint, trivy |
| Terraform | terraform fmt, tflint, tfsec |
| Kubernetes | kubeconform, helm lint |
| GitHub Actions | actionlint |

### Universal
| Category | Tools |
|----------|-------|
| Secrets | gitleaks, trufflehog |
| Spelling | codespell, typos |
| Config | yamllint, taplo (TOML) |
| Docs | markdownlint, vale |
| Commits | commitlint |

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `TARGET_DIR` | `.` | Directory to analyze/lint |
| `OUTPUT_DIR` | `./lint-reports` | Report output directory |
| `FIX_LEVEL` | `moderate` | Auto-fix aggressiveness |
| `SKIP_SECURITY` | `false` | Skip security scans |
| `CHECK_ONLY` | `false` | Lint without fixing |
| `STAGED_ONLY` | `true` | Only check git staged files |
| `VERBOSE` | `false` | Show detailed output |
| `PARALLEL_JOBS` | `4` | Parallel analysis jobs |
| `RUN_TESTS` | `true` | Run tests during pre-commit |
| `TEST_COMMAND` | auto-detect | Override detected test command |

### Tool Mappings

File type to tool mappings are defined in [config/tool_mappings.yaml](config/tool_mappings.yaml). You can customize which tools run for each file type and fix level.

The mapping file now includes `test_runners.local` and `test_runners.docker` entries for major languages to support Docker-first enforcement.

## Report Output

The brownfield analyzer generates a detailed Markdown report including:

- **Executive Summary** - Total files, issues, health score
- **Files by Type** - Breakdown of file extensions
- **Issues by Category** - Grouped by language/tool with severity
- **Detailed Findings** - Actual lint output (truncated)
- **Recommended Actions** - Prioritized fix suggestions
- **Auto-Fix Commands** - Copy-paste commands to fix issues

Example health score:
- 🟢 90-100: Excellent
- 🟡 70-89: Good  
- 🟠 50-69: Needs Attention
- 🔴 0-49: Critical

## Language-Specific Commands

Run linting for specific languages:

```bash
# Python
docker compose run python

# JavaScript/TypeScript
docker compose run javascript

# Go
docker compose run golang

# Rust
docker compose run rust

# Security scan only
docker compose run security
```

## Troubleshooting

### Build fails
The Docker image is large (~5GB) due to all the language runtimes. Ensure you have enough disk space.

### Tool not found
Some tools are optional. The scripts handle missing tools gracefully with warnings.

### Slow analysis
For large codebases:
```bash
# Skip security scans (faster)
SKIP_SECURITY=true docker compose run analyze

# Increase parallelism
PARALLEL_JOBS=8 docker compose run analyze
```

### Permission issues
Ensure the mounted directories are readable/writable:
```bash
chmod -R 755 /path/to/project
```

## File Structure

```
hooks/
├── README.md                 # This file
├── survey_of_hooks.md        # Original tools survey
├── config/
│   └── tool_mappings.yaml    # File type → tool mappings
├── docker/
│   ├── Dockerfile.linting    # Multi-stage Dockerfile
│   └── docker-compose.yml    # Service definitions
└── scripts/
    ├── analyze_codebase.sh   # Brownfield analyzer
    └── agentic_precommit.sh  # Pre-commit hook
```

## Contributing

1. Add new tools to `Dockerfile.linting`
2. Update mappings in `config/tool_mappings.yaml`
3. Add handlers in the shell scripts
4. Update this README

## License

MIT
