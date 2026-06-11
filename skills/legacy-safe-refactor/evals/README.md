# Eval Guide

This file explains what the `legacy-safe-refactor` evals are designed to prove.

## What these evals cover

### Eval 1: Read-first behavior

Checks that the skill chooses read-only analysis as the first move.

Signals we want:

- No immediate edits
- Entry points and responsibilities
- State map or hidden-contract awareness

Bad failure mode:

- "Start by splitting the file"

### Eval 2: Behavior-locking safety net

Checks that the skill creates a current-state spec and characterization tests before cleanup.

Signals we want:

- Current-state framing
- Test net before refactor
- Side effects and suspicious legacy quirks treated as part of the behavior surface

Bad failure mode:

- Converting desired future behavior into tests
- Fixing old quirks by assumption

### Eval 3: Verified small-slice refactor

Checks that the skill performs refactor in controlled slices with explicit stop conditions.

Signals we want:

- Small slices
- Stable public API
- Tests rerun after each slice
- Stop conditions
- Git / PR traceability plus human merge judgment

Bad failure mode:

- Big-bang rewrite
- Refactor continuing despite unclear API or flaky tests

## Manual benchmark checklist

Ask:

1. Did the skill refuse to edit before understanding?
2. Did it preserve current behavior as the primary contract?
3. Did it treat hidden state and hidden contracts as first-class risk?
4. Did it constrain the refactor into reviewable slices?
5. Did it define when to stop rather than pushing through uncertainty?

## Upgrade ideas

Future eval additions worth considering:

- Multi-file circular import scenario
- Event/audit/log side-effect preservation
- PR-note quality for unchanged suspicious behavior

