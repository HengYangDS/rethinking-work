## Context

See [proposal.md](proposal.md). The findings are in the reviewer's report, kept in this session's transcript and
summarized in `build/evidence/after-0-2-7/code-review-findings.md`.

## Goals / Non-Goals

**Goals:**

- The check gives the same answer in a local clone, on GitHub and on GitLab, in any time zone.

**Non-Goals:**

- Proving the tags reach GitLab's clone; the first pipeline after landing shows it.

## Decisions

- Anchor on the head: a head is a descendant or a rewrite of the reviewed commit, so the tag found from it is never
  older than the one found from the commit, and a copied older baseline still fails. Checked: `13abb16` with
  `f609d1c`'s time gives `v0.2.7`; `9ce18a2` with `6ef03de`'s time (03:22, before `v0.2.7` was made at 04:19) gives
  `v0.2.6`.
- `taggerdate`, as `publication/justfile` reads the release date; release tags are signed annotated tags made by
  `ethos land --release`.
- The latest covering review, by `read`: the head rests on it; holding every covering record would leave a head whose
  trees match an old record no remedy but rewriting that record.
- Each finding settled: 1 (unreachable subject), 2 (offset), 3 (lightweight tags), 4 (every covering record), 5 (one
  call, `lstrip=2` instead of `short`), 6 (`.get` in the setup) in code; 7 (wording, the test's name, the document's
  wrapping) in text. The design of `review-baseline` claimed a message naming missing tags; the message says to fetch
  them, which is what it can know.

## Risks / Trade-offs

- [GitLab's clone without tags] → The check fails with "fetch the tags" instead of passing.
