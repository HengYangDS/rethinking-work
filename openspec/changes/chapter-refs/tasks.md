# Tasks

Scope: derive references by number from the chapter openings, and hold relative references to the manuscript's order.
New scope enters as a task here before it is worked.

## 1. Contract

- [x] 1.1 "Chapter references are derived" is stated; done when `openspec validate --strict` passes.

## 2. Derivation

- [x] 2.1 `chapref` and `chapnum` derive every reference by number; done when the built PDF's text and word positions
      equal those of `d85751f` and Vale finds no written 「第X章」.
- [x] 2.2 `tests/test_references.py` holds 上一章 and 下一章 to the manuscript's order; done when it fails with one
      reference pointed wrongly and passes restored.
- [x] 2.3 The acceptance guide asks a reader whether a replaced word is a term another chapter defines.

## 3. Qualification

- [ ] 3.1 The light gates pass, a reader who did not write the change reads the diff against the PDF comparison, the
      commands reviewer reviews it, and both are recorded in `publication/acceptance/reviews.toml`.
