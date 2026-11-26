## Why

The owner asked to release 0.2.8 (「发布 0.2.8」, 2026-11-26 13:46). `dev` at `10689a5` holds the work since 0.2.7: the
transfer cases as Chinese questions, the four errors found by blind judging of 0.2.7's unjudged notes corrected, the
review-baseline test, the two book READMEs, the overlapping requirements of the specification merged, and Mise
2026.11.14 in the hosted jobs. The sample of `e650b93` gave 0.47 errors per 10,000 characters, under the limit of one;
every passage changed since was read again by a reader who did not write it, with no error left open.

## What Changes

- `VERSION` becomes 0.2.8, a patch release: the changes correct the text, rewrite the transfer cases and tighten the
  checks; they add no capability.
- The Changelog's Unreleased entries move under `[0.2.8]` dated 2026-11-26, the day the tag is made; the edition's date
  comes from the tag.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. `.openspec.yaml` sets `skip_specs: true`.

## Impact

`VERSION`, `CHANGELOG.md` and the release record in `publication/acceptance/reviews.toml`. The release itself follows
the archived head as `docs/publication-acceptance.md` ("Release") describes, and is recorded by Git, the tag and the
forges.
