## Context

See [proposal.md](proposal.md). The book compiles with Typst 0.15.1; fletcher 0.6.0 requires 0.15.0. Each diagram today
is a `.mmd` file rendered to PNG before the compile, and `reader-figure` places the PNG.

## Goals / Non-Goals

**Goals:**

- One toolchain for text and figures; no browser in the build, the tests or CI.
- Each figure's meaning (nodes, labels, arrows) in `diagrams/`, its look in `publication/layout/`.

**Non-Goals:**

- Redrawing what a figure says; captions and alternative texts stay as they are.

## Decisions

- `diagrams/<name>.typ` holds one diagram as content; `reader-figure` imports it by name, so the six call sites keep their
  form. The node and edge styles (fill, stroke, the emphasised node, the label face) are declared once in `style.typ`,
  from its colours, and the fletcher import is declared there once, so its version has one place.
- Layout is explicit (grid coordinates) rather than automatic; six small diagrams gain stable placement.
- Alternative text moves from `image(alt:)` to `figure(alt:)`, which Typst 0.15 tags.
- fletcher 0.6.0 and CeTZ 0.5.3 are added to `typst-packages.sha256`, `typst-inputs.sha256` and the CI supply list.
- Alternatives considered: a browser-free Mermaid renderer (mermaid-rs-renderer, merman) keeps two toolchains and does not
  list `block-beta`; hardening Chrome keeps the dependency (question of 17:2x).

## Risks / Trade-offs

- Explicit placement must be redone by hand when a figure grows; acceptable for six small figures.
- Figures move by a few points; every page with a figure is looked at and the page count held at 200.
