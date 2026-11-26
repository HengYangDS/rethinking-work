# Tasks

## 1. Split the specification

- [x] 1.1 Move each requirement of `publication-source` verbatim to the capability of its theme, with each capability's
      purpose, and rename "Typeset output keeps to its declared supply"; done when every one of the 32 requirements is
      removed once and added once, and each added block, with the rename undone, is the source block.
- [x] 1.2 Mark `publication-source` for retirement and link the guides to the specifications' folder; done when its 32
      requirements are REMOVED blocks, `.openspec.yaml` sets `retire_capabilities`, and no guide outside archived
      Changes names `publication-source`.

## 2. Accept

- [x] 2.1 Validate the split; done when `openspec validate split-publication-spec --strict` passes and the specifications
      that an archive would leave pass `openspec validate --specs --strict`.
- [x] 2.2 Answer each finding of the independent review in this design or in the deltas; done when none is open.
