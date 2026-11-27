# Tasks

Scope: correct the thirteen places the third judge counted, and their kinds across the book. New scope enters as a
task here before it is worked.

## 1. Corrections

- [x] 1.1 The thirteen counted places are rewritten; done when none of their original wording remains in `book/`.
- [x] 1.2 The two decidable kinds are searched across every chapter and the front and back matter, and each hit is
      corrected or classed as not the kind; done when the classed list is saved with the lane's evidence.

## 2. Verification

- [x] 2.1 The edition builds without warnings and the page count stays at or below `b59ab28`'s 200 ceiling; done when
      the built page count and the chapter openings are read from the new artifact.
- [x] 2.2 The readiness gates pass on the commit; the suite itself runs in the full proof that landing requires.

## 3. Review records

- [x] 3.1 The commands review and the reading of the changed passages are recorded; done when
      `tests/test_acceptance.py` passes.
