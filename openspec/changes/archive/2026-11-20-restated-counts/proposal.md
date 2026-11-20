# Proposal

## Why

On 2026-11-20 the owner made single source of truth a hard requirement for everything an agent writes (「SSOT,DRY,MECE,SOLID, 深模块，小表面积，充分解耦，声明式等最佳实践，是硬性要求」), and approved this correction twice: 「发布后修正」 for the counts and values restated in the contributor notes, the accepted spec and the pipeline declaration, and 「一起改」 for the same counts in the reader-facing notes. A read-only sweep on 2026-11-20 found fourteen groups of counts and values written beside their owners; three of them were already false (five or seven diagrams where the build renders six; ten declared tools where the lock holds twelve).

## What Changes

- Contributor notes (`docs/contributing.md`, `tests/README.md`, `README.md`, `publication/README.md`) name each fact's owner instead of restating its count or value: the number of exercise checks, diagrams, chapters, practice modules and appendices, Typst packages, font files and locked tools, and each locked tool's version.
- The accepted spec states the diagram set by its owner instead of a number, and its supply scenario no longer requires the contributor documents to carry tool versions.
- The pipeline declaration states the artifact retention once and uses it on both forges.
- The reader notes (`book/back-matter.typ`, `exercises/reader-guide.zh.md`, `exercises/AGENTS.md`) state the expected result without the count. The reader note in the edition archive is filled with the count at build time from the test file, as it already is with the version and the date.
- Two tests follow: the check that compared `exercises/AGENTS.md` with the test file no longer looks for the count there, and the archive test checks the count in the archive's reader note against the reader's own run.
- Dated records of past runs keep the numbers they recorded. The exercises' answers stay beside their questions.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the scenarios of "Declared supply release age" and "One test run per proof" name the declarations instead of a count or a document that restates versions; no behaviour changes.

## Impact

Affected: the four contributor notes above, the accepted spec, `.config/ci/pipeline.cue`, `publication/justfile` (the archive fills one more token), `publication/reader-start.zh.txt`, the book's appendix, two exercise notes, `tests/test_exercises.py`, `tests/test_practice_pack.py` and the CHANGELOG. The changed book text reaches readers with the next edition.
