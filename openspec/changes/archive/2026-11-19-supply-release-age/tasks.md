# Tasks

## 1. Release age

- [x] 1.1 Set Mise's `minimum_release_age` to 24 hours in `.config/mise/config.toml`; done when `mise settings` shows it from the repository's file.
- [x] 1.2 Set uv's `exclude-newer` to 24 hours and relock; done when `uv.lock` records the span and `uv lock --check` passes.

## 2. Tool moves

- [x] 2.1 Move ast-grep, oasdiff and uv to their newest admissible releases with `mise lock`; done when the configuration and the lock agree and `mise install --locked` succeeds.
- [x] 2.2 Move the hosted Mise in the pipeline declaration, the verification parameters and the supply checksum, and regenerate both forges' files; done when the projection check reports no drift.

## 3. Records

- [x] 3.1 State the new versions in `publication/README.md` and add the CHANGELOG entry; done when the format check passes.

## 4. Qualification

- [x] 4.1 Run the exercises and import the test environment through the locked uv, offline, under the new lock; done when both pass.
