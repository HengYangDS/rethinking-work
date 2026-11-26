## Why

The book prints facts about its structure and its edition that are written by hand where they stand. Each chapter's
opening declares its own number, and the parts' numbers and every reference to a part are written out; the practice
pack's place is repeated in eight printed commands; the exercise command stands in the back matter, the reader note
and the task file; the archive's folder, file and note names stand in the prose, the reader notes, the archive task and
its test; and the exercise templates, guides and specification name chapters by number. Inserting a chapter or renaming
the pack leaves some of them stale, as the insertion of 2026-11-22 did for eight references. The owner asked on
2026-11-26 that the hard-coded facts be removed. The reader notes, reader text that no review covered, were left to this
Change by the one that declared the toolchain once.

## What Changes

- A chapter's, practice's and appendix's number comes from its place in the reading order, counted within its kind,
  and a part's number from its place among the numbered parts. An opening declares its kind, not its number; the
  closing and the afterword keep their marks.
- A reference to a part is derived as a chapter reference is, and a check fails on one written by hand; 上一部 and
  下一部 name the part they mean, and the build stops when it is not the neighbouring one. The counts of a part's
  chapters that the prose gives are derived too.
- `book/metadata.typ` declares the archive's names, the place of the pack, the companion appendix's title, the tools
  the pack's checks need, the check file and the command that runs it. The book, both reader notes, the archive task,
  the exercises task and the practice-pack test read them; a printed command writes `@PACK_PATH@` for the pack's place,
  and a check fails on a printed block that still carries a token.
- The reader notes move to `publication/notes/`, and a commands review records that tree beside `book/`, `exercises/`
  and the Python line. Reviews recorded before record none.
- Outside the book, a chapter named by number is named by its file in the maintainers' guides and by its title in the
  files the pack carries; the pack's guides name the reader note and the companion appendix by what they are.

The PDF's text changes in one sentence that the review found inexact: the companion appendix says that the PDF and the
pack share a version, since the checksum list has none. In the pack, the note names the companion appendix by its title without its letter, and the two
templates name their chapters by title.

Out of scope: the layout's constants, which follow in a Change of their own; the maintainer's local scripts outside the
repository; the move to Python 3.14.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a new requirement declares the edition's facts once; "Chapter references are derived" takes
  the numbers and the part references from the reading order; "Reviewed text before landing" covers the reader notes;
  "Cohesive publication inputs" and "Qualified edition" name the appendix and the chapter they cite without a number.

## Impact

`book/`, `publication/layout/style.typ`, `publication/justfile`, `publication/notes/`, `publication/README.md`,
`publication/acceptance/reviews.toml`, `tests/`, `.config/checks/vale/`, `exercises/README.md`, `exercises/AGENTS.md`,
`exercises/templates/`, `exercises/cases/historical-snapshot/session/README.md`, `.agents/skills/book-chinese-prose/`,
`docs/publication-acceptance.md`, the specification.
