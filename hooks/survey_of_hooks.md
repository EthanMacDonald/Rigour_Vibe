# PRE-COMMIT / PRE-PUSH TOOLING CHECKLIST (THOROUGH MENU)

**Goal:** Run the fastest, highest-signal checks automatically before committing (and heavier ones before pushing or in CI).

---

## 0) UNIVERSAL (LANGUAGE-AGNOSTIC) BASICS

### A. Formatting (auto-fix where possible)
- General whitespace / EOF fixer (trim trailing spaces, ensure newline at EOF)
- Line ending normalization (LF vs CRLF)
- EditorConfig compliance (editorconfig-checker)

### B. Linting (style + correctness)
- General-purpose lints (language-specific below)
- "No TODO/FIXME in main branch" checks (optional)
- Spelling / prose lint (docs + comments)
  - codespell
  - misspell
  - typos (crate) or Vale (docs style)

### C. Static analysis / correctness checks
- Language-specific static analyzers
- "Unused/dead code" checks (where available)
- Cyclomatic complexity threshold checks (optional)

### D. Tests (fast subset locally)
- Unit tests / "smoke" tests subset
- Snapshot tests (if used)
- Doctests (if relevant)

### E. Security / secrets / supply-chain
- Secret scanning (gitleaks, trufflehog)
- Dependency vulnerability scan (language ecosystem tools)
- SAST where available (semgrep, codeql in CI)
- License checks (optional)

### F. Repo hygiene
- Validate config files parse (YAML/JSON/TOML)
- Validate docs build (optional)
- Enforce commit message policy (commitlint / conventional commits) (optional)

---

## 1) GIT/REPO HOOK HELPERS

- pre-commit (framework to run many checks consistently)
- lefthook (fast hooks runner)
- husky (Node-oriented hooks runner)
- lint-staged (run checks only on staged files)
- overcommit (Ruby-ish hook manager)
- git hooks + Makefile / justfile / task runner (simple custom)

---

## 2) CONFIG/FILE VALIDATORS (GOOD FOR ANY REPO)

- yamllint (YAML)
- check-json / jq -e (JSON validity)
- toml sort/validate (taplo for TOML)
- dotenv-linter (.env)
- actionlint (GitHub Actions workflows)
- shellcheck (shell scripts) + shfmt (shell formatting)
- markdownlint-cli2 (Markdown) + prettier for md
- vale (docs style guide enforcement)
- swagger/openapi validator (if you have OpenAPI specs)
- protobuf lint/format (buf) (if you use protobuf)
- terraform fmt + tflint + tfsec (if Terraform)
- dockerfilelint / hadolint (Dockerfiles)
- helm lint + kubeval/kubeconform (K8s manifests)

---

## 3) PYTHON (PICK A STACK)

### Formatting
- ruff format (or Black)
- isort (if not using ruff's import rules)

### Linting / style / correctness
- ruff (fast, replaces many flake8 plugins)
- flake8 (classic) + plugins (if not using ruff)
- pylint (deeper, sometimes noisier)

### Typing / static checks
- mypy
- pyright (often faster, strong type checking)
- pydocstyle (docstring conventions)
- interrogate (docstring coverage) (optional)

### Security
- bandit (basic)
- pip-audit (dependencies)
- safety (dependencies, commercial options exist)
- detect-secrets (or gitleaks) for secrets

### Tests / quality
- pytest (unit tests)
- coverage.py (coverage thresholds)
- hypothesis (property-based tests) (optional)
- tox / nox (multi-env test automation)

### Packaging/build sanity
- python -m compileall (syntax check)
- build (PEP517 build)
- twine check (distribution metadata)

---

## 4) JAVASCRIPT / TYPESCRIPT (NODE)

### Formatting
- prettier

### Linting / correctness
- eslint (with typescript-eslint for TS)
- stylelint (CSS/SCSS)
- eslint-plugin-security (optional)

### Type checking / build
- tsc --noEmit (TypeScript)
- vue-tsc (Vue)
- next lint / framework-specific checks

### Tests
- vitest / jest / mocha
- playwright / cypress (often pre-push / CI)

### Dependencies / security
- npm audit / pnpm audit / yarn audit
- audit-ci (enforce thresholds)
- depcheck (unused deps)
- license-checker (optional)
- lockfile-lint (optional policies)

---

## 5) GO

### Formatting
- gofmt
- goimports

### Linting / static analysis
- golangci-lint (bundle: govet, staticcheck, etc.)
- staticcheck
- govet

### Security
- gosec
- govulncheck

### Tests
- go test ./...
- go test -race (pre-push/CI)
- coverage (go test -coverprofile)

---

## 6) RUST

### Formatting
- rustfmt (cargo fmt)

### Linting
- clippy (cargo clippy)

### Tests
- cargo test
- cargo nextest (faster, optional)

### Security / dependencies
- cargo audit
- cargo deny (licenses/advisories)
- cargo outdated (optional)

---

## 7) C / C++ (AND CMAKE PROJECTS)

### Formatting
- clang-format

### Linting / static analysis
- clang-tidy (very common)
- cppcheck
- include-what-you-use (optional)

### Build + warnings policy
- compile with -Wall -Wextra -Werror (or project equivalent)
- cmake configure + build in a clean dir

### Security / hardening (more CI-ish)
- sanitizers: ASan/UBSan/TSan (often pre-push/CI)
- CodeQL (CI)

### Tests
- ctest
- unit test frameworks (gtest, Catch2) via build target

---

## 8) JAVA / KOTLIN

### Formatting
- spotless (often wraps google-java-format / ktfmt)
- google-java-format
- ktlint / detekt (Kotlin)

### Linting / static analysis
- checkstyle
- PMD
- spotbugs

### Build/test
- mvn test / gradle test
- gradle check

### Security/deps
- OWASP dependency-check
- gradle versions plugin (optional)

---

## 9) C# / DOTNET

### Formatting
- dotnet format

### Linting / analyzers
- Roslyn analyzers
- StyleCop analyzers
- Sonar analyzers (often CI)

### Build/test
- dotnet build
- dotnet test

### Security/deps
- dotnet list package --vulnerable

---

## 10) RUBY

### Formatting/Lint
- rubocop (includes formatting + linting)

### Security
- brakeman (Rails)
- bundler-audit

### Tests
- rspec / minitest

---

## 11) PHP

### Formatting
- php-cs-fixer

### Lint/static analysis
- phpstan
- psalm

### Security
- composer audit

### Tests
- phpunit

---

## 12) R

### Formatting/Lint
- styler
- lintr

### Checks/tests
- R CMD check
- testthat

---

## 13) SQL / DATA

### SQL lint/format
- sqlfluff (works across dialects)
- pgFormatter (Postgres formatting)

### Data contracts / schema
- dbt test (dbt projects)
- great_expectations (data validation)

---

## 14) NOTEBOOKS (JUPYTER)

### Cleanup/format
- nbstripout (remove output before commit)
- jupyter nbconvert --clear-output
- black-nb / ruff (with notebook support via tools or export)
- nbqa (run flake8/black/isort/ruff over notebooks)

### Validation
- papermill (execute notebooks) (often pre-push/CI)

---

## 15) SECURITY / SECRETS (REALLY IMPORTANT)

### Secrets scanning (pre-commit)
- gitleaks
- trufflehog
- detect-secrets

### SAST (usually pre-push or CI, but can run locally)
- semgrep
- CodeQL (usually CI)

### Dependency scanning (language-specific above + general)
- osv-scanner (Open Source Vulnerabilities)
- syft + grype (SBOM + vulnerability scan)
- trivy (containers + deps, often CI/pre-push)

---

## 16) CONTAINERS / K8S / INFRA

### Docker
- hadolint (Dockerfile lint)
- docker build (smoke build)
- trivy image scan (pre-push/CI)
- dockerfile formatting (optional)

### Kubernetes/Helm
- kubeconform / kubeval (schema validation)
- helm lint
- kustomize build (validation)

### Terraform
- terraform fmt
- terraform validate
- tflint
- tfsec (or trivy config)

---

## 17) DOCUMENTATION / MARKDOWN / SPELLING

- markdownlint
- prettier (for md)
- vale (style)
- codespell / typos (spelling)
- link checker (markdown-link-check) (often pre-push/CI)
- doc build (mkdocs build / docusaurus build / sphinx-build) (pre-push/CI)

---

## 18) "QUALITY GATES" YOU CAN ENFORCE

- **Block commit if:**
  - formatter would change files
  - lint errors exist
  - typecheck fails
  - fast tests fail
  - secrets detected
  - config invalid (YAML/JSON/TOML)
- **Block push (or run in CI) if:**
  - full test suite fails
  - coverage below threshold
  - vuln scan fails severity threshold
  - build/release packaging checks fail

---

## 19) PRACTICAL DEFAULT STACKS (GOOD STARTERS)

### Python "modern minimal"
- ruff (lint + import rules) + ruff format (or black)
- pyright or mypy
- pytest (+ coverage)
- gitleaks

### Node/TS "common"
- prettier
- eslint + tsc --noEmit
- unit tests (vitest/jest)
- npm audit (often CI) + gitleaks

### Go "standard"
- gofmt + goimports
- golangci-lint
- go test ./...
- govulncheck + gitleaks

### Rust "standard"
- cargo fmt
- cargo clippy
- cargo test
- cargo audit + gitleaks

### C/C++ "practical"
- clang-format
- clang-tidy
- build with warnings-as-errors
- unit tests + (sanitizers pre-push/CI)
- gitleaks

---

## 20) WHERE TO RUN WHAT (SPEED-BASED)

### Fast pre-commit (seconds)
- format staged files
- lint staged files
- typecheck (if fast)
- unit smoke tests
- secrets scan staged diff

### Heavier pre-push / CI (minutes)
- full test suite
- coverage thresholds
- race/sanitizers
- SAST (semgrep/codeql)
- full dependency + container scans
- docs build + link checking

---

## 21) EXTRA NICE-TO-HAVES

- Conventional commit checker (commitlint)
- Changelog enforcement (optional)
- "No large files" / Git LFS policy checks
- License header checkers
- Generated code consistency (buf generate / openapi codegen diff check)

---

**END**
