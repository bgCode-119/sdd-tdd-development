# Grading Rubric

Use this rubric when grading execution evals for `legacy-safe-refactor`.

## Pass

Mark `pass` only when output preserves legacy safety order:

1. read-only structure understanding first
2. current-state spec second
3. characterization tests before refactor
4. small verified slices
5. explicit stop conditions
6. no silent behavior fixes

## Weak pass

Use `weak pass` when core ideas appear but not strongly enforced:

- says "understand first" but immediately drifts into redesign
- mentions tests but not characterization tests
- mentions small slices but no stop conditions
- mentions preserving behavior but quietly accepts "fix while refactoring"

## Fail

Fail when any dominate:

- immediate cleanup advice
- future-state design before current-state lock
- no hidden-state or hidden-contract mapping
- no characterization-test requirement
- mixes suspected bugfix into safe refactor path

## Discriminating assertions

Good:

- "The response requires current-state spec rather than target design"
- "The response separates suspicious old behavior from structural refactor"

Weak:

- "The response mentions refactor"
- "The response mentions tests"

