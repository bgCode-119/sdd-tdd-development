---
name: legacy-safe-refactor
description: Safe legacy refactor and characterization-test workflow for old brittle code. Use whenever user asks to safely refactor old code, split a god file or god class, untangle a large module, preserve behavior while cleaning up, map hidden side effects, understand legacy code before editing, or add feature tests / characterization tests before refactor. Trigger on phrases like legacy code, old code, fragile module, hidden imports, hidden state, safe refactor, behavior-preserving cleanup, current-state spec, or read first then refactor. Do not wait for user to mention characterization tests explicitly. For greenfield feature work or ordinary small bugfixes, prefer `sdd-tdd-development`.
version: 0.2.1
---

# Legacy Safe Refactor

This skill is for changing structure without accidentally changing behavior.

Default stance:

- First understand, then lock behavior, then refactor
- Treat hidden coupling as part of the system, not noise
- Prefer many small safe slices over one "clean" rewrite
- Suspicious legacy behavior is not automatically a bugfix

## When to use this skill

Use it when:

- The code is old, brittle, or poorly documented
- A module has side effects, globals, or strange imports
- The user wants a safe refactor, not a product behavior change
- AI is likely to miss hidden dependencies if it edits immediately
- The repo needs feature tests before any cleanup

Do not use this as the main skill for greenfield feature work. Use `sdd-tdd-development` for that broader path.

Best paired with:

- `sdd-tdd-development` for general feature or bug workflows
- this skill when the dominant risk is hidden coupling in legacy code

## Workflow

### Phase 1: Read-only structure pass

Before changing any file, produce:

1. Entry-point list
2. Responsibility map
3. State map
4. Hidden-contract list
5. Suspicious-behavior list

Look for:

- Public APIs and public import paths
- DB writes, cache writes, config reads, event emissions, audit logs
- Circular imports
- Module-level mutable state
- Duplicate implementations or multiple sources of truth
- Downstream callers that bypass the intended public API

Do not refactor in this phase.

### Phase 2: Current-state spec

Write down what the module does today.

Required sections:

- Goal of the module as it behaves now
- Current entry points
- Input/output shapes
- State mutations and side effects
- Known quirks or suspicious behavior
- Non-goal for this refactor: preserve external behavior unless explicitly told otherwise

This is not the desired future design. It is the current contract snapshot.

### Phase 3: Characterization tests

Before refactor, lock the current behavior.

Cover:

1. Happy path
2. Boundary conditions
3. Error or rejection paths
4. Side effects
5. Legacy quirks that callers may rely on

Rules:

- Reset DB, globals, cache, and config between tests
- Reset clocks, env-dependent flags, process singletons, and other mutable runtime state when they affect behavior
- Keep tests repeatable
- Assert visible side effects such as events, audit logs, and writes, not only return values
- If tests are flaky, stop and stabilize them before refactor
- Do not slip bugfixes into this phase

### Phase 4: Safe refactor slices

Only after characterization tests are stable and green:

1. Pick one responsibility block
2. Keep public API stable
3. Extract one helper, function, or module at a time
4. Rerun relevant tests after each slice
5. If red, stop, explain the behavior drift, and revert or isolate that slice before changing more code

Allowed refactor moves:

- Extract functions
- Rename internals
- Move logic behind stable entry points
- Separate responsibilities
- Reduce duplication

Not allowed by default:

- Changing behavior because it "looks wrong"
- Mixing feature work into refactor slices
- Large multi-file rewrites without a tight test net

Slice budget:

- One responsibility block, one call path, or one extraction move per slice
- If a slice grows across multiple responsibilities or too many files, split it before continuing
- Do not stack a second refactor hypothesis on top of a failing slice

### Phase 4.5: Behavior-fix quarantine

If a branch or rounding rule looks wrong while refactoring:

1. Lock current behavior first
2. Record the suspected bug separately
3. Get explicit approval before changing that behavior
4. Prefer a separate bugfix issue, spec, or PR from the structural refactor

Safe refactor default: preserve behavior first, then fix behavior intentionally.

### Phase 5: Git and merge safety

Use Git as part of the refactor method.

Required flow:

1. Branch for the refactor slice
2. Small traceable commits
3. PR explains what stayed the same and what was intentionally not fixed
4. Deterministic verification before merge
5. Human decides merge

PR must state:

- Which behavior was locked by tests
- Which structural area changed
- Which suspicious behaviors remain intentionally unchanged
- What risks still need human judgment

## Stop conditions

Stop and re-scope if any are true:

- Public API surface is still unclear
- Tests are flaky or not isolated
- Hidden state is unmapped
- Refactor diff is becoming hard to review
- A "safe refactor" is actually turning into a behavior change
- A suspected bugfix is being mixed into the structural cleanup path

## Done criteria

The refactor is done only when:

- Characterization tests still pass
- Public API is stable unless explicitly changed
- Behavior surface is preserved
- Diff is reviewable
- Spec / notes / PR explain unchanged quirks

## No-go rules

Never:

- Read and refactor in the same first pass
- Fix suspicious logic without explicit approval
- Start from "ideal design" instead of current behavior
- Trust a single green run if the suite is flaky
- Expand the change because "we are already in this file"

## Recommended response shape

1. Current task classification
2. Read-only findings
3. Current-state spec summary
4. Characterization test plan
5. Safe refactor slice plan
6. Behavior-fix quarantine note when needed
7. Verification plan
8. Merge / risk notes

## References

Prompt templates live in `references/prompt-templates.md`.

Eval prompts live in `evals/evals.json`.

Benchmark guidance lives in `evals/BENCHMARK.md`.
