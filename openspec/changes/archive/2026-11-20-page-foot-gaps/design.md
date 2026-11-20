# Design

## Context

The book is set by Typst 0.15.1 over the pinned `neat-book` package. Typst fills a page from the top and has no vertical justification: when the next block does not fit in the space left, the block moves and the space stays empty. Three rules in `publication/layout/style.typ` and one in the package decide how often that happens:

- a section heading is one unbreakable block with 96 pt (six body lines) reserved under it;
- `matrix` (tables) and `note` (sample boxes) are unbreakable blocks unless a table sets `breakable: true`;
- `closing` keeps a chapter's last lines in one unbreakable block;
- the package sets its code blocks unbreakable.

The measurement reads the built PDF with `pdftotext -bbox-layout` and the positions of headings, tables, code blocks and chapter openings with one `typst eval`. A page counts when its last body line ends three or more body lines (48 pt) above the foot of the text block, the next page does not open a chapter, and the manuscript did not end the page on purpose. The cause is what begins the next page.

## Goals / Non-Goals

**Goals:**

- No page is left short before a table, a sample box or a long code block by more than a whole block can explain.
- A page before a section heading is short by fewer lines than now.
- The rules hold for any text, so the next edition's wording does not bring the gaps back.

**Non-Goals:**

- Pages of equal depth. Typst has no vertical justification.
- Any change to the wording of the book, or to single pages by hand.
- A release.

## Measurements

Each row adds one rule to the row above it. The counts are pages short by at least three, six and eight body lines.

| Rules                                             | Pages | 3 lines | 6 lines | 8 lines |
| ------------------------------------------------- | ----- | ------- | ------- | ------- |
| 0.2.2                                             | 190   | 57      | 29      | 16      |
| room for three lines under a heading, not six     | 189   | 41      | 18      | 11      |
| a table taller than six lines continues           | 188   | 39      | 15      | 9       |
| a sample box taller than six lines continues      | 187   | 32      | 7       | 2       |
| a code block of more than six lines continues     | 187   | 31      | 6       | 2       |
| every such block by measured height, closings too | 187   | 27      | 3       | 0       |

The fifth row is the design. The scripts, the numbers and the pages looked at are in the Change's local evidence, `build/evidence/page-foot-gaps/measure/`.

## Decisions

### One rule for tables and sample boxes

A block no taller than six body lines (96 pt) moves whole; a taller one continues on the next page. The height is measured in the width the block will take, so the rule holds wherever a block sits. The space above and below a block stays what it was: on a test page of tables, sample boxes, a heading and paragraphs, every element sits where the 0.2.2 rules put it. Six lines is the height a reader takes in at a glance, and it bounds what a whole block can leave empty: its own height and the space above it.

A continued table repeats its header, which Typst does for `table.header`, and its cells are set unbreakable so that a row is not divided. The five tables that set `breakable: true` by hand are all taller than six lines, so the argument goes.

### Room for three lines under a heading

A heading stays on a page when three body lines fit under it. Three lines under a heading still read as its text, and two is the usual minimum. The space a heading needs falls from about nine lines to about six. A short page before a heading does not mislead, because the section did end there.

### Code blocks by line count, and only long ones

A command is read and copied as one piece, so a code block stays whole up to six lines. A longer one may continue: the longest in the book has 17 lines and would leave a third of a page. The count is of source lines. Measuring each of the 147 code blocks as the other blocks are measured raised the CPU time of one compile from about 7.5 s to 11.4 s (least of three runs on two threads) and removed four more short pages; the line count costs nothing measurable.

### Closings stay whole

`closing` exists so that a line or two is not left alone on a chapter's last page. Typst can keep a block with the block after it, not with the last lines of the paragraph before it, so a divided closing puts exactly that line alone again. The two pages it leaves short (eight and nine lines) are left to the next edition's page pass, where the text is final.

### A declared page turn

Typst cannot locate a plain `pagebreak`, so a check cannot tell a page ended on purpose from a gap. `page-turn()` places a labelled marker before the break. The three exercise pages use it.

### The check

The check reads the facts and the PDF layout that the suite already has. For each page whose following page begins with a table or a sample box, it compares the empty foot with what the rule allows: a whole block and one paragraph step, 128 pt with the present values. The layout declares that bound once, beside the threshold it follows from, and the check evaluates it from there; it holds no number of its own. A chapter's last page and a declared page turn are left out. It does not count pages or name any text. Before it is trusted it is shown failing on a copy in which sample boxes are unbreakable again.

## Risks / Trade-offs

- A row taller than six lines at the head of a continued table can leave more than the check allows. The remedy is in the layout (let that table's rows divide), not in the wording.
- Page numbers change with any layout rule. The book types none.
