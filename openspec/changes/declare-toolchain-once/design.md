## Context

See [proposal.md](proposal.md). Each fact below has one carrier that a tool reads natively; every other mention reads
that carrier or points to it.

## Goals / Non-Goals

**Goals:**

- A change of the Python line, a tool release, a supply source or an output name is made in one file.
- The publication jobs follow the verification model without a second copy of its steps or rules.
- A change that alters a printed command still needs its commands review, wherever the change is made.

**Non-Goals:**

- The move to Python 3.14. The installed ETHOS paradigm requires the lower bound of `requires-python` to equal 3.12
  and fixes Ruff's target at `py312`, so the full proof refuses any other line. The owner decided on 2026-11-26 that
  the fixed floor is a defect and that each governed repository declares its own; ETHOS plans the change for its next
  release, and this repository's move follows it as a Change of its own.
- The book's identity, structure and layout constants, and with them the printed pack lines: the exercise command's
  arguments still stand in the task file, the reader note and the back matter, and the reader notes are reader text
  that no review record covers. The Change that derives the book's printed pack facts takes both.
- A carrier of ETHOS's own for steps that repository jobs share; the selection below stands until one exists.

## Decisions

- **The Python line lives in `.config/mise/config.toml`.** Mise installs it; `publication/justfile` reads it with
  `mise config get`, which works on an untrusted copy; Typst reads the same table in the back matter; the archive task
  fills the reader note's `@PYTHON@`; the practice-pack test runs the command that the extracted note prints.
  `requires-python` repeats the line because uv and ETHOS read only that field. A Mise template that read
  `pyproject.toml` was tried and rejected: ETHOS runs Mise in safe mode, where templates cannot read files. uv
  refuses an interpreter outside `requires-python`, so a change made in one place only fails when the environment is
  built.
- **A commands review records the Python line with the trees.** The printed commands now take the line from outside
  `book/` and `exercises/`, so the record's key adds the line as the toolchain declares it; the three earlier records,
  all read on 3.12, carry it. Extracting a command for review evaluates the parts the source derives.
- **The task file evaluates only what a recipe uses** (`set lazy`), so a task that needs no edition, Python line or
  output name runs without `VERSION`, Git or Mise.
- **Versions live in the locks.** `pyproject.toml` names the direct test dependencies; `uv.lock` pins every package.
  uv needs a project version even for a project it does not build, so the version is dynamic and read from `VERSION`
  by Hatchling, which builds metadata without writing into the source tree; setuptools left an `egg-info` directory
  at the root, and uv's own backend has no dynamic version. Relocking kept every package and tool version; the Mise
  lock took the newer build of the same Python release and added the Typst and uv entries for linux-x64, a platform
  the lock already declares.
- **ETHOS's checksums live only in the Mise lock.** The download address is a template over the declared release;
  `mise lock` records each platform's checksum. The checksums copied by hand from the release, which travel with its
  assets over the same channel, are gone, and so is the linux-arm64 address, a platform no lock entry covers.
- **Output names live in the task file.** `pdf` and `archive` are Just variables; the tests evaluate them with
  `just --evaluate`; the CI jobs keep `build/artifacts/pdf/*.pdf` and `build/artifacts/edition/*.tgz`, which in a
  fresh checkout hold only the task's outputs.
- **CI supply sources live in `publication/supply/`.** The font archive's address is `noto.url`, its path and digest
  `ci-noto.sha256`, the faces `noto-faces.sha256`, and the Typst packages their manifest; `ci-supply` reads each.
- **The publication jobs extend the generated verification jobs.** `pipeline.cue` refers to the job that the model
  generates for the same peer, runner and trust. On GitHub the publication job is that job on the first declared
  runner, with its own steps; on GitLab it takes the job's rules, time limit, variables and artifact lifetime. Both
  take the steps or commands before the one that prepares the evidence directory. The GitLab publication jobs
  therefore gain the full checkout and tag fetch of the verification jobs and the same 45-minute limit.
- **Proof output labels carry no version.** The native outputs pair by label; a version in the label would be one
  more copy of the Python line.

## Risks / Trade-offs

- [The model reorders its steps] → The selection stops at the evidence step by name; a renamed step fails the
  projection, and `ethos lane project --check` names the files.
- [`ci-supply` cannot run on this host without writing into the account's font folder] → Its first run is on the CI
  runners, whose jobs fail on a missing or changed supply.
- [A fresh lock fetches Hatchling] → Only resolution needs it; `uv sync --no-build` installs from the lock.
- [An ETHOS upgrade trusts the downloaded asset] → The lock pins what the first download recorded; the release's
  published list is not compared.
