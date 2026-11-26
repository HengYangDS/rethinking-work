## Why

The hosted GitHub jobs install Mise 2026.11.10. On 2026-11-26 the owner asked for the latest stable Mise
(「mise 升版本吧」 05:48, 「统一用最新稳定版」 05:49) and confirmed at 06:08 that this holds for every repository ETHOS
manages. That is 2026.11.14, published on 24 November 2026 and past the repository's 24-hour release age. The private
peer's macOS runners already run it: their Homebrew Mise moved to 2026.11.14 at 05:50.

## What Changes

- Move `[supply] mise_version` in `.config/ci/verification.toml` to 2026.11.14.
- Generate the pipelines again from the common model; the two `mise-action` steps of the GitHub workflow follow.
- Record the move under Changed in the Changelog's Unreleased section.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

None. The checks and the publication behave as before, so `.openspec.yaml` sets `skip_specs: true`.

## Impact

`.config/ci/verification.toml`, `.github/workflows/verify.yml` (generated) and `CHANGELOG.md`. The lockfile and the
locked tools stay as they are.
