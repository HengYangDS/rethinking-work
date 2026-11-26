## Context

See [proposal.md](proposal.md). `verification.toml` is the only source of the hosted Mise release; `pipeline.cue`
reads it as `_inputs.ci.supply.mise_version`, and `ethos lane project` writes the native files.

## Goals / Non-Goals

**Goals:**

- Mise 2026.11.14 in every hosted job that installs Mise.

**Non-Goals:**

- Changing a gate, a check, the publication, a runner declaration or a locked tool; no step runs `mise lock --bump`.
- Deciding whether the pin stays exact or names the latest release; ETHOS 产品构建 decides that for the CI model by
  2026-12-03.

## Decisions

- One supply Change for the move, as the owner asked of each repository.

## Risks / Trade-offs

- [Mise 2026.11.14 changes the hosted install] → The hosted jobs on both forges run on the landed head; restoring
  2026.11.10 rolls it back.
