## Why

Two content reviews and an exercises-and-diagrams review of 0.2.6's text (2026-11-25, saved under
`build/evidence/repo-review-20261125/`) found the same fact told several times: the body restated appendix D's runs
and versions, the 上手 sections were told before they ran, part introductions and "why this chapter is here" repeated
the preface, examples and arguments were retold in two or three chapters, the ending returned to a checklist, and
the practice pack carried a second copy of the exercises with their answers. The owner asked that 0.2.7 take every
known improvement (2026-11-24, 「把所有已知需要做的修复和优化……」) and started 0.2.7 at 18:16 on 2026-11-25.

## What Changes

- The body states behaviour and reasoning; a run's conditions and version numbers stay in appendices C and D, with at
  most one pointer a section. Results are not told before the 上手 section that produces them.
- Part introductions and placement notes are removed outside the preface; repeated examples and arguments are told
  once and pointed to; chapter 14 and chapter 30 open on a scene; the ending is one paragraph that rises.
- Chapter 18 describes the paid scheduled task instead of registering and deleting it; chapter 20, 23 and appendix C
  lose their repeated facts; chapter 28's four marks of 突出 move to chapter 29, where they are used.
- Practice 4's exercise 4 asks for a record the book has not printed; practice 1 and 2 no longer redo the body's
  worked numbers.
- The practice pack keeps one index for readers, appendix A: `reader-guide.zh.md` and six English templates the book
  never cites are removed, `exercises/README.md` keeps what a maintainer needs, and the snapshot difference is named
  `snapshot_minus_expected_bps`, the direction of the keyed reconciliation's. `exercises/` is formatted like other
  authored inputs.
- Figures 1, 2, 5 and 6 use the chapter's words and steps, without an unexplained emphasis.
- Pages that the cuts moved are refitted by wording; the book is 195 pages.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the practice pack holds no second copy of the exercises; a run's conditions are told once.

## Impact

`book/` (front matter, 30 chapter files, back matter), `diagrams/`, `exercises/`, `publication/reader-start.zh.txt`,
`.config/checks/prettier/prettierignore`, `docs/contributing.md`, `CHANGELOG.md`.
