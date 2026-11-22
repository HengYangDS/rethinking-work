## Why

After chapter 29 landed, the owner opened a lane for the page faults that 0.2.4 already had (「开这条小车道」, 2026-11-23
03:06): a sample box in chapter 25 and a result table in chapter 17 that continue on the next page with one field or one
row on a page, and lone characters at the ends of wrapped lines in table cells. Measured on `374655c`, the lone
characters are a class of 27 lines across the book, not the four first seen. The edition's typeset requirement holds
body paragraphs to the rule and left cells and boxes to the page review; the page review found these only after
release. One more cause of lost time is closed here too: a proof was queued on 2026-11-22 before the final text had a
reader, and withdrawn after 85 minutes.

## What Changes

- The typeset requirement extends the lone-character rule from body paragraphs to every wrapped line, table cells and
  sample boxes included, and adds that a table or sample box that continues on the next page leaves on each page at
  least the least part the layout declares.
- The layout marks where each table and sample box starts and ends, and declares the least part of a split; a test reads
  both, and the lone-character test drops its body-only condition. Both fail on `374655c` before the repair.
- The 27 lines and the split blocks are repaired by column widths where a whole column is too narrow, and otherwise by
  the shortest rewording that keeps the cell's meaning.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Typeset output keeps to its declared supply" covers wrapped lines in cells and boxes and split
  blocks.

## Impact

`publication/layout/style.typ`, `tests/test_publication.py`, the chapters and appendices whose cells or text around a
split change, and `openspec/specs/publication-source/spec.md` through this Change. The proof-ticket guard is a local
driver under `build/evidence/`, outside the repository.
