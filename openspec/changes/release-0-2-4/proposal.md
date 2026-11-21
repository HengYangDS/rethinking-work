## Why

The owner decided on 21 November 2026 to release what `dev` holds since 0.2.3 (「CI 通过后发版」 15:57:26 and 「发布」
15:57:44), then set three conditions in turn: the whole-book review is repaired first (「等评审修完再发」, 17:04); a sample
of the repaired book is read for its error rate first (「先抽测」, 18:16); and after the sample's errors are corrected,
another stretch is sampled by another model family (「另抽一段测」, 22:32). The review landed on `dev` at `1749424`. The
first sample, read from the PDF of `943c183`, passed at 0.80 errors per 10,000 characters against a limit of 1. Its
errors are corrected, printed commands are made to survive copying from the PDF, and chapter 24 states 信、达、雅 as the
owner's one definition does. The second sample, read by OpenAI's model through Codex from pages 15–65 of `e618e05`'s
PDF, passed at 0.43 per 10,000; its seven agreed errors are corrected as well. All of this is on `dev` before the
version commit. The Changelog's Unreleased section holds every change since 0.2.3.

## What Changes

- `VERSION` becomes 0.2.4, a patch release under the repository's Semantic Versioning: the changes correct and
  restate; they add no capability.
- The edition date in `book/metadata.typ` becomes the release day.
- The Changelog's Unreleased entries move under `[0.2.4]` with that date.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`VERSION`, `book/metadata.typ`, `CHANGELOG.md`. The release itself (tag, `main`, the releases on both forges, the
delivered copy) follows the archived head and is recorded by Git, the tag and the forges.
