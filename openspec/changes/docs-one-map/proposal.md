## Why

The organization review of 2026-11-25 (`build/evidence/repo-review-20261125/report-organization.md`, items 5, 7, 11
and 14) found the contributor journey four links deep (`AGENTS.md` → `CONTRIBUTING.md`, a pointer → `docs/README.md`,
an index → `docs/contributing.md`), the CI model and the test run told in several places, a false sentence about a
version literal in `pyproject.toml`, migration-era passages in the acceptance document, the release procedure written
only in three archived designs, and `openspec/config.yaml` saying no public licence is implied while the repository is
MIT-licensed and public.

## What Changes

- `CONTRIBUTING.md` holds the editing journey; `docs/contributing.md` and `docs/README.md` go. CI is told in
  `publication/README.md`, the tests in `tests/README.md`; the root README points to both.
- `docs/publication-acceptance.md` gains a "Release" section, the steps that the release Changes repeated, and loses the
  migration comparison, the contents' leader dots and the credential examples the book no longer holds.
- `openspec/config.yaml` states that a Change grants no remote publication or operational authority, and that a Change
  adding tested behavior states it as a requirement.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: a release follows the steps that the acceptance document states.

## Impact

`CONTRIBUTING.md`, `README.md`, `docs/`, `openspec/config.yaml`. The book and the build are unchanged.
