# Runbook

This runbook explains how to execute both evaluation layers for `legacy-safe-refactor`.

## 1. Execution evals

Files involved:

- `evals/evals.json`
- `evals/README.md`
- `evals/BENCHMARK.md`

Use these when the skill is already active and you want to grade output quality.

## 2. Trigger evals

Files involved:

- `evals/trigger-evals.json`
- `evals/TRIGGER-BENCHMARK.md`

Use these when you want to test whether the child skill triggers only for the brittle-old-code prompts it should own.

## Windows trigger smoke command

Workspace now includes local `E:\code\AI-code\claude.cmd` shim so worker processes can resolve `claude` from workspace cwd.

```cmd
python E:\code\AI-code\.agents\skills\scripts\run_eval_windows.py --eval-set E:\code\AI-code\.agents\skills\legacy-safe-refactor\evals\trigger-evals.json --skill-path E:\code\AI-code\.agents\skills\legacy-safe-refactor --runs-per-query 1 --timeout 20 --verbose
```

Shortcut:

```cmd
E:\code\AI-code\.agents\skills\scripts\run-legacy-trigger-eval.cmd
```

## Fuller trigger run

```cmd
python E:\code\AI-code\.agents\skills\scripts\run_eval_windows.py --eval-set E:\code\AI-code\.agents\skills\legacy-safe-refactor\evals\trigger-evals.json --skill-path E:\code\AI-code\.agents\skills\legacy-safe-refactor --runs-per-query 3 --timeout 30 --trigger-threshold 0.5 --verbose
```

## Trigger optimization loop

`run_loop.py` is still upstream-only. Use it only after Windows runner compatibility is confirmed or after creating a Windows-specific loop wrapper.

## Boundary expectation

The most important negative query is the greenfield one:

- `"Build a brand new payments API from scratch with spec and tests."`

If that triggers here, the child skill is too broad and is stealing work from `sdd-tdd-development`.

## Observed local issues

The same two Windows issues observed on the parent skill apply here:

1. launching from the wrong cwd can push temporary command files into user-home `.claude`
2. `run_eval.py` child workers may still hit `WinError 2` even when `claude --version` works in `cmd`

Treat runner health as a prerequisite before interpreting trigger scores.

Before trusting any trigger score, run canary:

```cmd
python E:\code\AI-code\.agents\skills\scripts\run_eval_windows.py --eval-set E:\code\AI-code\.agents\skills\trigger-canary\evals\trigger-evals.json --skill-path E:\code\AI-code\.agents\skills\trigger-canary --runs-per-query 1 --timeout 20 --verbose
```

If canary exact-match query still returns `0/1`, stop. Do not tune description yet.

## Recommended sequence

1. Run smoke trigger eval with `runs-per-query 1`
2. Confirm the runner is healthy
3. Run full trigger eval with `runs-per-query 3`
4. Tune description only after runner problems are eliminated
5. Then move on to execution benchmarking
