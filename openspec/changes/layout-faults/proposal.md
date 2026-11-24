## Why

The every-page look of the 0.2.5 candidate found layout faults that the base already had: lead-in sentences left at
a page foot with their command or box on the next page, code blocks and practice cards split so that one or two lines
sit on one side, justified lines opened past the declared bound beside long commands, narrow table columns that break
numbers and chapter names, and a return link set on the wrong side. They were left out of 0.2.5 because a layout rule
moves pages book-wide. The owner asked for them to be repaired (「Do this task here」, 2026-11-24 07:55).

## What Changes

- The layout keeps a paragraph that ends in a colon with the block it introduces, sets practice cards whole or split
  with the declared least part on each page like sample boxes, and lets figures float.
- A lead-in is spaced as any paragraph is, before and after a command, table, list, card or box.
- Tests hold the new rules over the whole book: no page ends with a lead-in, a split code block keeps the least part
  on each page, and the loose-line check also measures words that hold Chinese punctuation; a compiled specimen holds
  the lead-in spacing.
- Where the rules moved pages, the text is tightened or split so that each chapter keeps its pages (198 in all), each
  change keeping its facts; four tables get column widths that keep their cells whole; the return link on the
  preface page is set right.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`publication/layout/style.typ`, `publication/README.md`, `tests/test_layout.py`, `tests/edition.py`, 20 book files
(`book/main.typ` takes the publisher settings from the layout module). Decisions and measurements are in
`build/evidence/layout-faults/decisions.md`.
