## Context

See [proposal.md](proposal.md). The move follows the lane order used for every rebind: bind the release in the
lane, prove the archived head, land, and publish `dev`. The release's declaration and checksums are kept with their
digests in the lane's local evidence (`build/evidence/rebind-ethos-beta-12/release-beta.12/`).

## Goals / Non-Goals

**Goals:**

- Run every gate and lifecycle command of the repository, locally and in the hosted jobs, on 0.2.0-beta.12.
- Keep the 0.2.0-beta.11 runtime as the rollback until the landing is accepted.

**Non-Goals:**

- Changing the book, its tests, gates or declared commands.
- Migrating decision records to the Docs Registry's new form; that is a lane of its own.

## Decisions

- Change only the version in the `[tools."http:ethos"]` table, whose URLs take the version from it, and lock it with
  native `mise lock`, after checking each platform checksum against `SHA256SUMS` and the forge's asset digests. The
  lock keeps its format version and its two platforms.
- Bind with the new console's `hook install` from a neutral directory, then read the repository's `CURRENT` and
  `ROLLBACK` runtime selections and `ethos status`; the pipelines are regenerated only if `ethos lane project --check`
  reports them out of date.

## Risks / Trade-offs

- [A gate that passed under 0.2.0-beta.11 fails under 0.2.0-beta.12] → The light gates run after the bind and the
  full proof before landing; a failure is repaired at its owner, or the 0.2.0-beta.11 version is restored in a new
  Change and the retained runtime bound again.
- [A rollback after the bind] → Restore the 0.2.0-beta.11 version and lock in a new Change, bind the retained
  runtime with `hook install --runtime <0.2.0-beta.11 runtime>` (the `ROLLBACK` selection), and run the full proof
  before it lands.

## Migration Plan

Set the version and lock it, install the locked supply, bind the runtime, check the pipelines, run the gates and
prove the archived head; then land and publish `dev`. To roll back, follow the second risk above.
