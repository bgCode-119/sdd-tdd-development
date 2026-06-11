# Trigger Benchmark Playbook

This file is for measuring whether the `legacy-safe-refactor` description triggers only for the brittle-old-code cases it should own.

## What this trigger set is testing

### Positive triggers

The skill should trigger for:

- safe legacy refactor requests
- read-old-code-first requests
- god file / god class untangling
- hidden side effects / hidden imports in fragile code
- "clean it up without breaking behavior" requests on old code

### Negative triggers

The skill should not be the primary match for:

- greenfield feature work
- small isolated bugfixes
- conceptual explanation-only questions
- diagram generation
- browser testing

## Important boundary test

`"Build a brand new payments API from scratch with spec and tests."`

This should stay negative here. If it triggers positive, the child skill is eating greenfield work that belongs to the broader `sdd-tdd-development` skill.

## Suggested run commands

```powershell
python C:\Users\14865\.codex\skills\skill-creator\scripts\run_eval.py `
  --eval-set E:\code\AI-code\.agents\skills\legacy-safe-refactor\evals\trigger-evals.json `
  --skill-path E:\code\AI-code\.agents\skills\legacy-safe-refactor `
  --runs-per-query 3 `
  --trigger-threshold 0.5 `
  --verbose
```

Optimization loop:

```powershell
python C:\Users\14865\.codex\skills\skill-creator\scripts\run_loop.py `
  --eval-set E:\code\AI-code\.agents\skills\legacy-safe-refactor\evals\trigger-evals.json `
  --skill-path E:\code\AI-code\.agents\skills\legacy-safe-refactor `
  --runs-per-query 3 `
  --trigger-threshold 0.5 `
  --max-iterations 5 `
  --holdout 0.4 `
  --model <model-name> `
  --verbose
```

## What good results look like

- Old-code preservation prompts trigger reliably
- Greenfield prompts stay negative
- Explanation-only prompts stay negative

## Common failures

- Overtrigger on any mention of "tests"
- Overtrigger on ordinary bugfixes
- Undertrigger when the user says "clean it up" but implies legacy risk

