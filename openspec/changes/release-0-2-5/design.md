## Context

See [proposal.md](proposal.md). The release follows 0.2.4's chain: correct and prepare in a lane, read the changed
sentences and the release PDF (cover, colophon, printed blocks), prove the archived head, land, publish `dev` and `main`,
tag with `ethos land --release`, build the edition archive from the tagged head, create the releases on both forges,
read them back by hash, deliver the archive beside the earlier editions, and note on the v0.2.4 release pages that
0.2.5 supersedes them.

## Goals / Non-Goals

**Goals:**

- Release 0.2.5 from the proved head with the same archive form as 0.2.4.

**Non-Goals:**

- The sample's quote-width item (curly quotation marks set in the Latin face, narrower than one character position):
  a book-wide layout change that moves every page; it joins the layout faults the every-page look found in the base
  (`qualify-0.2.5` decisions) for a layout change of its own.
- The sample's borderline item (standing.typ 「开盘前」 with 「那一刻」): both judges counted it as no error.
- Chapter 3's responsibility passage, which the owner settled; four reader points on it wait for him.

## Decisions

- The edition archive's builder (`publication/justfile` `edition-archive`) and the exercises are unchanged since 0.2.4,
  so 0.2.4's unpack check on Windows stands for this archive's form; it is not repeated.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash on
  both forges before delivery.

## Migration Plan

Not applicable; a later edition supersedes this one in the same way.
