## Context

See [proposal.md](proposal.md). ETHOS joins the repository's CUE with its declared inputs before evaluating it:
`.config/checks/ci-projection/policy.toml` binds `ci = ".config/ci/verification.toml"`, and the compiler appends
`_inputs: <the inputs>` to the source (ETHOS `adapters/projections/cue.py`). ETHOS's own `pipeline.cue` reads its
inputs the same way (`_inputs.mise.tools.uv`).

## Goals / Non-Goals

**Goals:**

- One source for the hosted Mise release; Mise 2026.11.10 in every hosted job that bootstraps Mise.

**Non-Goals:**

- Changing any gate, check, publication, runner declaration or locked tool.
- Changing the lockfile; no step runs `mise lock --bump`.

## Decisions

- Derive `supply.miseVersion` in `pipeline.cue` from `_inputs.ci.supply.mise_version`. The bootstrap checksum stays
  a file of its own: it pins the archive's bytes, a different fact, and is read from the release's `SHASUMS256.txt`
  and the forge's asset digest, which agree.
- The repository's own reader of `pipeline.cue`, `tests/test_typst_replay.py`, evaluates it the same way: it appends the
  inputs that `policy.toml` declares as `_inputs`. Read on its own, the file no longer evaluates (the first proof of
  this lane failed there).
- Make the move as the second Change of the beta.11 rebind lane, so that one proof and one pair of hosted runs cover
  both moves.

## Risks / Trade-offs

- [Mise 2026.11.10 changes the hosted bootstrap] → The hosted jobs on both forges run on the landed head; restoring
  the earlier version and checksum rolls it back.

## Migration Plan

Change the CUE reference, move the version and checksum, generate the pipelines, prove the archived head with the
rebind, and read both forges' jobs after landing. To roll back, restore the earlier version and checksum.
