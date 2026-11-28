## Context

See [proposal.md](proposal.md). The release follows the steps of `docs/publication-acceptance.md` ("Release"), as 0.2.8
did.

## Goals / Non-Goals

**Goals:**

- Release 0.2.9 from the proved head with the archive form of 0.2.8.

**Non-Goals:**

- Changes to the text: the book is as the last re-read of `sample-a2cb5fc-corrections` left it, which counted no error.
- A fourth sample: the third, drawn from the whole body after the read-through's corrections, qualifies the edition.

## Decisions

- The edition qualifies by the third sample of the whole body, at 0.31 errors per 10,000 characters as its judges
  decided; every passage changed after it was re-read by two families until a re-read counted none.
- The release PDF is read before the tag at this head, built with the release inputs the tag will give it (edition
  `release`, date 2026-11-28); the tag event's build is compared with it by text after the tag.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash on
  both forges before delivery.
- [The tag falls after midnight] → The edition date would then differ from the changelog's; the tag is made the same
  day, or the date is moved before it.
