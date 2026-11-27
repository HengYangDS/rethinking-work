## Why

The error-rate sample of 0.2.9's final text (`b59ab28`, pages 118 to 168, 100,878 layout characters) counted seven
places, 4.5 points, 0.45 per 10,000, and named two more of the same kinds under its stricter reading. The acceptance
document requires every error found, and its kind across the book, to be corrected before the release.

## What Changes

- `roles.typ` no longer says that small matters need no reviewer, which contradicted the five functions
  that every matter requires; small matters may keep the review light.
- `evaluate.typ`: the measure word 句 counts a sentence that states the cut-off time and its zone, not the
  time itself.
- Coordinate words and phrases are joined by 、, not ，: `diagnose.typ`, `improve.typ` and `practice-doing.typ`.
- Two clauses that share one 时 are separated by ，, not 、: `review.typ`.
- Table cells that list names are joined by 、, not ；: the table of orchestration objects (`orchestrate.typ`) and the
  back matter's table of tools (`back-matter.typ`). Cells that list clauses or checklist items keep ； (GB/T 15834—2011 4.6.3.1 and 4.6.3.3).
- A sentence nests no second colon: `shared.typ`, `walkthrough.typ` and `talent.typ`.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The corrections apply the existing requirement "Chinese prose" (standard written Chinese); no requirement changes,
so `skip_specs: true` applies.

## Impact

Ten chapter files under `book/parts/` and `book/back-matter.typ`. The meaning of the passage in `roles.typ` changes (from no
reviewer to a light review); the other corrections change punctuation or one collocation.
