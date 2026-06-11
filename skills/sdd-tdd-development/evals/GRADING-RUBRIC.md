# Grading Rubric

Use this rubric when grading execution evals for `sdd-tdd-development`.

## Pass

Mark `pass` only when output shows clear sequence discipline:

1. task classification
2. small spec or acceptance criteria
3. checks before implementation
4. RED before code
5. minimum GREEN
6. refactor only after green
7. durable artifact updates when relevant

## Weak pass

Use `weak pass` when right ideas appear but execution is soft:

- mentions tests but not before code
- mentions spec but too vague to verify
- mentions RED/GREEN but not as hard gates
- remembers CI or PR gates but forgets human ownership

## Fail

Fail when any of these dominate:

- jumps straight to implementation
- no spec or acceptance criteria
- no RED gate
- no verification loop
- treats risky work as casual quick-code
- routes legacy-safe cases without behavior-locking discipline

## Discriminating assertions

Prefer assertions that force sequence, not keyword presence.

Good:

- "The response requires proving RED before production code"
- "The response distinguishes current-state lock from intended behavior change"

Weak:

- "The response mentions tests"
- "The response mentions CI"

