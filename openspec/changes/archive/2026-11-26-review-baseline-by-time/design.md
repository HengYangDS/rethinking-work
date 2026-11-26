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
- A name `v<major>.<minor>.<patch>` and a signature block, so that a signed pre-release such as `v0.2.8-rc.1` or a
  name such as `vendor-x` is no release. All nine release tags carry one. The block is not verified; CI holds no key.
- The time is when the findings were written: a review begun before a release and written after it names that
  release, as a reader of the new edition meets it.
- A third independent review (13:2x) found that GitLab's clone fetches only the tags its commit reaches, so a lane
  without a release made before its review would pass on GitLab and fail elsewhere. Settled: the verification jobs
  fetch every tag, and a recorded tag absent from the clone fails with "fetch the tags"; the order of reading catches
  a record copied with its time; equal tag times fall to the higher version.
- The offset assertions move to a test named for them.

## Risks / Trade-offs

- [A release tagged off `main`] → None exists; `ethos land --release` tags `main`.
- [GitLab's tag fetch] → Shown by the first verification pipeline after landing (`git tag -l` is not printed; the
  proof's acceptance test reads the tags).
- [Parallel lanes appending records] → The order test fails on a merge that interleaves them; the editor reorders.
