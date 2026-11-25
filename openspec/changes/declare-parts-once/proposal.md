## Why

The code review of 2026-11-25 (`build/evidence/repo-review-20261125/report-code.md`, items 2, 4, 5 and 12) found the
book's structure written by hand in six places: each of 41 chapter calls named its part, the contents listed each
part's chapter numbers, the tests pinned the layers and the chapter list, and the parts README repeated the table.
Inserting chapter 29 on 2026-11-22 needed edits in all of them. The same review found layout functions nobody calls,
two ways of writing a relative reference, layout rules left in the entry file and unused imports.

## What Changes

- `book/manuscript.typ` declares each part once, with its number, name and chapter files, and includes the files in
  that order. A chapter takes its head from its part; the contents group the chapters by part. The back group has no
  number, and its chapters name their heads.
- Tests check rules instead of pinned lists: numbered chapters run from 01 without a gap, each part keeps its chapters
  together, a practice closes its part, appendices run from A.
- `relref` goes (its links read as `#link`), as do `takeaway`, `pageref`, `case`, chapref's many-target branch and the
  colour `teal` (equal to `ink`); `rust` is named `slate`. The code-gutter and inline-command rules move from
  `book/main.typ` into `publication-design`, the width a named constant. Chapters no longer import metadata they do not
  use; the afterword is signed with `book-author`.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the book's parts are declared once and the chapter heads, contents and checks follow them.

## Impact

`book/` (manuscript, front matter, back matter, 36 chapter files), `publication/layout/`, `tests/`, two READMEs. The
PDF's text is unchanged.
