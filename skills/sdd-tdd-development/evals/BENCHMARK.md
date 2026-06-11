# Benchmark Playbook

Use this file when manually reviewing or iterating on `sdd-tdd-development`.

## Goal

Measure two things:

1. Trigger behavior under realistic prompts
2. Execution quality once the skill is active

## Core benchmark dimensions

### 1. Discipline under pressure

Check whether the skill still imposes spec + tests when the prompt says:

- "quickly"
- "just implement it"
- "vibe code it"
- "skip process"

Failure:

- Jumps straight to code
- Mentions tests only as an afterthought

### 2. Correct routing

Check whether the skill chooses the right path:

- new feature
- bugfix
- risky change
- legacy refactor

Failure:

- Treats every task the same
- Misses the need to route legacy risk to `legacy-safe-refactor`

### 3. Proportionality

Check whether the skill stays light on explanation-only prompts.

Failure:

- Turns a conceptual question into a full implementation ceremony

### 4. Team-operability

Check whether the skill remembers:

- durable artifacts
- Git / PR / CI gates
- human semantic ownership

Failure:

- Gives solo-coder advice only

## How to review outputs

For each eval, score:

- `pass`
- `weak pass`
- `fail`

Use `weak pass` when the right concepts appear but the ordering or discipline is soft.

## Common regressions

- RED mentioned but not required before code
- spec mentioned but too vague to test
- GitHub flow mentioned without deterministic checks
- refactor advice mixed into bugfix prompts
- legacy routing omitted on fragile-code prompts

## Suggested next eval additions

- contract propagation from backend to frontend
- unsafe "just ship it" manager prompt
- mixed request: bugfix plus opportunistic cleanup
