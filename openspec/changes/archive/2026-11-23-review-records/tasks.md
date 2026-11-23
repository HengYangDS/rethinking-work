# Tasks

Scope: the commands review and the reading of changed passages as tracked records read by a test. New scope enters as a
task here before it is worked.

## 1. Contract

- [x] 1.1 "Reviewed text before landing" is stated; done when `openspec validate --strict` passes.

## 2. Records and check

- [x] 2.1 `publication/acceptance/reviews.toml` holds the format agreed with the commands reviewer and the records of the
      current text; done when it parses and names review-601fbca and the prose-rules reading.
- [x] 2.2 `tests/test_acceptance.py` fails a head whose trees no record covers; done when it fails with the record's
      tree changed and passes with it restored.

## 3. Qualification

- [x] 3.1 The light gates pass and the commands reviewer reads the format and the stage text as built.
