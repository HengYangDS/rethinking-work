# Tasks

Scope: the hosted Mise release, from one source. New scope enters as a task here before it is worked. Evidence paths
are under the local `build/evidence/rebind-ethos-beta-11/`.

## 1. Hosted supply

- [ ] 1.1 Make `.config/ci/pipeline.cue` read the Mise release from `_inputs.ci.supply.mise_version`; done when
      `ethos lane project --check --json` reports the projections conforming with the version unchanged.
- [ ] 1.2 Move `[supply] mise_version` to 2026.11.10 and the bootstrap checksum to that release's macOS archive,
      read from `SHASUMS256.txt` and the asset digest, and generate the pipelines again; done when the projections
      conform and only the Mise lines changed.
- [ ] 1.3 Record the move under Changed in the Changelog's Unreleased section; done when the format check passes.
