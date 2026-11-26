## Why

The repository repeats facts by hand: the Python line appears in the Mise configuration, `pyproject.toml`, the task
file, the reader note, the back matter, the contributor and exercise guides and the proof's output labels; the build's
output paths, the CI supply sources, the ETHOS download address and the publication jobs' rules, limits and supply steps
each appear in more than one place. A change to one leaves the others stale. The owner asked on 2026-11-26 that the
hard-coded facts be removed, and decided the same day that this repository supports Python 3.14 alone; that move is
a Change of its own, made in one declaration once this one has landed.

## What Changes

- The Mise configuration declares the Python line once; the task file, the back matter, the reader note and the
  practice-pack test read it, and the contributor and exercise guides point to it. `pyproject.toml` repeats it in
  `requires-python` for uv and ETHOS, and uv refuses an interpreter outside it.
- The test dependencies are named without versions; `uv.lock` pins them. The project's version is read from
  `VERSION` by a build backend that writes nothing into the source tree.
- The ETHOS download address is a template over the declared release.
- The task file names the PDF and the edition archive once; the tests evaluate the names and the CI jobs take the
  folders they lie in. The CI supply reads its font and package sources from `publication/supply/`.
- The publication jobs of both peers take their supply steps, rules, time limit, variables and artifact lifetime from
  the generated verification job of the same peer, runner and trust.
- The tests share one set of options for running a tool, with its time limit, and one repository root.

Out of scope: the move to Python 3.14, which the installed ETHOS refuses until its paradigm accepts a Python floor
above 3.12; the book's identity and structure (chapter numbers, edition names, part counts) and the layout's
constants, which follow in later Changes; the maintainer's local scripts outside the repository.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: "Independent publication build" keeps the artifacts as long as the verification job of the
  same peer; a new requirement declares each toolchain fact once.

## Impact

`.config/mise/`, `pyproject.toml`, `uv.lock`, `publication/justfile`, `publication/supply/`,
`publication/reader-start.zh.txt`, `book/back-matter.typ`, `.config/ci/pipeline.cue` and the generated pipeline files,
`.ethos/profile.toml`, `tests/`, `exercises/README.md`, `exercises/AGENTS.md`, `CONTRIBUTING.md`, the specification.
