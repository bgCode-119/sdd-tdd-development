# Review Checklist

Use this checklist while manually reviewing execution outputs.

## Safety order

- Did it refuse to edit before understanding?
- Did it ask for entry points, responsibilities, state map, hidden contracts?
- Did it write current-state rather than ideal-state framing?
- Did it require characterization tests before refactor?

## Slice control

- Are refactor steps small and reviewable?
- Is public API stability preserved by default?
- Are stop conditions explicit?

## Risk handling

- Did it treat hidden side effects as first-class?
- Did it separate suspected bugfixes from structural cleanup?
- Did it keep human merge judgment?

## Failure patterns

- "split file" as first action
- no current-state spec
- no state isolation mention
- bugfix mixed into cleanup
- vague "be careful" without method

