## Why

`tests/test_publication.py` held every check of the built edition and stood at 500 effective lines against ETHOS's
per-file ceiling of 500. The design note of 2026-11-22 (12:1x) said that the next check reading the built PDF goes into
a module of its own first; on 2026-11-23 two checks were added by compacting other code instead. The owner's plan of
14:1x puts the split before the next checks (chapter references, PDF links).

## What Changes

- `tests/edition.py` builds the edition once per test process: one compile and one `typst eval` of every declared
  fact, side by side, and each PDF view read once; a base test case gives every check the build and holds it to less
  than half a layout's CPU time.
- `tests/test_publication.py` keeps the checks of identity, inputs, navigation and printed commands;
  `tests/test_layout.py` takes the checks of how the edition is set (lines, paragraphs, tables, sample boxes, code).
- No check changes what it asserts; the same 19 checks pass, and the book is still laid out once per run.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None.

## Impact

`tests/edition.py`, `tests/test_publication.py`, `tests/test_layout.py`, `tests/README.md` and `CHANGELOG.md`.
