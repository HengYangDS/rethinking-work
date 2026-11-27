## Why

The second error-rate sample of 0.2.9, drawn from `a2cb5fc` away from the first sample's pages, counts nine places once
a second judge has read the notes that allege a two-point error: 1.22 per 10,000 (12.3 points over 100,878
characters), above the bar of 1. The re-read of the passages changed since `b59ab28` finds one more, outside the rate.
The read-through of the 77 body pages no 0.2.9 sample read (pp. 5–51, 103–117 and 169–183 of `f358d91`), run under
the owner's choice of 2026-11-27, finds fifteen more. The acceptance document requires every error found, and its kind
across the book, to be corrected before the release.

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
  decision is the cap, given once, so that each payment within it is not decided again (as `invariants.typ`'s
  permissions and the `run` chapter have it). `boundaries.typ` says the same where it places spending, adds that
  spending with no cap yet waits for one, and its section on irreversible matters points back to it.
- 要求 no longer stands beside 口径 and 边界 that it includes: `delegate.typ` names the delegation's five items, of
  which 口径 and 边界 are two, and `writing.typ` names the delegation, with 口径 and 边界 written in it.
- The acceptance document's sampling rule: a later sample of an edition avoids the pages its earlier samples read only
  until every body page has been read, in a sample or by readers whose every item is judged as a sample's items are,
  and the errors found are corrected; it is then drawn from the whole body. The owner allowed a sample of the whole
  body once the whole book has been read and corrected (2026-11-27, after the second sample failed; owner-words O169);
  that it is then the draw, and what counts as a page read, are the editor's reading under delegation (design
  decision 7).
- The read-through's fifteen: a list that names four of five links' judgments as if all (`change.typ`); a judgment
  called a statement of fact (`invariants.typ`); the vendor's ingest time used without saying what it computes, and
  入库 meaning the vendor's database where the chapter defines it as the local one (`knowing.typ`); a query's report
  called the source's own problems (`practice-thinking.typ`); 只 where the next sentence adds a file
  (`walkthrough.typ`); numbers listed with ， (`walkthrough.typ`); 只 where the delivered file carries more
  (`run.typ`); 连同 with no verb, and a clause whose subject shifts (`talent.typ`); an answer promised for every
  exercise where one has a checklist (`practice-collaborating.typ`); a quoted question after 追问 without its ？, and
  a gloss that shows clarity, not reliability (`growth.typ`); 、 between clauses (`knowing.typ`). Their kinds are
  searched across the book and corrected where found (`knowing.typ`, `practice-doing.typ`), and the comment at the
  head of the practice pack's `quality.sql` says what it lists. Two places that no judge counted are corrected as
  wording (`leading.typ`, `growth.typ`; design decision 9).
- No requirement of the book changes.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The corrections apply the existing requirement "Chinese prose" and the acceptance document's readings. The
sampling rule changed is the acceptance document's, which the requirement "Editorial acceptance" names for its
readings; no requirement's text changes, so `skip_specs: true` applies.

## Impact

Twenty chapter files under `book/parts/`, one comment in `exercises/cases/historical-snapshot/quality.sql`, and
`docs/publication-acceptance.md`. Wording and punctuation change, and
chapter 3 names one exception to its rule. The release of 0.2.9 waits for a third sample drawn under the changed rule.
