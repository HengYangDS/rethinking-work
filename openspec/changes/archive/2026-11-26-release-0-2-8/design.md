## Context

See [proposal.md](proposal.md). The release follows the steps of `docs/publication-acceptance.md` ("Release"), as 0.2.7
did.

## Goals / Non-Goals

**Goals:**

- Release 0.2.8 from the proved head with the archive form of 0.2.7.

**Non-Goals:**

- A new sample. The sample of `e650b93` stands for the text: every passage changed since was read again with no open
  point (`review-6ef03de`, `review-788b8eb`, `review-f609d1c`, `review-ef1b881`), as the qualification asks of text
  changed after a stage.
- The read-through's 247 Codex notes that no judge has seen; the owner's 「判 1」 did not include them.

## Decisions

- The release PDF is read before the tag at this head, built with the release inputs the tag will give it (edition
  `release`, date 2026-11-26); the tag event's build is compared with it by text after the tag.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash on
  both forges before delivery.
- [The tag falls after midnight] → The edition date would then differ from the changelog's; the tag is made the same
  day, or the date is moved before it.
