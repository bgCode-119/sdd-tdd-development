# Skill Index

## Primary skill

### `sdd-tdd-development`

Use when production code is being added or changed and speed alone is not enough.

Best for:

- new feature delivery
- API work
- business-logic changes
- production bugfixes
- anti-vibe-code guardrails

## Companion skill

### `legacy-safe-refactor`

Use when the main risk is preserving existing behavior in old, coupled, or fragile code.

Best for:

- read-first architecture mapping
- current-state spec capture
- characterization-test safety nets
- small verified refactor slices

## Boundary rule

- Greenfield or ordinary bugfix: start with `sdd-tdd-development`
- Fragile old code where hidden behavior is primary risk: add `legacy-safe-refactor`
