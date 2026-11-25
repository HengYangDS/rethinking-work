## Why

The code and organization reviews of 2026-11-25 (`build/evidence/repo-review-20261125/report-code.md` items 1, 3 and 7;
`report-organization.md` items 1, 4, 5 and 6) found two supply paths and stale records. GitHub's publication job wrote
48 shell steps of its own supply (Mise from a checksum, Noto, eight Typst packages by hand, Apple font links, a manual
checkout, `TYPST_*` settings) while the other five jobs use `mise install --locked` and `mise run ci-supply`; the
package list stood in three places. `typst-inputs.sha256` repeated 238 lines of the package manifest and bound an old
compiler, used only by an offline replay of 2026-11-10 and its tests. `toolchain.json` was a frozen record read only
for its font list. `publication/README.md` was about a third execution history, several parts no longer true, and
`publication/diagnostics/instrumented.typ` had no caller. 0.2.7's plan retires the offline replay under the owner's
delegation unless he asks to keep it.

## What Changes

- GitHub's publication job has the shape of the others: checkout, Mise at the declared version, `mise install --locked`,
  `mise run ci-supply`, `ci-artifacts`, two uploads. Its runner needs only `mise` and `mkdir`.
- `ci-supply` reads the three Noto faces from `noto-faces.sha256` and the package roots from `typst-packages.sha256`.
- Retired: `typst-inputs.sha256`, `ci-mise-macos-arm64.sha256`, `toolchain.json`, the `typst-input-check`,
  `typst-package-check`, `pdf-isolated` and `ci-publication` tasks, `tests/test_typst_replay.py` and
  `publication/diagnostics/`.
- The layout declares its faces once (`declared-faces` in `style.typ`), and the font test reads them there.
- `publication/README.md` keeps the current contract only; the root README, contributing guide, tests README and agent
  entry follow.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `publication-source`: the PDF embeds only the fonts that the layout declares.

## Impact

`.config/ci/`, the generated `.github/workflows/verify.yml` and `.gitlab-ci.yml`, `publication/`, `tests/`, four
documents. The PDF is unchanged (text and embedded fonts compared).
