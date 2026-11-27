## Why

The second error-rate sample of 0.2.9, drawn from `a2cb5fc` away from the first sample's pages, counts nine places once
a second judge has read the notes that allege a two-point error: 1.22 per 10,000 (12.3 points over 100,878
characters), above the bar of 1. The re-read of the passages changed since `b59ab28` finds one more, outside the rate.
The acceptance document requires every error found, and its kind across the book, to be corrected before the release.

## What Changes

- Two summaries of the practice pack's `exercises/AGENTS.md` say more than the file (`context.typ`): a time without a
  zone becomes a cutoff without one, and section 3 points to the command rather than writing it out. The same kind in
  the table: what may not be edited is the input CSV files, as the file says, not all input data; and to try another
  condition, the case directory is copied and the copy edited, as the file says, not a file copied.
- A severity level is no longer spoken of as a finding (`tools.typ`), and 访问 no longer takes a matter as its object
  (`boundaries.typ`).
- Punctuation after a colon: a lead-in that names a question ends with ？ (`memory.typ`); a colon that introduces what a
  comparison or a check is to find ends with 。, and the same shape is corrected in `diagnose.typ` and
  `practice-doing.typ`; no mark follows a quotation that closes on ？ (`memory.typ`).
- Clauses with their own subjects are no longer joined by 、 (`diagnose.typ`); the same kind is corrected in `run.typ`,
  found by searching every 、 in the book.
- Spending, irreversible, sat in the middle circle of `boundaries.typ` while chapter 3 said that what cannot be undone
  takes the heaviest procedure, with no exception (`invariants.typ`). Chapter 3 now names spending as the exception on
  its own terms: an irreversible matter is decided by the responsible person before it is done, and for spending that
  decision is the cap, given once; each payment within it needs no further asking (as `invariants.typ`'s permissions
  and the `run` chapter have it), and spending with no cap yet waits for one. `boundaries.typ` says the same where it
  places spending.
- 要求 no longer stands beside 口径 and 边界 that it includes: `delegate.typ` names the delegation's five items, of
  which 口径 and 边界 are two, and `writing.typ` names what the handed-over work is to become, with its 口径 and 边界
  beside it, as `standing.typ` and `roles.typ` keep 要求 and 边界 apart.
- The acceptance document's sampling rule: a later sample of an edition avoids the pages its earlier samples read only
  until every body page has been read, in a sample or by readers whose every item is judged as a sample's items are,
  and corrected; it is then drawn from the whole body. The owner chose this on 2026-11-27, after the second sample
  failed (owner-words O169).
- No requirement of the book changes.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The corrections apply the existing requirement "Chinese prose" and the acceptance document's readings. The
sampling rule changed is the acceptance document's, which the requirement "Editorial acceptance" names for its
readings; no requirement's text changes, so `skip_specs: true` applies.

## Impact

Twelve chapter files under `book/parts/` and `docs/publication-acceptance.md`. Wording and punctuation change, and
chapter 3 names one exception to its rule. The release of 0.2.9 waits for a third sample drawn under the changed rule.
