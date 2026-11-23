## Why

The owner asked for the next release to be sampled for its error rate first (「下一版发布前要再抽测差错率」, 2026-11-23
14:22), capped the Codex readers' cost at 50 USD (14:23), and then allowed the release once it is ready (「准备好后可以
发布」, 21:53). `dev` at `0e89027` holds 0.2.5's text: the whole-book cold read and its repairs, read five times and
looked at page by page (Change `qualify-0-2-5`). The sample read pages 124–174 of its PDF, apart from both earlier
samples, by two model families each judging the other blind: 105,823 characters, 0.15 errors per 10,000 against a
limit of 1 (0.32 under the stricter reading). Its counted and stricter errors are corrected here, with the same kinds of
fault elsewhere in the book, before the version is set.

## What Changes

- The sample's seven counted errors are corrected: a word (简短 for 简单), punctuation between clauses joined by 却 or
  但, a colon after 如下, list items separated by 顿号, corner brackets in a comment, and a table that wrote minutes in
  Arabic numerals and hours in Chinese ones. Its stricter items of the same kinds, and the same kinds found by a search
  of the whole book, are corrected with them.
- `VERSION` becomes 0.2.5, a patch release: the changes correct and restate; they add no capability.
- The edition date in `book/metadata.typ` becomes the release day, and the Changelog's Unreleased entries move under
  `[0.2.5]` with that date.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

Six book files, `VERSION`, `book/metadata.typ`, `CHANGELOG.md` and the review records. The release itself (tag, `main`,
the releases on both forges with the edition archive, the delivered copy) follows the archived head and is recorded by
Git, the tag and the forges.
