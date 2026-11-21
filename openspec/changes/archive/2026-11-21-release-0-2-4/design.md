## Context

See [proposal.md](proposal.md). The release follows 0.2.3's chain: prepare the version in a lane, prove the archived
head, land, publish `dev` and `main`, tag with `ethos land --release`, build the edition archive from the tagged head,
create the releases on both forges, read them back by hash, unpack the archive on Windows, deliver it beside the
earlier editions, and note on the v0.2.3 release pages that 0.2.4 supersedes them.

## Goals / Non-Goals

**Goals:**

- Release 0.2.4 from the proved head with the same archive form as 0.2.3.

**Non-Goals:**

- Changing the book's text or checks; the owner's own reading of the edition, which enters a later Change.

## Decisions

- Patch version: the Unreleased section holds Changed and Fixed entries only.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges, so the archive is
  not blocked by work that can only follow it.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash
  on both forges before delivery.

## Migration Plan

Not applicable; a later edition supersedes this one in the same way.
