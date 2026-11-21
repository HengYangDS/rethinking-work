# Tasks

Scope: the hosted Mise release, from one source. New scope enters as a task here before it is worked. Evidence paths
are under the local `build/evidence/rebind-ethos-beta-11/`.

## 1. Hosted supply

- [x] 1.1 Make `.config/ci/pipeline.cue` read the Mise release from `_inputs.ci.supply.mise_version`; done when
      `ethos lane project --check --json` reports the projections conforming with the version unchanged. Done 2026-11-21 14:22.
- [x] 1.2 Move `[supply] mise_version` to 2026.11.10 and the bootstrap checksum to that release's macOS archive,
      read from `SHASUMS256.txt` and the asset digest, and generate the pipelines again; done when the projections
      conform and only the Mise lines changed. Done 2026-11-21 14:23 (`mise-2026.11.10/`, `admission/project-mise-apply.json`).
- [x] 1.3 Record the move under Changed in the Changelog's Unreleased section; done when the format check passes. Done 2026-11-21 14:24.
- [ ] 1.4 Give the test that evaluates `pipeline.cue` its declared inputs as `ethos lane project` does, and let the
      publication README name `verification.toml` as the Mise source; done when the test passes in the light run
      and the full proof passes (the proof of `c6a88be` failed on that test, `proof/`).
