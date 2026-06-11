# Eval Guide

This file explains what the `sdd-tdd-development` evals are trying to catch.

## What these evals cover

### Eval 1: New feature discipline

Checks that the skill does not jump straight to implementation when asked to build a feature.

Signals we want:

- Task classification
- Small reviewable spec
- Checks before code
- Explicit RED -> GREEN -> REFACTOR
- Durable artifact updates

Bad failure mode:

- "Here is the code" without spec or RED evidence

### Eval 2: Legacy-safe path selection

Checks that the skill routes old risky code into structure mapping plus characterization tests instead of cleanup-first behavior.

Signals we want:

- Read-only pass
- Current-state spec
- Hidden state / hidden contract awareness
- Characterization tests
- Small verified slices

Bad failure mode:

- Immediate rewrite advice
- Treating suspicious legacy behavior as an automatic bugfix

### Eval 3: Team pipeline and governance

Checks that the skill defines a deterministic issue-to-merge workflow instead of hand-wavy "review it later."

Signals we want:

- Issue -> branch -> commit -> PR
- Deterministic checks
- Human semantic ownership
- Failure-feedback loop
- No mixed-scope PRs

Bad failure mode:

- Trusting AI review alone
- No CI gate

## Manual benchmark checklist

When reviewing outputs manually, ask:

1. Did the skill slow down before risky implementation?
2. Did it create a testable spec, not just a summary?
3. Did it insist on RED before code?
4. Did it distinguish safe refactor from behavior change?
5. Did it define what humans still own?

## Upgrade ideas

Future eval additions worth considering:

- Contract propagation from backend spec to frontend client
- Separate bugfix vs refactor routing
- "Quick code" anti-pattern prompt to test undertrigger pressure

