## Why

The organization review of 2026-11-25 (`build/evidence/repo-review-20261125/report-organization.md`, items 2 and 5)
found behaviors that tests hold but the main specification never states: alignment declared by kind of element, a text
block of a declared number of characters a line, curly quotation marks set in full cells, and a lead-in kept with the
block it introduces. Three Changes added them with `skip_specs`. The migration requirement describes a migration and a
rebuild that are both finished.

## What Changes

- ADDED: the layout's alignment, measure, quotation-mark cells and lead-ins, as the tests already hold them.
- REMOVED: the migration requirement; the rule it kept for retained cases (date, source role and limit stated once)
  already stands in the direct-prose requirement.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: one requirement added, one removed.

## Impact

`openspec/specs/publication-source/spec.md` only.
