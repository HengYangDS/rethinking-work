# Proposal

## Why

The 0.2.2 edition leaves the foot of many pages empty. In the PDF of its 190 pages, the last line of 57 pages ends three or more body lines above the foot of the text block; on 29 of them it ends six or more lines above, and on 16 eight or more. Each chapter's last page and the three pages that an exercise ends on purpose are not counted. The cause is in the layout rules, not in the text:

- A section heading moves to the next page unless six body lines fit under it (30 pages).
- A table, a sample box or a code block is never divided. One that does not fit in the space left moves whole and leaves that space empty (6, 6 and 12 pages); a twelve-line sample box left twelve lines.
- A paragraph of three lines is not divided (3 pages).

Before a table, a box or a code block the empty foot misleads: the page looks as if the section had ended, and the text goes on overleaf. The owner agreed on 2026-11-19 that the gaps be closed for the next edition (「页脚空白: 按照你建议的方式」).

## What Changes

- A section heading stays on a page when three body lines fit under it, instead of six.
- A table or a sample box no taller than six body lines still moves to the next page whole. A taller one continues on the next page; a continued table repeats its header and keeps each row whole.
- A code block of more than six lines may continue on the next page. A shorter one stays whole, so that a command is copied from one place.
- The three pages that an exercise ends on purpose (「写完再翻页」) say so through one layout function, so that a check can tell them from a gap.
- The table function loses its `breakable` argument, which five tables set by hand; the rule now decides.
- A new check fails when the page before a table or a sample box is left emptier than a whole block can explain.

With these rules the same text takes 187 pages. The pages short by three or more lines fall from 57 to 31, by six or more from 29 to 6, and by eight or more from 16 to 2.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the layout SHALL keep a short block whole and let a tall one continue, SHALL leave room for three body lines under a section heading, and SHALL have the manuscript declare a page it ends on purpose.

## Impact

Affected:

- `publication/layout/style.typ`: the heading rule, one rule for tables and sample boxes, the code block rule, and the page-turn function.
- `book/parts/practice-thinking.typ` and `book/parts/practice-doing.typ`: the three page turns call that function.
- `book/back-matter.typ` and `book/parts/orchestrate.typ`: five tables drop the `breakable` argument.
- `tests/test_publication.py`: one check and the facts it reads.
- The CHANGELOG.

The wording of the book does not change. Page numbers do: the book has no typed page number, and its page references are computed, but notes taken on the 0.2.2 PDF refer to that edition's pages.

Out of scope:

- Chapter closings stay whole. Dividing one leaves a line or two alone on the chapter's last page, which is what the rule was made to prevent. Under the new rules two pages are short by eight and nine lines for this reason.
- Typst has no vertical justification, so a page before a heading can still be short by up to five lines.
- Page-by-page adjustments wait for the next edition's final text, and so does the review of every page that a delivery needs.
- No release.
