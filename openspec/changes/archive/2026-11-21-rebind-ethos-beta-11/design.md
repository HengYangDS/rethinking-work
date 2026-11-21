## Context

See [proposal.md](proposal.md). The move follows the lane order used for every rebind: bind the release in the
lane, prove the archived head, land, and publish `dev`. The release's own declaration and checksums are kept with
their digests in the lane's local evidence (`build/evidence/rebind-ethos-beta-11/release-beta.11/`).

## Goals / Non-Goals

**Goals:**

- Run every gate and lifecycle command of the repository, locally and in the hosted jobs, on 0.2.0-beta.11.
- Carry the 14-day artifact retention into both generated pipelines.
- Keep the 0.2.0-beta.10 runtime as the rollback until the landing is accepted.

**Non-Goals:**

- Changing the book, its tests, gates or declared commands.
- Moving other supply; the hosted Mise moves in this lane's second Change, `move-hosted-mise-2026-11-10`.

## Decisions

- Copy the release's declaration unchanged into the `[tools."http:ethos"]` table and lock it with native
  `mise lock`, after checking each platform checksum against `SHA256SUMS` and the forge's asset digests. The lock
  keeps its format version.
- Regenerate both pipelines with `ethos lane project --apply` as a task of its own; the generated files are never
  edited by hand.
- Launch the local proof as before (from a launchd job with the application shell's `PATH`), which ran every proof
  of this repository under 0.2.0-beta.10; the hosted jobs on both forges decide before landing.

## Risks / Trade-offs

- [A gate that passed under 0.2.0-beta.10 fails under 0.2.0-beta.11] → The light gates run after the bind and the
  full proof before landing; a failure is repaired at its owner, or the 0.2.0-beta.10 declaration is restored in a
  new Change and the retained runtime bound again.
- [A rollback after the bind] → Restore the 0.2.0-beta.10 declaration and lock in a new Change, bind the retained
  runtime with `hook install --runtime <0.2.0-beta.10 runtime>`, and run the full proof before it lands.

## Migration Plan

Copy the declaration and lock it, install the locked supply, bind the runtime, generate the pipelines, run the
gates and prove the archived head; then land and publish `dev`. To roll back, follow the second risk above.
