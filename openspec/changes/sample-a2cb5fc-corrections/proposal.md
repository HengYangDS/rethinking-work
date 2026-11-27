## Why

The second error-rate sample of 0.2.9, drawn from `a2cb5fc` away from the first sample's pages, passes at 0.82 per
10,000 (8.3 points over 100,878 characters) and counts seven places; the re-read of the passages changed since
`b59ab28` finds one more, outside the rate. The acceptance document requires every error found, and its kind across
the book, to be corrected before the release.

## What Changes

- Two summaries of the practice pack's `exercises/AGENTS.md` say more than the file (`context.typ`): a time without a
  zone becomes a cutoff without one, and section 3 points to the command rather than writing it out. The same kind in
  the table: what may not be edited is the input CSV files, as the file says, not all input data.
- A severity level is no longer spoken of as a finding (`tools.typ`), and 访问 no longer takes a matter as its object
  (`boundaries.typ`).
- Punctuation after a colon: a lead-in that names a question ends with ？ (`memory.typ`); a colon that introduces what a
  comparison or a check is to find ends with 。, and the same shape is corrected in `diagnose.typ` and
  `practice-doing.typ`; no mark follows a quotation that closes on ？ (`memory.typ`).
- Clauses with their own subjects are no longer joined by 、 (`diagnose.typ`); the same kind is corrected in `run.typ`
  and `verify.typ`, found by searching every 、 in the book.
- No requirement of the book changes.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The corrections apply the existing requirement "Chinese prose" and the acceptance document's readings; no
requirement changes, so `skip_specs: true` applies.

## Impact

Nine chapter files under `book/parts/`. Only wording and punctuation change.
