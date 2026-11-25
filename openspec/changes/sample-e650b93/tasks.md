# Tasks

## 1. Corrections from the sample of e650b93

- [x] 1.1 The five counted places and the two places of the same kind are corrected; done when the PDF builds without
      warnings at 197 pages and the layout checks find nothing.

## 2. Package supply

- [x] 2.1 oxifmt 1.0.0 is in `typst-packages.sha256` and the third-party notices; done when a compile with only the
      declared packages in its cache writes nothing to standard error.

## 3. Verification

- [x] 3.1 The suite passes on the commit (29 tests at 6ef03de).

## 4. Review records

- [x] 4.1 The commands review and the reading of the trees at `6ef03de` are recorded, and the `e650b93` entry names
      `v0.2.6`; done when `tests/test_acceptance.py` passes.
