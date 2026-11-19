# Proposal

## Why

Edition v0.1.0 explains the layers of an agentic system well but teaches the team's own toolchain thinly: compared with the 2026-11-13 edition, the memory, orchestration and shared-configuration tools shrank to a line each, and many statements about what a tool or an Agent does were written from documentation, not from a run. The owner asked on 2026-11-14 and again on 2026-11-17 that the book cover theory and hands-on practice with the real tools, that every statement not yet tried be tried in an experiment, and that the shared configuration of a team (TeamAI) be written now.

## What Changes

- Inventory every statement in the manuscript whose truth depends on how a real tool, product, protocol or Agent behaves, and settle each by an experiment on this workstation, a primary source, or by narrowing or removing the statement.
- Rewrite the Agent and handing-over parts so that each layer is taught through the tool the team uses for it: what it is for, the commands, the output, how to tell it worked and how it fails, with versions stated once in the back matter.
- Add hands-on material where the inventory found a named tool taught by role only: memory (Hindsight), workspace, task and resident orchestration (Orca, Multica, Hermes), model configuration (AIGW), evaluation tooling, and the change and proof discipline the book itself uses (OpenSpec, ETHOS).
- Write the shared team configuration: how skills, rules and instruction files live in one team repository, reach each member's hosts, and return through review, taught through TeamAI from an isolated experiment.
- Correct the statements the inventory found wrong or outdated, including versions in the tool map, DuckDB's agent mode, permission-mode names and defaults, and instruction-file discovery.
- Run the Agent-behaviour claims that need a model as small, capped experiments with recorded conditions, and state their sample size where the result is used.
- Remove the hard-coded Chrome path from the publication tasks and the stale change path from the supply manifest.
- Raise the whole book's argument where the rewrite touches it, keeping the objective, formal register.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the account of work SHALL teach each Agent layer through a named tool with verified commands, SHALL ground behaviour claims in recorded experiments, and SHALL cover the team's shared configuration; organizing by how fast layers change no longer excludes tool material that teaches practice.

## Impact

The manuscript modules of the Agent, handing-over and team parts, the back matter, the companion exercises that gain new cases, the publication tests that check structure, and the publication task file are affected. Experiments run in isolated homes and scratch directories; none changes the owner's real configuration, accounts or the department's systems. Paid model calls run only under an explicit money cap. The book still discloses no internal name, vendor, system or figure; public products are named. Out of scope: operating the GitLab `dig` group, a separate workstation manual, and installing or upgrading tools.
