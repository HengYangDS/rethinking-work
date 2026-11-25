## Why

The owner found that the edition's identity is hand-set (2026-11-25 13:33, 「那个 VERSION 文件中版本也不对吧？这也是个系统性
问题」): `VERSION` and a date written in `book/metadata.typ` are printed by every build, so `dev` built as 「0.2.5 版」 with
23 files changed after the release, and every candidate of 0.2.6 printed 「0.2.6 版 · 2026 年 11 月 25 日」 although each was a
different text. He made the fix 0.2.7's first task (15:21).

## What Changes

- **BREAKING** for readers of drafts: only a clean build of the commit that the signed tag `v<VERSION>` names is that
  version's edition, dated by its tag; every other build is a draft of the version, named by its commit (and marked
  when the tree has uncommitted changes). No date is written by hand.
- The build entry reads the identity from git once and passes it to every compile and to the archive's reader notes.
- The hosted publication job fetches the tag of a tag event, so a tag's artifacts are that edition.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the requirement "Portable and attributable edition" states where the version, the edition and
  its date come from.

## Impact

`book/metadata.typ`, `book/main.typ`, `book/front-matter.typ`, `publication/justfile`, the two reader-note templates, the
publication job in `.config/ci/pipeline.cue` and its projection, `tests/edition.py`, `tests/test_publication.py`, the
release procedure in the documentation. Out of scope: how `VERSION` itself is bumped.
