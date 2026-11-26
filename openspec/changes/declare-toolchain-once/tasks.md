# Tasks

## 1. Declare each toolchain fact once

- [x] 1.1 Declare the Python line in the Mise configuration and `requires-python`, name the test dependencies without
      versions and relock; done when `uv lock --check` passes and both locks keep their package versions.
- [x] 1.2 Name the Python command, the PDF and the edition archive once in the task file, add `test-env`, and read the
      CI supply from `publication/supply/`; done when `just --evaluate` prints the names.
- [x] 1.3 Derive the reader note's and the back matter's Python line from the declaration, and point the contributor
      and exercise guides to it; done when no tracked file outside the two declarations, the locks, the changelog and
      the archive names the line.
- [x] 1.4 Make the practice-pack test read the output names and run the printed command, and share the tests' run
      options and root; done when the test module imports and the linters pass.
- [x] 1.5 Take the publication jobs' supply, rules, limit, variables and artifact lifetime from the generated
      verification jobs; done when `ethos lane project --check` passes.
- [x] 1.6 State the requirements; done when `openspec validate declare-toolchain-once --strict` passes.

## 2. Review

- [ ] 2.1 Answer each finding of the independent review in code or in this design; done when none is open.
- [ ] 2.2 Record the commands review and the reading of the changed `book/` and `exercises/` passages; done when the
      acceptance test passes on the head.
