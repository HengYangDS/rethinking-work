## Why

The accepted requirement "Qualified edition" asks, before a release is approved, for a sentence-level cold read of the
whole book after its last content edit, readers of every changed passage, the commands checked against the run records,
every page looked at, and an error-rate sample of the final text. The owner asked for the next release to be sampled
again (「下一版发布前要再抽测差错率」, 2026-11-23 14:22) and for the work to go on (「按规划继续推进」, 14:17). This Change
carries the cold read's repairs for 0.2.5.

## What Changes

- Seven readers read the candidate text of `6e2eb9e` (198 pages) sentence by sentence and reported 188 findings
  (A 19, B 105, 信 37, 术语 27); seven editors proposed exact repairs, which were reviewed one by one.
- 195 of the 202 proposed repairs are applied across 37 book files, with the cuts that keep the pages: missing premises and referents restored, overstatements narrowed to
  what the book and the records support, terms explained at first use and kept in one sense, crowded sentences split,
  and spoken words replaced by the book's decided ones. Each repair keeps its facts, figures and limits.
- Repairs that would change chapter 3's responsibility passage, which the owner settled, are not applied and are put to
  him; two diagram texts wait for a change that re-renders diagrams.
- The repairs pushed chapter 19 to a seventh page; the reviewed reserve of cuts written for it on 2026-11-22 folds it
  back. The book is 199 pages.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None.

## Impact

37 files under `book/` and `CHANGELOG.md`. No printed command or block changes; the cold-read reports, the editors'
proposals and the decisions on them are under `build/evidence/qualify-0.2.5/`.
