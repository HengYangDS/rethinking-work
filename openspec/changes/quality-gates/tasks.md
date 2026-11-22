# Tasks

Scope: the qualification of an edition and the typeset faults of decidable kinds. New scope enters as a task here before
it is worked.

## 1. Contract

- [x] 1.1 The requirements "Qualified edition" and "Typeset output keeps to its declared supply" are stated; done when
      `openspec validate --strict` passes.

## 2. Checks

- [x] 2.1 A test compares the PDF's embedded fonts with the toolchain's declared fonts; done when it fails on the layout
      of `d6b8e1e`.
- [x] 2.2 A test finds body paragraphs that end with a single character alone; done when it fails on the layout of
      `d6b8e1e`.
- [x] 2.3 A test requires a compile without warnings; done when it fails on a scratch copy given a warning.

## 3. Repair

- [x] 3.1 Every embedded face is declared; done when the font test passes.
- [x] 3.2 Line breaking ends no body paragraph with a single character alone; done when the lone-character test
      passes.
- [x] 3.3 The acceptance guide states the definition reviews cite, the check of printed commands and the error-rate sample;
      done when the requirement "Qualified edition" names each stage the guide describes.

## 4. Qualification

- [x] 4.1 The light gates pass, the changed pages are looked at, and the reader-run session confirms no printed block
      changed.
