## Context

See [proposal.md](proposal.md). The reviewer reproduced the rebase case read-only: a lane from `f3e1028` with the trees
of `9ce18a2`, reviewed at 05:00, gives `v0.2.6` from its own head and `v0.2.7` after a rebase onto `9ce18a2`. Its report
is summarized in `build/evidence/after-0-2-7/code-review-findings.md`.

## Goals / Non-Goals

**Goals:**

- One answer for one record, whatever the lane's history becomes.

**Non-Goals:**

- Verifying signatures; CI holds no public key. The check sees that a signature is there.

## Decisions

- Time alone, as the reviewer proposed. A lane that does not yet hold a release made before its review still compares
  with that release, which is what "the last release" means for a reader of the new edition. Answers by time:
  `build/evidence/after-0-2-7/baseline-by-time.txt` (03:22 gives `v0.2.6`, 05:00 `v0.2.7`).
- `refs/tags/v[0-9]*` and a signature, so that a hand-made `v0.2.8-rc1` or `vendor-x` is no release. All nine release
  tags carry one.
- The offset assertions move to a test named for them.

## Risks / Trade-offs

- [A release tagged off `main`] → None exists; `ethos land --release` tags `main`.
