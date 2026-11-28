## Context

See [proposal.md](proposal.md). The release follows the steps of `docs/publication-acceptance.md` ("Release"), as 0.2.8
did.

## Goals / Non-Goals

**Goals:**

- Release 0.2.9 from the proved head with the archive form of 0.2.8.

**Non-Goals:**

- Changes to the text beyond the fewest wordings the layout checks need: the book is otherwise as the last re-read of
  `sample-a2cb5fc-corrections` left it, which counted no error.
- A fourth sample: the third, drawn from the whole body after the read-through's corrections, qualifies the edition.

## Decisions

- The edition qualifies by the third sample of the whole body, at 0.31 errors per 10,000 characters as its judges
  decided; every passage changed after it was re-read by two families until a re-read counted none.
- The release PDF is read before the tag at this head, built with the release inputs the tag will give it (edition
  `release`, date 2026-11-28); the tag event's build is compared with it by text after the tag.
- The full proof of the first archive head failed four layout checks: a wrapped line with one character alone and a
  sample box split with too thin a part on p. 21, a justified line opened past the bound on p. 46, and a page ending
  on a colon on p. 167. The corrections had been checked by page text and page count, not by these checks. Three
  wordings repair them: the sample box's count names 条数 as the paragraph before it does and drops 是……的; 可以运行
  and 就只剩 fill the line before a command that cannot break; 一轮后 for 一轮之后. They change pp. 21, 22, 46, 167
  and 168 only, and are reviewed and re-read as any change after a stage.
- The tasks end before archiving; the steps after it are recorded by Git, the tag and the forges.

## Risks / Trade-offs

- [A public release is not withdrawn] → The archive is built from the proved and tagged head and read back by hash on
  both forges before delivery.
- [The tag falls after midnight] → The edition date would then differ from the changelog's; the tag is made the same
  day, or the date is moved before it.
