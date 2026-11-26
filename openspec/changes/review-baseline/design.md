## Context

See [proposal.md](proposal.md). The record names each review's subject and the time it was read; the release tags carry
the time they were made. Both CIs clone with full history (`fetch-depth: 0`, `GIT_DEPTH: "0"`), so the tags and the
ancestry the rule needs are there.

## Goals / Non-Goals

**Goals:**

- A copied baseline cannot pass the proof of a head it covers.

**Non-Goals:**

- Rewriting earlier records. Seven records of the 0.2.5 and 0.2.6 rounds name `v0.2.3` where the rule gives `v0.2.4`
  or `v0.2.5` (`build/evidence/after-0-2-7/baseline-by-rule.txt`); they cover no head that is still proved, and they
  record what was written then.

## Decisions

- The rule, not a stored value: the expected tag is derived from git and the record's own `read`, so no tag list is
  written into the test.
- "Made no later than the review", not "nearest ancestor tag": a review read before a release was tagged compared with
  the release before it (`6ef03de` was read at 03:22, before `v0.2.7` was made at 04:19).
- Only the reviews that cover the head are checked; the proof of each head is where a record starts to count.
- An "ancestor release tag" alone was rejected: it accepts the copied `v0.2.3` of `e650b93`, as the reviewer noted.

## Risks / Trade-offs

- [A clone without tags] → The check fails with a message that names the missing tags instead of passing.
- Whether the commands reviews of the 0.2.5 and 0.2.6 rounds ran every block changed since the release before them is not
  audited here; the reviewer found that the blocks changed after `v0.2.3` were run in the 0.2.4 round.
