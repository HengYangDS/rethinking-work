# Tasks

Scope: split the document checks into a shared build and two modules without changing an assertion. New scope enters as
a task here before it is worked.

## 1. Split

- [x] 1.1 `tests/edition.py` builds once per process; `tests/test_publication.py` and `tests/test_layout.py` hold the
      19 checks; done when all 19 pass in one run and every module measures under ETHOS's effective-line ceiling.

## 2. Qualification

- [x] 2.1 The light gates pass, and the full proof runs the same checks.
