# Execution Runbook

Use this runbook for manual execution benchmarking of `legacy-safe-refactor`.

## Goal

Judge whether skill protects brittle old code from cleanup-first behavior.

## Suggested workspace

Use shared template:

- `E:\code\AI-code\.agents\skills\shared-evals\workspace-template\`

Suggested benchmark root:

- `E:\code\AI-code\.agents\skills\legacy-safe-refactor-workspace\`

Scaffold command:

- `python E:\code\AI-code\.agents\skills\scripts\init_execution_workspace.py --skill-path E:\code\AI-code\.agents\skills\legacy-safe-refactor --workspace-root E:\code\AI-code\.agents\skills\legacy-safe-refactor-workspace --iteration iteration-1`

## Recommended loop

1. Pick one eval from `evals/evals.json`
2. Create `eval_metadata.json` from shared template
3. Run prompt with skill
4. Run same prompt without skill
5. Save transcripts and outputs
6. Grade both with `GRADING-RUBRIC.md`
7. Compare with `REVIEW-CHECKLIST.md`
8. Write delta notes
9. Update workspace `TRACKER.md`

## What to compare

- read-before-write discipline
- current-state vs ideal-state framing
- characterization-test quality
- hidden-state awareness
- slice control and stop rules

## Per-eval files

Each eval folder should contain:

- `eval_metadata.json`
- `benchmark-notes.md`
- `run-sheet-with_skill.md`
- `run-sheet-without_skill.md`
- `with_skill/`
- `without_skill/`

## Stop rule

If eval cannot distinguish safe refactor advice from generic "be careful" prose, strengthen assertions before more runs.
