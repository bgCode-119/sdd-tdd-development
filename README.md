# SDD + TDD Development Skills

Reusable AI coding skills for:

- spec-first development
- tests-first development
- safe production code generation
- legacy behavior-preserving refactor

## Included skills

### `sdd-tdd-development`

Use for:

- new features
- production bugfixes
- APIs and endpoints
- business-logic changes
- "write it fast" requests that still need correctness

Core loop:

1. classify task
2. write small spec
3. derive checks
4. prove RED
5. implement minimum GREEN
6. refactor after green
7. update durable artifacts

### `legacy-safe-refactor`

Use for:

- brittle legacy modules
- god files / god classes
- hidden state and side effects
- behavior-preserving cleanup

Core loop:

1. read-only structure pass
2. current-state spec
3. characterization tests
4. small refactor slices
5. keep bugfixes separate from structural cleanup

## Repo layout

```text
skills/
  sdd-tdd-development/
  legacy-safe-refactor/
scripts/
  install-codex-skills.ps1
  install-codex-skills.cmd
INDEX.md
README.md
```

## Quick install

### Windows PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1
```

Default install target:

- `%USERPROFILE%\.agents\skills`

Custom target:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-codex-skills.ps1 -TargetDir "E:\myrepo\.agents\skills"
```

### Windows CMD

```bat
scripts\install-codex-skills.cmd
```

## How to use

### New feature

```text
Use sdd-tdd-development for this feature.
Define a small spec first, derive checks, prove RED, do minimum GREEN, then list durable artifacts to update.
```

### Small bug

```text
Use sdd-tdd-development for this bug.
Add the regression test first, then do the smallest fix. No opportunistic refactor.
```

### Legacy cleanup

```text
Use legacy-safe-refactor for this module.
Read first, write current-state spec, lock behavior with characterization tests, then refactor in small verified slices.
Do not silently change suspicious old behavior.
```

## Notes

- `sdd-tdd-development` is the primary skill.
- `legacy-safe-refactor` is the companion skill for old brittle code.
- Execution benchmark files are included inside each skill's `evals/` folder for maintainers and future tuning.

## Version snapshot

Current packaged versions:

- `sdd-tdd-development`: `0.3.0`
- `legacy-safe-refactor`: `0.2.1`
