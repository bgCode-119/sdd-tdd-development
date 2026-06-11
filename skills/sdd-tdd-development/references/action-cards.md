# Action Cards

Condensed execution cards derived from the legacy-refactor and team-workflow materials.

## 01. Architecture Readthrough

Use when:

- AI is about to touch legacy code
- Entry points or behavior surface are still unclear

Input:

- One function, class, module, or directory
- Known business entry point
- Optional: existing tests, issues, runtime errors

AI actions:

1. Read only, do not edit
2. List public APIs and downstream-visible entry points
3. Split responsibilities
4. Draw a state map: DB, globals, cache, config, events, logs, external services
5. List duplicate truths, parallel implementations, and suspicious behaviors
6. Suggest where characterization tests are needed first

Human review:

- Check missing entry points
- Check hidden state
- Separate "lock first" from "maybe fix later"

Done when:

- Entry-point list exists
- Responsibility map exists
- State map exists
- Suspicious behaviors are listed

Forbidden:

- Reading and editing in one pass
- Fixing "weird-looking" behavior immediately

## 02. Characterization Tests

Use when:

- Legacy behavior must be frozen before refactor

Input:

- Current-state spec
- Candidate legacy entry points
- Suspicious-behavior list

AI actions:

1. Write current-state behavior spec
2. Generate characterization / feature tests
3. Cover happy path, boundaries, old entry points, side effects, suspicious behaviors
4. Reset DB / globals / cache before tests
5. Make tests stable and repeatable

Human review:

- Confirm tests lock current behavior, not desired future behavior
- Confirm suspicious behavior is preserved intentionally
- Confirm isolation is real

Done when:

- Tests are green and repeatable
- Each suspicious behavior has coverage
- Spec and tests describe the same current state

Forbidden:

- Sneaking bugfixes into characterization work
- Starting refactor on flaky tests

## 03. Safe Refactor

Use when:

- Characterization tests are already green

Input:

- Current-state spec
- Stable characterization tests
- Mapped public APIs and state

AI actions:

1. Keep current public API stable
2. Refactor one responsibility block at a time
3. Extract small helpers or modules
4. Run tests after each slice
5. If red, explain the behavior drift before fixing

Human review:

- Check diff size
- Check imports, outputs, events, logs, API paths
- Check no accidental behavior change slipped in

Done when:

- Behavior tests remain green
- Public API remains stable
- Diff is reviewable and scoped

Forbidden:

- Mixing refactor with new features
- Huge file moves without behavior net

## 04. Structure Mapping

Use when:

- Code is split into files but still coupled through hidden state or imports

Input:

- Directory or module cluster

AI actions:

1. Build dependency map
2. Build state map
3. List hidden contracts: public import paths, log/event formats, implicit call paths
4. Call out circular imports and module globals

Human review:

- Validate cross-file hidden dependencies
- Confirm which import paths are externally relied on

Done when:

- You can explain why changing file A breaks file B

Forbidden:

- Jumping to redesign before mapping contracts

## 05. Spec-Issue Governance

Use when:

- One-off specs need to become lasting project memory

Input:

- Current specs
- Tests
- Issue list
- Team rules

AI actions:

1. Create or refresh `AGENTS.md`
2. Organize `spec/` states: `governance/`, `planned/`, `implemented/`, `archived/`
3. Turn one-off spec into tracked spec files
4. Classify issues: local bug, design change, compatibility change, shared root cause
5. Create merge-time spec reconciliation checklist

Human review:

- Confirm rules belong in durable files, not only chat
- Confirm spec state matches code reality

Done when:

- Spec has lifecycle state
- Issues map to spec gaps or existing contracts

Forbidden:

- Letting code change while spec stays stale

## 06. GitHub AI Pipeline

Use when:

- AI-generated changes must enter shared mainline safely

Input:

- GitHub repo
- Issue / PR templates
- Branch rules
- CI commands

AI actions:

1. Restate issue goal, acceptance criteria, and untouched scope
2. Work on isolated branch
3. Keep commits small and traceable
4. Open PR with scope, risks, and verification
5. Run CI-equivalent local checks
6. Fix failures from logs with minimum scope

Human review:

- Verify issue quality
- Verify PR tells one story
- Verify required checks and required review are enforced

Done when:

- Issue -> branch -> commit -> PR is traceable
- Required checks are green
- Human review decides merge

Forbidden:

- Merging red CI
- Treating AI review as merge gate

## 07. Quality Flywheel

Use when:

- You want repeatable AI engineering, not one lucky run

Input:

- Issue or task
- Spec / rules
- Tests / CI
- Review workflow

AI actions:

1. Generate minimum implementation from spec
2. Verify with tests, lint, typecheck, workflow
3. Correct from structured failures
4. Record validation results in PR or change notes

Human review:

- Define acceptance criteria first
- Review evidence, not just AI explanation
- Decide semantic or business questions

Done when:

- Every output has matching verification
- Failures can be fed back and rerun
- Team can repeat the loop

Forbidden:

- Claiming done because AI said so
- Skipping verification between iterations
