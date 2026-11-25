## Why

Chrome is in this repository for one purpose: Mermaid CLI drives a headless browser to raster the book's six diagrams.
On 2026-11-25 a GitLab verification job failed because Chrome did not start within 30 seconds on a shared guest. The
owner asked for a better way if a better tool may be introduced (17:23) and chose to draw the diagrams in Typst
(「Typst native, 0.2.7」, 17:52). A specimen of `work-loop` and `work-chain` in fletcher 0.6.0 compiled in under a second
with the book's sans face and matched the Mermaid layout.

## What Changes

- The six diagrams are written in Typst with fletcher (on CeTZ) and drawn in the book's own compile: vector, the book's
  fonts, colours from the layout, text that a reader can select and search; each figure keeps its alternative text.
- **BREAKING** for maintainers: Mermaid CLI, Puppeteer, the Chrome headless shell, `publication/mermaid.json`,
  `publication/puppeteer.json`, the Chrome supply manifest, the diagram recipes and `tests/test_diagram_replay.py` go.
- fletcher and CeTZ join the locked Typst package supply.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a figure is drawn from its source in the book's compile; the proof no longer renders a diagram
  set.

## Impact

`diagrams/`, `publication/layout/style.typ`, `publication/justfile`, the Typst supply manifests, `.config/mise/`, the CI
supply, `book/back-matter.typ` (the colophon names the tools), tests and documents that name Mermaid or Chrome.
