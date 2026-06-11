---
name: sdd-tdd-development
description: 'Spec-Driven Development (SDD) and Test-Driven Development (TDD) for AI coding. Use whenever user asks to implement or change production code: build feature, fix bug, add API or endpoint, create component, change business logic, write acceptance criteria, add regression tests, or make AI-generated code safe to merge. Trigger on requests about spec-first development, tests-first development, RED/GREEN/REFACTOR, safe AI coding, code review, CI-gated changes, or "quick code" / "vibe code" that still needs correctness. Do not wait for user to mention SDD or TDD explicitly. For fragile legacy code where preserving current behavior is primary risk, pair with `legacy-safe-refactor`.'
version: 0.3.0
---

# SDD + TDD Development

This skill turns AI coding from "looks right" into "can be checked."

Core split:

- SDD answers "what counts as correct?"
- TDD turns "correct" into machine-checkable evidence
- AI writes implementation fastest in the middle
- Humans still own boundaries, acceptance, risk, and final merge decisions

Skill boundary:

- Use this skill for the general SDD + TDD operating model
- Use `legacy-safe-refactor` when the main risk is preserving existing behavior in old or brittle code

Prefer durable artifacts over chat memory:

- `Rules`: team conventions, guardrails, forbidden moves
- `Spec`: intended behavior, boundaries, non-goals
- `Tests`: executable proof
- `Contracts`: OpenAPI / GraphQL / proto / schema / typed client
- `Git + CI`: traceability and merge gates

## Step 0: Classify the task

Pick the lightest workflow that is still safe.

### A. Small bug, expected behavior already clear

Use:

1. Regression test first
2. Minimal fix
3. Rerun relevant checks
4. Update spec/docs only if externally visible behavior changed

### B. New feature or intentional behavior change

Use:

1. Write spec before implementation
2. Review the spec quickly
3. Derive tests from the spec
4. Implement only after RED is proven

### C. Legacy safe refactor

Use:

1. Read-only structure pass first
2. Write current-state spec
3. Lock current behavior with characterization / feature tests
4. Refactor in small slices
5. Do not "fix" suspicious old behavior inside the refactor slice unless the user explicitly wants that behavior change

### D. Large change touching public APIs, architecture boundaries, or risky business flows

Slow down on purpose:

1. Define boundaries first
2. Make acceptance criteria explicit
3. Split into smaller units
4. Put Git/CI gates in place before widening scope

If scope still feels fuzzy, do not start implementation yet.

## Card routing

Route the task to the matching action card and use that card's done criteria.

| Situation | Primary card |
|---|---|
| Read legacy code before touching it | `01 Architecture Readthrough` |
| Lock current behavior before refactor | `02 Characterization Tests` |
| Do a small safe refactor | `03 Safe Refactor` |
| Multi-file module has hidden coupling | `04 Structure Mapping` |
| Turn one-off specs into repo memory | `05 Spec-Issue Governance` |
| Move AI changes through team workflow | `06 GitHub AI Pipeline` |
| Run a repeatable generate-verify-correct loop | `07 Quality Flywheel` |

Detailed cards live in `references/action-cards.md`.

## Step 1: Write or refresh the spec

The spec must be human-reviewable in minutes, not a long essay.

Write behavior, not implementation preference.

Use this structure:

```md
# Feature / Change
## Goal
## In scope
## Out of scope
## Inputs
## Outputs
## Rules and validations
## Edge cases
## Error cases
## Acceptance criteria
```

Spec rules:

- Keep it short enough for fast review
- Focus on "how it should behave," not "which framework to use"
- Every rule must be verifiable by a test, type check, schema check, or explicit manual review item
- Rewrite vague statements into measurable ones

Examples:

- Bad: "performance should be good"
- Better: "P99 latency stays under 200ms for this endpoint under defined test conditions"

- Bad: "title cannot be weird"
- Better: "title is required, trimmed before validation, and must be 1-100 chars after trimming"

## Step 2: Turn the spec into checks

Choose the cheapest strong evidence first.

Possible layers:

- Static checks: typecheck, lint, schema validation
- Unit tests: rules, helpers, transformations
- Integration tests: API, DB, service boundaries
- E2E tests: critical user workflows
- Characterization / feature tests: lock current legacy behavior before refactor
- Contract checks: generated schema, typed client, mock compatibility

Minimum test planning:

1. Happy path
2. Boundary conditions
3. Invalid input
4. Failure paths
5. Regression cases

For legacy systems, also capture:

1. Hidden couplings
2. Side effects
3. Historical quirks that may look wrong but are currently relied on

## Step 3: RED before code

Before touching production code:

1. Write the failing test or failing contract/static check
2. Run the relevant target
3. Confirm failure is for the intended reason

Valid RED means one of these is true:

- The new test executes and fails for the missing / incorrect behavior
- The new contract or type rule fails because the intended behavior is not yet implemented

Invalid RED examples:

- Broken test harness
- Unrelated syntax errors
- Dependency install failure
- Old unrelated failing tests that hide the real signal

Do not edit production code until RED is real.

## Step 4: GREEN with minimum implementation

After RED:

1. Make the smallest production change that can satisfy the failing check
2. Rerun the same relevant target
3. Stop when it turns green

Keep the change narrow:

- Smallest useful diff
- Avoid opportunistic rewrites
- Avoid side quests

## Step 5: REFACTOR after green

Only refactor after the relevant checks are green.

Allowed moves:

- Improve names
- Remove duplication
- Extract helpers / modules
- Clarify control flow
- Improve maintainability

Rules:

- Keep behavior stable unless spec intentionally changed
- Rerun tests after each slice
- If the diff gets large, split the work
- If a slice breaks behavior, revert the slice instead of widening the change blindly

## Legacy refactor playbook

For big old codebases, first delivery is often understanding, not code.

Ask AI to do a read-only pass and return:

1. Public APIs / entry points
2. Responsibility map
3. State map: DB, globals, caches, files, events
4. Hidden couplings and suspicious behaviors

Then:

1. Convert current behavior into a current-state spec
2. Write characterization tests to lock it in
3. Refactor one responsibility block at a time
4. Keep old entry points stable where possible
5. If tests fail, prefer reverting the last step over asking AI to "just keep fixing things"

Important: suspicious behavior is not automatically a bugfix task.

Legacy refactor default deliverables:

1. Entry-point list
2. Responsibility map
3. State map
4. Suspicious-behavior list
5. Current-state spec
6. Stable characterization tests

Legacy refactor stop conditions:

- Test suite is flaky
- State isolation is missing
- Public API surface is still unclear
- Hidden coupling is not mapped yet

Do not refactor past these stop signs.

## Multi-file hidden-coupling pass

Use this when code is already split across files but still breaks "from somewhere else."

Produce three artifacts before refactor:

1. Dependency map
2. State map
3. Hidden-contract list

Look specifically for:

- Circular imports
- Module-level mutable state
- Shared config read/write paths
- Event / audit / log format contracts
- Downstream callers bypassing the intended public API

If changing file `A` can silently break file `B`, the hidden contract is part of the behavior surface.

## Contract propagation

When one layer can emit a machine-readable contract, treat that output as the next layer's spec.

Examples:

- Backend `OpenAPI` -> frontend client / forms / validation
- `GraphQL schema` -> typed queries / mocks
- `proto` -> upstream/downstream service contract
- DB schema -> DAO / migration checks

Rules:

- Frontend should not invent fields not present in the contract
- Prefer generated or schema-backed clients when available
- If contract changes, tests and downstream generated artifacts must move with it

## Git and GitHub workflow

Use Git as a safety rail, not just history.

Preferred flow:

1. Start from issue / task / acceptance criteria
2. Isolate risk on a branch
3. Keep commits small and meaningful
4. Open a PR that explains scope, locked behavior, and deliberate non-fixes
5. Let deterministic CI checks gate merge
6. Keep human review for semantic / business / irreversible risk

PR should answer:

- What behavior is intentionally changed?
- What behavior is intentionally unchanged?
- Which tests prove that?
- Which suspicious legacy behaviors were locked but not fixed?

CI rules:

- AI code and human code go through the same gates
- Required checks beat verbal reassurance
- AI review can assist, but must not replace deterministic checks

Minimum PR hygiene:

1. One branch per issue or tightly related change
2. One PR for one coherent story
3. Refactor, bugfix, and new feature do not mix casually
4. Commit messages must preserve traceability
5. CI failure must be fixed from logs, not hand-waved

## Two review gates

Use both:

### Gate 1: AI self-review

Have AI inspect:

- Missing edge cases
- Missing test coverage
- Spec drift
- Silent error paths
- Obvious regressions

### Gate 2: Human final decision

Human must decide on:

- Business semantics
- Money movement
- Destructive / irreversible actions
- Security risk
- Production config changes
- "Code is correct but solves the wrong problem"

## Structured failure feedback

When AI misses, feed concrete evidence back.

Good:

```text
`test_blank_title_rejected_422` failed.
Input: {"title": "   "}
Expected: 422 validation error
Actual: 201 created
Need: trim before empty-check
```

Bad:

```text
Fix the validation bug.
```

Rule:

- Give failing assertion
- Give input
- Give expected result
- Give actual result
- Ask for minimum fix

Use this format whenever possible:

```text
Failure item:
Input:
Expected:
Actual:
Minimal fix:
```

Do not feed back "there is a bug" without evidence.

## Team operating model

AI shifts human work away from typing code and toward:

1. Defining boundaries
2. Defining acceptance criteria
3. Setting gates and rules
4. Reviewing specs and tests
5. Making final merge decisions

This skill should reinforce a reusable repo memory:

- If a mistake is likely to repeat, do not only patch code
- Update `Rules`, `Spec`, or the skill itself

Goal: stop making AI relearn the same lesson every session.

## Definition of done by phase

### Spec phase done

- Scope is clear
- Out-of-scope is written down
- Rules are testable
- Acceptance criteria are explicit

### RED phase done

- New check runs
- Failure is for the intended reason
- No unrelated failure is hiding the signal

### GREEN phase done

- Relevant failing checks now pass
- Change stayed narrow
- No opportunistic redesign slipped in

### Refactor phase done

- Behavior unchanged unless intentionally specified
- Tests remain green
- Diff remains reviewable

### Governance phase done

- Important rules are not trapped in chat
- Spec status matches implementation state
- Issue / PR / tests / docs / spec tell the same story

## No-go rules

Never do these under this skill:

- Read and edit legacy code in the same first pass
- Treat "looks wrong" as enough reason to change behavior
- Start refactor before characterization tests are stable
- Mix bugfixes into behavior-locking test PRs
- Expand scope because a failure suggests nearby cleanup
- Treat AI review as equivalent to required CI
- Claim completion without running verification

## Activation checklist

When this skill triggers, do this in order:

1. Classify task: bug / feature / risky change / legacy refactor
2. Gather only relevant context
3. Write or refresh the spec
4. Derive checks from the spec
5. Prove RED
6. Implement minimum GREEN
7. Refactor only after green
8. Run final verification
9. Update durable artifacts if learning should persist

## Response shape

Unless the user explicitly asks for something else, structure execution around:

1. Task classification
2. Spec or current-state summary
3. Test / verification plan
4. RED evidence
5. Minimal implementation
6. GREEN verification
7. Refactor notes
8. Artifact updates: rules / spec / contract / CI / PR notes

## Prompt templates

Reusable prompt snippets live in `references/prompt-templates.md`.

Action-card summaries live in `references/action-cards.md`.

Eval prompts live in `evals/evals.json`.

Benchmark guidance lives in `evals/BENCHMARK.md`.
