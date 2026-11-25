# Editable diagrams

These Typst sources draw the relationships used by the manuscript with the
fletcher package. Each source defines `body`, the figure's boxes, labels and
arrows. Captions and accessible descriptions live with each `reader-figure` call
in `book/`; the shared look (font, colours, box and arrow styles) lives in
[publication/layout/figures.typ](../publication/layout/figures.typ), and its
colours in [palette.typ](../publication/layout/palette.typ).

| Source                                 | Relationship                                                               |
| -------------------------------------- | -------------------------------------------------------------------------- |
| [work-chain.typ](work-chain.typ)       | The five judgments from a problem to feedback                              |
| [collaboration.typ](collaboration.typ) | Switching between thinking together, doing together and bounded delegation |
| [work-loop.typ](work-loop.typ)         | Task, action, tool result, correction and stopping                         |
| [context.typ](context.typ)             | What one request to the model contains                                     |
| [memory.typ](memory.typ)               | Historical recall, current verification, action and correction             |
| [reconcile.typ](reconcile.typ)         | A snapshot rebuilt on two time axes and compared security by security      |

There is no separate render step. `reader-figure` in
[style.typ](../publication/layout/style.typ) draws `diagrams/<name>.typ` inside
the book's own `typst compile`, so `pdf`, `build`, `render` and the tests always
draw the current sources; the tests also require each source to be drawn once,
by a figure with an alternative text. Read arrows, branch conditions and labels
on the figure's page; a successful compile does not verify their meaning.
