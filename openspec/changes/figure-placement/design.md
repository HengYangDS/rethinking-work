## Context

See [proposal.md](proposal.md). `reader-figure` in `publication/layout/style.typ` sets each figure inside a block that
gives it a paragraph step above and below. Measured on a build of 2026-11-25 19:2x, the figures stood 22 to 79 points
left of the column's centre; only the figure whose caption wraps to the full measure was centred.

## Goals / Non-Goals

**Goals:**

- Each figure and its caption centred in the text column; no stray paragraph from the figure body.

**Non-Goals:**

- Redrawing the figures or changing their captions.

## Decisions

- The spacing block takes `width: 100%`. In isolated specimens, a block of automatic width holding a figure shrank to
  the figure and sat flush left, and the same block at the column's width centred it; wrapping the figure in
  `align(center)` inside the shrunken block changed nothing.
- The figure is labelled `diagram-<name>`; the `figures` fact in `tests/edition.py` reads the name from the label, so
  the body holds only the diagram.
- `tests/test_layout.py` checks that each caption's first line is centred between the body's margins, within 3 pt: a
  caption ends with a full-width mark whose right half is blank, which moves its measured centre by about 2 pt, while a
  figure set flush left is off by tens of points.

## Risks / Trade-offs

- The check reads the caption, not the drawing; the caption is centred under its figure by Typst's own figure layout,
  so the two move together.
