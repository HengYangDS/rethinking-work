## Context

See [proposal.md](proposal.md). Measured on `374655c` (2026-11-23 03:1x, `pdftotext -bbox-layout` of a `--jobs 2`
build): 27 lines whose text is one Han character, with any closing marks, set directly under a line that starts at the
same left edge; all are in table cells or sample boxes, 12 of them in appendix D. Chapter 25's 「评审意见示例」 box
leaves its last field (two lines) on page 152; chapter 17's result table leaves its header and one row on page 104. The
quality-gates Change (2026-11-22) left cells and boxes to the page review after a trial of the optimized line breaker in
cells balanced ragged lines, split words and once split an option.

## Goals / Non-Goals

**Goals:**

- Both faults are decidable from the built PDF and the layout's own markers, and a test holds each.
- The repair keeps every cell's meaning; a column is widened before a cell is reworded.

**Non-Goals:**

- The optimized line breaker in cells, for the reasons the quality-gates Change recorded.
- Splits of code blocks, which have their own rule (whole up to six lines).

## Decisions

- A lone character is found the same way everywhere: one Han character, with any closing marks, under a line that
  starts at the same left edge within the layout's line bound. Dropping the body-margin condition extends the existing
  test to cells and boxes; a genuine one-character cell has no such line above it in its column.
- A split is read from two zero-size markers that `flow-block` sets at the start and the end of its content, so the
  test knows each table's and box's first and last page and height there. The least part, `split-least`, is three body
  lines, declared beside the layout's other bounds: a table header with one row, or a box's last two lines, falls
  below it.
- The repair is made where the reader sees it: a column width in the one `#matrix` call, or a cell's wording, or the
  text before a split; no layout rule moves blocks by introspection, which could fail to converge.
- In that order of preference: fourteen tables took new column widths, each set so that its longest short cells fit
  one line and its other cells wrap with at least two characters on the last line; one time keeps its zone on its line
  through a non-breaking space; three cells of 「结论的依据」 lost a clause that repeated their column's heading; and
  where a split block needed room on its page, a paragraph before it was shortened until it lost a line, or a
  one-sentence opening was joined to the paragraph it introduces. Every reworded sentence was read by a reader who
  had not written it.
- The part of a split block on its first page is measured from its start mark to the lowest line of that page, not to
  the foot of the text area: the first version measured the room left and passed a table header with one row, which
  the look at the page caught.

## Risks / Trade-offs

- [A wider column narrows its neighbours and moves other lines] → The test runs over the whole book, and the changed
  pages are looked at.
- [A reworded cell changes a fact] → Each rewording keeps the cell's facts; appendix D's rows are read against their
  run records.
- [The book is at 199 of 200 pages] → The page test holds the ceiling; a repair that adds a page is undone.
