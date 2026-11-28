# Tasks

Scope: release 0.2.9 from the head that archives `sample-a2cb5fc-corrections`.

## 1. Version

- [x] 1.1 Set `VERSION` to 0.2.9 and move the Changelog's Unreleased entries under `[0.2.9]` dated 2026-11-28; done
      when the light gates pass.
- [ ] 1.2 The commands reviewer reads the cover, the edition line, the colophon and the printed blocks in the release
      PDF of the commit that completes section 2, and the reading is recorded as the `[[release]]` entry; done when
      `tests/test_acceptance.py` passes.

## 2. Page breaks

- [x] 2.1 The four layout checks the full proof found failing on pp. 21, 46 and 167 are repaired with the fewest
      wording changes; done when `tests/test_layout.py` passes.
- [ ] 2.2 The changed passages are reviewed and re-read as the stages that last read their pages require; done when
      `publication/acceptance/reviews.toml` records the reviews and `tests/test_acceptance.py` passes.
