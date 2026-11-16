# Editable diagrams

These Mermaid inputs explain relationships used by the manuscript. Captions and
accessible descriptions live with each `reader-figure` call in `book/`; shared
rendering settings live in [publication/mermaid.json](../publication/mermaid.json).

| Source                                 | Relationship                                                               |
| -------------------------------------- | -------------------------------------------------------------------------- |
| [work-chain.mmd](work-chain.mmd)       | The five judgments from a problem to feedback                              |
| [collaboration.mmd](collaboration.mmd) | Switching between thinking together, doing together and bounded delegation |
| [work-loop.mmd](work-loop.mmd)         | Task, action, tool result, correction and stopping                         |
| [context.mmd](context.mmd)             | What one request to the model contains                                     |
| [memory.mmd](memory.mmd)               | Historical recall, current verification, action and correction             |
| [reconcile.mmd](reconcile.mmd)         | A snapshot rebuilt on two time axes and compared security by security      |

Render one figure with `just --justfile publication/justfile diagram memory` from
the repository root, or all of them with `diagrams`. Images are written under
ignored `build/artifacts/diagrams/`. Read arrows, branch conditions and labels in
the rendered figure; successful rendering does not verify their meaning.
