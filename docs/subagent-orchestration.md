# Rigour Vibe Subagent Orchestration

This document describes the additive subagent workflow for Rigour Vibe. It is designed to preserve the existing human-click-through task list workflow and Code Approver-style review.

## Design Goal

Rigour Vibe should continue to work in three modes:

1. **Human-clickable mode** — a user opens a task list and works through visible checkboxes in order.
2. **Subagent-assisted mode** — Hermes uses implementer/reviewer/tester subagents to execute the same approved tasks.
3. **Code-approver-review mode** — a reviewer evaluates durable artifacts: PRD, tasks, diffs, tests, summaries, evidence, and commits.

Subagent orchestration is therefore **additive metadata**, not a replacement for existing task steps.

## Core Flow

```text
Intent
→ Discovery
→ PRD
→ PRD review
→ Task list
→ Task review
→ Human approval
→ Implement
→ Spec review
→ Quality/security review
→ Test/validation
→ Evidence
→ Commit
→ Integration review
→ Release readiness review
→ Human approval for production actions
```

## Backwards-Compatibility Rules

- Keep checkbox-based tasks and sub-tasks readable top-to-bottom.
- Keep task IDs, result lines, evidence paths, and commit-message requirements stable.
- Do not hide implementation requirements inside subagent-only prose.
- Do not require `delegate_task` runtime state for Code Approver review.
- Durable markdown artifacts remain the source of truth.
- Put automation routing in an optional `Agent Handoff` block.

## Agent Handoff Block

Use this block after normal task steps for Balanced Rigor / Full Rigor work or when the user requests subagents.

```markdown
### Agent Handoff

Mode: Human-clickable | Subagent-assisted | Code-approver-review

Implementer:
- Allowed files:
- Forbidden files:
- Objective:
- Required tests/validation:
- Evidence to update:

Spec Reviewer:
- Check approved requirements, allowed files, acceptance criteria, and evidence.
- Output: PASS or FAIL with exact gaps.

Quality/Security Reviewer:
- Check correctness, maintainability, security, edge cases, regressions, and test adequacy.
- Output: Critical / Important / Minor and APPROVED or REQUEST_CHANGES.

Tester/Validator:
- Run or inspect targeted validation commands when relevant.

Parent Hermes:
- Verify files, git diff, test output, evidence, and no unexpected changes before marking complete.
```

## Execution Loop

For each approved task:

1. Implementer subagent implements only the assigned task.
2. Spec reviewer compares the diff against the approved task spec.
3. Quality/security reviewer runs only after spec review passes.
4. Tester/validator checks non-trivial validation, deployment-adjacent changes, or security-sensitive work.
5. Parent Hermes verifies durable evidence and commits.

## Code Approver Compatibility

Code Approver should be able to approve or reject from durable artifacts alone:

- PRD under `directives/prd/`
- task list under `directives/tasks/`
- test specifications under `directives/tests/`
- summaries under `directives/summaries/`
- git/PR diff
- test output and result lines
- commits and commit messages

Subagent outputs may be summarized in evidence files, but they are not evidence by themselves unless copied into durable artifacts.

## Production Safety

Agents may prepare production artifacts such as code, tests, deployment scaffolds, dry-run scripts, and runbooks. They must stop for explicit approval before external side effects such as billing/API enablement, secrets, public deploys, DNS/OAuth changes, production data changes, user routing, or unsafe concurrency changes.
