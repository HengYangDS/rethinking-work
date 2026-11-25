## Why

The commands reviewer read c3bce38 against the run records (2026-11-25 23:2x,
`build/evidence/reader-run-next-edition/review-c3bce38/FINDINGS.md`). Chapter 17's table says six runs named the basis
they checked against; five did. Appendix D's first kind of run has never named its host and model. Two cuts of the
content review removed what chapters 11 and 15 said their runs did not test, so the chapters state a risk that the
book's own runs did not show, without that limit. The reconcile figure sent all three set-aside securities from one
step, though two leave at the first step and one at the second.

## What Changes

- Chapter 17: 「五次写明了自己按哪一种口径核验」.
- Appendix D: the first kind's host (Claude Code 2.1.325), model (Claude Fable 5.2) and dates; the coverage run points to
  chapter 9 only, where it is still told.
- Chapters 11 and 15 each state what their run showed and what it did not test.
- Figure 2: the set-aside box takes an arrow from each of the two steps.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a claim the book's runs do not test keeps that limit beside it.

## Impact

`book/parts/walkthrough.typ`, `context.typ`, `delegate.typ`, `book/back-matter.typ`, `diagrams/reconcile.typ`. The book
is 197 pages; chapter 15 and appendix D each take one more page.
