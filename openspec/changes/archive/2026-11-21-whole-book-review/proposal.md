## Why

On 21 November 2026 the owner judged a passage of chapter 2 illogical (a consequence asserted without its premise)
and found more passages of the same kind, or unclear, or unreliable: 「信、达、雅，并没有充分贯彻。需要地毯式地全面评审内容，
要求提高评委的评价标准，把谋篇布局，遣词造句，行文等各方面问题，做深入的修复优化。」 A review round under one raised
standard read every part of the book twice (logic, reliability and structure; sentence-level wording and flow) and the
whole book once for structure; its reports are in the lane's local evidence (`build/evidence/whole-book-review/`).

## What Changes

- Every chapter, the preface, the closing and the appendices are repaired against the review's findings: claims that
  did not follow from their premises, statements stronger or weaker than their support, terms used in two senses,
  lists that overlap, sections out of order, repeated material, unclear referents, non-standard words and spoken
  register.
- Material repeated across chapters is kept in one place and referred to elsewhere; the closing gathers the whole
  book instead of restating the preface.
- Printed command blocks do not change.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The book's checks and publication behave as before, so `.openspec.yaml` sets `skip_specs: true`.

## Impact

`book/` (prose only) and `CHANGELOG.md`. No code, check or exercise changes are expected.
