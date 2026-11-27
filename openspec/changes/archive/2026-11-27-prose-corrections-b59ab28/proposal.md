## Why

Three judge families read the same sample of 0.2.9's final text (`b59ab28`); the third, Neon, counted thirteen places
the first two passed — eleven at 1-11 (语句不通, 2 points) and two at 2-1 (顿号 between clauses, 0.1 point). At the
acceptance document's rule the sample reaches 26.7 points over 100,878 characters, 2.65 per 10,000, above the bar of 1.
That document requires every error found, and its kind across the book, to be corrected before the release.

## What Changes

- Eleven places are rewritten where the words do not fit what they name: an action reported as passing a check
  (`diagnose.typ`), a subject that changes mid-sentence (`orchestrate.typ`), 接手 given reasons (`team.typ`), 写给 given
  a session (`writing.typ`), a price compared with a number of characters (`writing.typ`), 执行 given a view
  (`standing.typ`), 承担 given time and effort, 对…对外 stacked, 出自 with its terms reversed, and one requirement and one
  record clause that could be read two ways (`talent.typ`).
- Two places join free-standing clauses with 、 where standard written Chinese uses ， (`orchestrate.typ`,
  `standing.typ`); the same kind is corrected in `practice-doing.typ`, found by searching the whole book.
- No requirement of the book changes; the passages say the same thing, more exactly.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The corrections apply the existing requirement "Chinese prose" (standard written Chinese); no requirement changes,
so `skip_specs: true` applies.

## Impact

Six chapter files under `book/parts/`. Only wording and punctuation change; the sentence that compares costs
(`writing.typ`) and the one that names the judging party (`orchestrate.typ`) grow by a few characters.
