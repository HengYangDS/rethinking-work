## Context

See [proposal.md](proposal.md). The release follows the steps of `docs/publication-acceptance.md` ("Release"), as 0.2.6
did.

## Goals / Non-Goals

**Goals:**

- Release 0.2.7 from the proved head with the archive form of 0.2.6.

**Non-Goals:**

- The readers' notes of the sample and the reread that were not judged errors; they stay notes.

## Decisions

- The release PDF is read before the tag at this head, built with the release inputs the tag will give it (edition
  `release`, date 2026-11-26); the tag event's build is compared with it by text after the tag.
- The edition archive's builder and the exercises' form are unchanged since 0.2.6 apart from the files the practice
  pack dropped; its own test reads the extracted archive.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash on
  both forges before delivery.
