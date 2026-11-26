## Context

See [proposal.md](proposal.md). Each fact below has one carrier that a tool reads natively; every other mention reads
that carrier or points to it.

## Goals / Non-Goals

**Goals:**

- A change of the Python line, a tool release, a supply source or an output name is made in one file.
- The publication jobs follow the verification model without a second copy of its steps or rules.

**Non-Goals:**

- The move to Python 3.14. The installed ETHOS paradigm requires the lower bound of `requires-python` to equal its
  floor, 3.12, although its own rule lets a floor only rise; the full proof refuses any other line until ETHOS
  accepts a higher one.
- The book's identity, structure and layout constants.
- A carrier of ETHOS's own for steps that repository jobs share; the selection below stands until one exists.

## Decisions

- **The Python line lives in `.config/mise/config.toml`.** Mise installs it; `publication/justfile` reads it with
  `mise config get`, which works on an untrusted copy; Typst reads the same table in the back matter; the archive task
  fills the reader note's `@PYTHON@`; the practice-pack test runs the command that the extracted note prints.
  `requires-python` repeats the line because uv and ETHOS read only that field. A Mise template that read
  `pyproject.toml` was tried and rejected: ETHOS runs Mise in safe mode, where templates cannot read files. uv
  refuses an interpreter outside `requires-python`, so a change made in one place only fails when the environment is
  built.
- **Versions live in the locks.** `pyproject.toml` names the direct test dependencies; `uv.lock` pins every package.
  uv needs a project version even for a project it does not build, so the version is dynamic and read from `VERSION`
  by Hatchling, which builds metadata without writing into the source tree; setuptools left an `egg-info` directory
  at the root, and uv's own backend has no dynamic version.
- **Output names live in the task file.** `pdf` and `archive` are Just variables; the tests evaluate them with
  `just --evaluate`; the CI jobs keep `build/artifacts/pdf/*.pdf` and `build/artifacts/edition/*.tgz`, folders that
  the tasks keep to one file each.
- **CI supply sources live in `publication/supply/`.** The font archive's address is `noto.url`, its path and digest
  `ci-noto.sha256`, the faces `noto-faces.sha256`, and the Typst packages their manifest; `ci-supply` reads each.
- **The publication jobs extend the generated verification jobs.** `pipeline.cue` refers to the job that the model
  generates for the same peer, runner and trust and takes its rules, time limit, variables, artifact lifetime and the
  steps or commands before the one that prepares the evidence directory. The GitLab publication jobs therefore gain
  the full checkout and tag fetch of the verification jobs and the same 45-minute limit.
- **Proof output labels carry no version.** The native outputs pair by label; a version in the label would be one
  more copy of the Python line.

## Risks / Trade-offs

- [The model reorders its steps] → The selection stops at the evidence step by name; a renamed step fails the
  projection, and `ethos lane project --check` names the files.
- [`ci-supply` cannot run on this host without writing into the account's font folder] → Its first run is on the CI
  runners, whose jobs fail on a missing or changed supply.
- [A fresh lock fetches Hatchling] → Only resolution needs it; `uv sync --no-build` installs from the lock.
