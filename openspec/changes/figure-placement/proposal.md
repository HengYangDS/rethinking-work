## Why

The six figures drawn in Typst stood left of the text column's centre, by 22 to 79 points, though each caption was centred
under its figure. The owner saw it on 2026-11-25 (「有点偏左对齐了」, 19:20). The block that spaces a figure from the
text had automatic width; Typst shrank it to the figure and set it flush left. The figure body also held an inline
`metadata` marker, which made a stray paragraph that the layout test reported on five pages.

## What Changes

- The block around a figure takes the column's width, so each figure and its caption stand centred in the column.
- The figure is labelled `diagram-<name>` instead of carrying a `metadata` marker in its body; the check that every
  diagram is drawn once reads the label.
- A layout test holds every figure's caption centred in the column.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a figure and its caption stand centred in the text column.

## Impact

`publication/layout/style.typ`, `tests/edition.py`, `tests/test_layout.py`. Pages and chapter spans unchanged.
