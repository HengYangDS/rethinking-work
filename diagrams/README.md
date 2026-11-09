# Editable diagrams

These Mermaid inputs explain relationships used by the manuscript. Captions and
accessible descriptions live with each `reader-figure` call in `book/`; shared
rendering settings live in [publication/mermaid.json](../publication/mermaid.json).

| Source                                 | Relationship                                                               |
| -------------------------------------- | -------------------------------------------------------------------------- |
| [work-loop.mmd](work-loop.mmd)         | Task, action, tool result, correction and stopping                         |
| [collaboration.mmd](collaboration.mmd) | Switching between thinking together, doing together and bounded delegation |
| [runtime.mmd](runtime.mmd)             | Installation, project selection, actual runtime and consumer acceptance    |
| [orchestration.mmd](orchestration.mmd) | Session, workspace, task and method continuity                             |
| [data-chain.mmd](data-chain.mmd)       | Snapshot, loading, computation, audit and acceptance                       |
| [memory.mmd](memory.mmd)               | Historical recall, current verification, action and correction             |
| [reconcile.mmd](reconcile.mmd)         | Individual synthetic discrepancies versus their net total                  |

Render one figure with `just --justfile publication/justfile diagram memory` from
the repository root, or all of them with `diagrams`. Images are written under
ignored `build/artifacts/diagrams/`. Read arrows, branch conditions and labels in
the rendered figure; successful rendering does not verify their meaning.
