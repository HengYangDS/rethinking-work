# Tasks

## 1. Declare each toolchain fact once

- [x] 1.1 Declare the Python line in the Mise configuration and `requires-python`, name the test dependencies without
      versions and relock; done when `uv lock --check` passes and both locks keep every package and tool version.
- [x] 1.2 Name the Python command, the PDF and the edition archive once in the task file, evaluate only what a recipe
      uses, add `test-env`, and read the CI supply from `publication/supply/`; done when `just --evaluate` prints the
      names and a recipe without them runs in a folder that lacks `VERSION`.
- [x] 1.3 Derive the reader note's and the back matter's Python line from the declaration, and point the contributor,
      exercise and publication guides to the declarations; done when no tracked file outside the two declarations, the
      locks, the changelog and the archive names the line.
- [x] 1.4 Make the practice-pack test read the output names and run the printed command, and share the tests' run
      options and root; done when the changed tests pass and the linters pass.
- [x] 1.5 Take the publication jobs' supply, rules, limit, variables and artifact lifetime from the generated
      verification jobs; done when `ethos lane project --check` passes.
- [x] 1.6 Record the Python line in each commands review; done when the acceptance test holds a head to a review of
      its trees and its line.
- [x] 1.7 State the requirements; done when `openspec validate declare-toolchain-once --strict` passes.

## 2. Review

- [x] 2.1 Answer each finding of the independent review in code or in this design; done when none is open.
- [ ] 2.2 Record the commands review and the reading of the changed `book/` and `exercises/` passages; done when the
      acceptance test passes on the head.
