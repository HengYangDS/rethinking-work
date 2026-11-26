## Context

See [proposal.md](proposal.md). Each fact below has one carrier; every other mention reads it, and the PDF's text stays
what it was before the Change.

## Goals / Non-Goals

**Goals:**

- Inserting, removing or moving a chapter or a part changes no line outside `book/manuscript.typ`.
- Renaming the pack, its notes or the check command changes one declaration.
- Every reader-facing text that prints a command is covered by a commands review.

**Non-Goals:**

- The layout's constants (sizes, spaces, limits written as numbers in `publication/layout/style.typ`), which a Change of
  their own takes next.
- Naming a chapter's title once for the files in the pack: a title is the chapter's name, which a reader finds in the
  contents, and it changes far less often than a number, which any insertion shifts.

## Decisions

- **Numbers come from counters, by kind.** `chapter(title, lead, kind:, mark:, head:)` steps a counter per kind
  (chapter, practice, appendix) and writes `01`…, `练一`…, `A`…; the closing and the afterword pass their marks and
  heads. The navigation mark holds only the kind and the mark, so it is placed outside any `context`; the number is read
  where it is needed from the counter at the mark's place (`chapter-label`). A mark built inside `context` from the
  counter made the layout fail to converge.
- **A part's number is its place.** `book/manuscript.typ` declares each part's name and files in order; the back group
  is declared unnumbered. `partref`, `partspan` and `part-chapters` find a part by name among the parts the chapters
  stand in. Parts have no opening, so these references do not link.
- **Edition facts in `book/metadata.typ`.** It already holds the edition's identity, and Typst, the archive task (one
  `typst eval` read into shell variables) and the tests (`typst eval` without a layout) all read it natively. The check
  command is built from the declared check file and the Python line the toolchain declares.
- **`@PACK@` in printed commands.** `pack-code` takes the authored block and returns one with the declared path, keeping
  its language and block form, so the source stays a readable code block and the document carries the literal path. A
  show rule was rejected: it would leave both blocks in the document for the checks that query code blocks.
- **The note drops the appendix's letter.** The letter is a layout result; filling it would make the archive task lay
  out the book and its test copy the whole book. The title is declared and names the appendix unambiguously.
- **The notes are a tree.** Moving them to `publication/notes/` gives a commands review one tree to record. Earlier
  reviews record `none`, which states that they did not read the notes.

## Risks / Trade-offs

- A reference to a part by name breaks if the part is renamed → `partref` stops the build with the name it did not find.
- The numbering checks in `tests/test_publication.py` now test the counters rather than hand-written numbers; they stay,
  since a counter that does not step would still fail them.
