# Benchmark Playbook

Use this file when manually reviewing or iterating on `legacy-safe-refactor`.

## Goal

Prove that the skill protects fragile old code from AI overconfidence.

## Core benchmark dimensions

### 1. Read-before-write discipline

Check whether the skill starts with understanding:

- entry points
- responsibilities
- hidden state
- hidden contracts

Failure:

- suggests file splitting or cleanup immediately

### 2. Behavior preservation

Check whether the skill preserves current behavior as the default contract.

Failure:

- rewrites toward ideal future design first
- assumes suspicious legacy logic should be fixed automatically

### 3. Test-net quality

Check whether the skill demands characterization tests before refactor.

Failure:

- only asks for unit tests on refactored helpers
- ignores side effects or legacy quirks

### 4. Slice control

Check whether the skill constrains the refactor into small reviewable steps.

Failure:

- recommends big-bang cleanup
- omits stop conditions

### 5. Boundary clarity

Check whether the skill knows when not to be the primary workflow.

Failure:

- tries to own greenfield feature work instead of routing to broader SDD + TDD flow

## How to review outputs

For each eval, score:

- `pass`
- `weak pass`
- `fail`

Mark `weak pass` when the skill says the right words but does not enforce the sequence strongly.

## Common regressions

- read-only pass skipped
- current-state spec omitted
- suspicious behavior treated as confirmed bug
- no mention of state isolation
- no stop condition when tests are flaky or API surface is unclear

## Suggested next eval additions

- multi-file circular import legacy module
- audit log / event emission preservation
- PR note quality for “intentionally unchanged” quirks
