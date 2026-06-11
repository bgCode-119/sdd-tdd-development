# Trigger Benchmark Playbook

This file is for measuring whether the `sdd-tdd-development` description triggers at the right times.

## What this trigger set is testing

### Positive triggers

The skill should trigger for:

- new feature implementation
- bugfix with verification
- API / component work with behavior definition
- production "quick code" prompts that still need discipline
- conceptual SDD/TDD questions

### Negative triggers

The skill should not be the primary match for:

- generic summarization
- image generation
- browser automation
- legacy-safe refactor requests that should route to `legacy-safe-refactor`

## Why one query is intentionally negative

`"Refactor this five-year-old checkout module without changing behavior."`

This is deliberately close. It helps test whether the main skill overtriggers on a prompt that should instead prefer the narrower legacy refactor skill.

## Suggested run commands

From a workspace where `claude -p` is available:

```powershell
python C:\Users\14865\.codex\skills\skill-creator\scripts\run_eval.py `
  --eval-set E:\code\AI-code\.agents\skills\sdd-tdd-development\evals\trigger-evals.json `
  --skill-path E:\code\AI-code\.agents\skills\sdd-tdd-development `
  --runs-per-query 3 `
  --trigger-threshold 0.5 `
  --verbose
```

Optimization loop:

```powershell
python C:\Users\14865\.codex\skills\skill-creator\scripts\run_loop.py `
  --eval-set E:\code\AI-code\.agents\skills\sdd-tdd-development\evals\trigger-evals.json `
  --skill-path E:\code\AI-code\.agents\skills\sdd-tdd-development `
  --runs-per-query 3 `
  --trigger-threshold 0.5 `
  --max-iterations 5 `
  --holdout 0.4 `
  --model <model-name> `
  --verbose
```

## What good results look like

- Positive prompts trigger reliably
- The legacy-safe prompt undertriggers here
- Generic non-coding prompts stay negative

## Common failures

- Undertrigger on "quick code" prompts
- Overtrigger on generic refactor prompts that should belong to the child skill
- Overtrigger on any coding-adjacent prompt just because it contains "API" or "refactor"

