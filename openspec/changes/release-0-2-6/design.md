## Context

See [proposal.md](proposal.md). The release follows 0.2.5's chain: correct and prepare in a lane, read the changed
sentences and the release PDF (cover, colophon, printed blocks), prove the archived head, land, publish `dev` and `main`,
tag with `ethos land --release`, build the edition archive from the tagged head, create the releases on both forges,
read them back by hash, deliver the archive beside the earlier editions, and note on the v0.2.5 release pages that
0.2.6 supersedes them.

## Goals / Non-Goals

**Goals:**

- Release 0.2.6 from the proved head with the same archive form as 0.2.5.

**Non-Goals:**

- The layout faults declined in `layout-faults` (full-width quotation marks, justification limits) and the base classes
  left as they were at 0.2.5.
- Chapter 3's responsibility passage, which the owner settled; four reader points on it wait for him.
- The tiers S–E with C as the passing line (owner, 2026-11-24 14:58): deferred to the next edition at his word
  (「先发，S–E 下版」, 15:36); DDWG's normative text changes first.

## Decisions

- The edition archive's builder (`publication/justfile` `edition-archive`) and the exercises are unchanged since 0.2.4,
  so 0.2.4's unpack check on Windows stands for this archive's form; it is not repeated.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash on
  both forges before delivery.

## Migration Plan

Not applicable; a later edition supersedes this one in the same way.
