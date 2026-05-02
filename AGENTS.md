# AGENTS.md

## Project purpose
- Inferred from `README.md`: 🚀 Rigour Vibe: Complete Development Methodology 🧪

## Repository facts
- GitHub: `EthanMacDonald/Rigour_Vibe`
- Default branch: `main`
- Local Hermes workspace: `/home/ethan/agent-os/workspaces/github/Rigour_Vibe`
- Visibility: `public`
- Agent permissions observed: `pull,push,triage`

## Tech stack signals
- unknown

## Setup
- No dependency install command was detected during onboarding.

## Test / lint / build
- No automated test/lint/build command was detected during onboarding.

## Development workflow for Hermes
- Use the GitHub agent identity `agentvitahelm-bit` / `agent.vitahelm@gmail.com`.
- Work on feature branches only; branch names should start with `hermes/`.
- Do not push directly to the default branch unless Ethan explicitly asks.
- Prefer small, reviewable PRs with clear summaries and test results.
- For behavior changes and bug fixes, add or update tests before implementation when practical.
- Do not commit secrets, tokens, `.env` files, build artifacts, or local machine state.

## Pull request checklist
- [ ] Changes are scoped to the requested task.
- [ ] Relevant tests/lint/build commands were run, or limitations are explained in the PR.
- [ ] PR description includes summary, test plan, and risk notes.
- [ ] Ethan reviews/approves before merge.

## Known gaps
- This file was generated from repository inspection and should be refined with project-specific details as they become known.

<!-- BEGIN HERMES REPO OPERATING STANDARD -->

## Hermes repo operating standard

Version: `2026-04-27.1`

### Autonomy boundaries
- Allowed without extra approval: inspect code, create plans, run tests, create branches, commit to `hermes/*` branches, and open draft PRs.
- Requires Ethan approval: merge PRs, deploy, change production secrets, alter billing/auth/security controls, delete data, force-push, or run destructive migrations.

### Required workflow
1. Start from the default branch and create a focused `hermes/*` branch.
2. For behavior changes, write or update tests before implementation when practical.
3. Run relevant local checks before pushing.
4. Open a PR with summary, test evidence, and risk notes.
5. Leave final merge/deploy decisions to Ethan unless he explicitly delegates them.

### Standard documentation
- `docs/architecture.md` describes project architecture and risk boundaries.
- `docs/testing.md` describes local and CI quality gates.
- `docs/plans/` stores PRDs, technical designs, and implementation plans.

### Current detected quality commands
  - `echo 'No automated checks detected yet; add tests and update docs/testing.md.'`

<!-- END HERMES REPO OPERATING STANDARD -->
