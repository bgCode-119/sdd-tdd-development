# Runbook

This runbook explains how to execute both evaluation layers for `sdd-tdd-development`.

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

Use these when you want to test whether the skill description triggers correctly.

## Windows trigger smoke command

Use `cmd`, not PowerShell, for the launch wrapper.

Workspace now includes local `E:\code\AI-code\claude.cmd` shim so worker processes can resolve `claude` from workspace cwd.

```cmd
python E:\code\AI-code\.agents\skills\scripts\run_eval_windows.py --eval-set E:\code\AI-code\.agents\skills\sdd-tdd-development\evals\trigger-evals.json --skill-path E:\code\AI-code\.agents\skills\sdd-tdd-development --runs-per-query 1 --timeout 20 --verbose
```

Shortcut:

```cmd
E:\code\AI-code\.agents\skills\scripts\run-sdd-trigger-eval.cmd
```

## Fuller trigger run

```cmd
python E:\code\AI-code\.agents\skills\scripts\run_eval_windows.py --eval-set E:\code\AI-code\.agents\skills\sdd-tdd-development\evals\trigger-evals.json --skill-path E:\code\AI-code\.agents\skills\sdd-tdd-development --runs-per-query 3 --timeout 30 --trigger-threshold 0.5 --verbose
```

## Trigger optimization loop

`run_loop.py` is still upstream-only. Use it only after Windows runner compatibility is confirmed or after creating a Windows-specific loop wrapper.

## Observed local issues

### Issue 1: Permission denied to `C:\Users\<user>\.claude\commands`

Observed when launching from the `skill-creator` directory.

Meaning:

- `run_eval.py` discovered a project root outside the writable workspace
- it tried to create temporary command files under the user home `.claude`

Preferred fix:

- run from the writable workspace root instead

### Issue 2: `WinError 2` from `run_eval.py`

Observed even after moving the run into the workspace.

Meaning:

- the child worker process failed to spawn `claude`
- this is a runner/environment issue first, not immediate evidence of a bad description

Checks:

1. Run `cmd /c "claude --version"` manually
2. Confirm `claude.cmd` exists on `PATH`
3. Confirm workspace-local `E:\code\AI-code\claude.cmd` exists
4. Re-run from `cmd`, not PowerShell wrapper syntax

## Interpreting smoke results

Before trusting any trigger score, run canary:

```cmd
python E:\code\AI-code\.agents\skills\scripts\run_eval_windows.py --eval-set E:\code\AI-code\.agents\skills\trigger-canary\evals\trigger-evals.json --skill-path E:\code\AI-code\.agents\skills\trigger-canary --runs-per-query 1 --timeout 20 --verbose
```

If canary exact-match query still returns `0/1`, stop. Do not tune description yet.

If all positives come back `0/1` and all negatives pass:

- do not conclude the description is bad yet
- first rule out runner failure

If the runner is healthy:

- low positive triggers mean undertrigger
- positive legacy-refactor prompts on this skill mean overtrigger

## Recommended sequence

1. Run smoke trigger eval with `runs-per-query 1`
2. Fix runner issues first
3. Run full trigger eval with `runs-per-query 3`
4. Iterate description with `run_loop`
5. Only after trigger quality is acceptable, spend time on execution benchmarking
