# Design

See `proposal.md` for the reason.

## Context

Each fact this Change touches has one owner:

- The number of exercise checks: the `test_` methods of `tests/test_exercises.py`. Two tests already derive it from there (`test_agent_instructions_match_the_pack`, and the archive test, which compares the reader's run with the file).
- The diagram set: the `diagrams` recipe of `publication/justfile`.
- The chapters, practice modules and appendices: `book/manuscript.typ`, and the navigation test that lists them.
- Locked tools and their versions: `.config/mise/config.toml` and `.config/mise/mise.lock`; the headless shell: `headless_shell_version` in `publication/justfile`; the Mise of the hosted job: `.config/ci/pipeline.cue`.
- Typst packages and font files: `publication/supply/typst-packages.sha256` and `publication/supply/typst-inputs.sha256`.
- Layout values: `publication/layout/style.typ`.

The sweep and its re-verification at the release head are in the Change's local evidence `build/evidence/restated-counts/`.

## Goals / Non-Goals

**Goals:** every count or value above is written in its owner; every other mention names the owner; the three false statements disappear with their copies.

**Non-Goals:** any change in what the build, the tests or the proof do; dated records of past runs, which keep what they recorded; the exercises' answers, whose numbers are the teaching itself.

## Decisions

### D1. A pointer names the owner, not the value

A sentence that needs a version or a count says where it is declared ("the versions in `.config/mise/config.toml`"). A value beside a pointer is still a copy, so none is kept.

### D2. The reader note in the archive is filled at build time

The exercises' reader note in the edition archive states the expected result. The archive recipe already fills it from `VERSION` and the edition date; it also fills `@CHECKS@` with the number of `test_` methods in `tests/test_exercises.py`, counted the way the archive test counts them. The archive test already compares that number with the reader's run.

### D3. Reader notes inside the repository drop the number

`book/back-matter.typ`, `exercises/reader-guide.zh.md` and `exercises/AGENTS.md` are read from the source, where nothing fills a token. They say what the last line shows (`OK`, with the number of checks run) without stating the number. The test that compared `exercises/AGENTS.md` with the test file drops that comparison: with the copy gone there is nothing to compare, and its other checks stay. The archive test gains the comparison where the count now lives, in the archive's reader note.

### D4. The spacing section names the layout's declarations

The section "Reader spacing rhythm" of `publication/README.md` explains how the layout's spaces relate. It names the declarations of `publication/layout/style.typ` (`body-size`, `body-line`, `space`) and says which spaces are multiples of `space`, instead of giving their values in points.

### D5. One retention value in the pipeline declaration

`.config/ci/pipeline.cue` declares the retention once and uses it for the GitHub upload and the GitLab artifacts; the comment names it instead of restating it. `ethos lane project` regenerates the forge files, which change only if the value does.

## Risks / Trade-offs

- A contributor reads one more file to learn a version. In exchange, a tool move changes the lock and the declaration only, and no note goes stale.
- A reader of the book no longer sees the number of checks before running them. The run prints it, and the archive's own note states it.

## Migration Plan

Nothing to migrate. Rollback restores the removed numbers.
