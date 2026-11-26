# Publication design and execution

This directory owns the book's presentation, its build and check tasks, their supply, the reader notes of the edition
archive, the review records and the rights notices. It does not own manuscript claims or the edition's identity
(`book/metadata.typ`).

- [layout/style.typ](layout/style.typ): the `publication-design` show rule, the faces, the type sizes by role, the
  language, the measure and spacing, tables, notes and reader figures, over the unchanged publisher package, and the
  rules the checks read.
- [layout/front.typ](layout/front.typ): the cover and the contents, set from those faces and sizes; the front matter
  gives the cover's words and the contents' heading, and the entries come from the chapters and parts.
- [layout/figures.typ](layout/figures.typ) and [layout/palette.typ](layout/palette.typ): the look of every figure drawn
  with fletcher, and the colours the figures share with the text.
- [layout/packages.typ](layout/packages.typ): the Typst packages the edition imports, each at one version.
- [justfile](justfile): the native tasks; `just --justfile publication/justfile` lists them.
- [brewfile](brewfile): the Homebrew-owned PDF inspection supply.
- [supply/](supply/): the checksums of the Typst packages, the Noto Sans CJK SC archive and its faces, and the
  archive's address.
- [acceptance/reviews.toml](acceptance/reviews.toml): the reviews a head that changes the book's text or exercises
  needs, read by the tests.
- [notes/](notes/): the reader notes of the edition archive, filled from the edition's declared facts
  (`book/metadata.typ`) when it is built; a commands review reads them with the book and the exercises.
- [rights/](rights/): the publisher's notice and the third-party notices.

The document entrypoint, `book/main.typ`, selects the publisher and passes it the edition metadata with the paper,
margins and faces that the layout declares; `publication-design` owns every repeated page-design rule, and chapters
use it without a style of their own. Change a global rule here and look at every affected page. This follows Typst's
[separate-template pattern](https://typst.app/docs/tutorial/making-a-template/); the pinned package is not modified.

## Tasks

Run from the repository root as `just --justfile publication/justfile <task>`. `build` compiles the PDF, figures
included, and grants no editorial approval; `test` runs the publication and exercise checks; `exercises` runs only the
companion checks, without the PDF (see the [exercises](../exercises/README.md#check-every-example)); `edition-archive`
packages the PDF and the tracked exercises as one versioned `.tgz`; `check` runs formatting, the prose rules and the
tests; `test-env` installs the locked test environment on the declared Python line; `ci-supply` gives a CI account its
fonts, Typst packages, test environment and PDF tools; `ci-artifacts` builds the PDF and the archive and prints their
hashes. `render` writes every page as an image for review and does not inspect
its own output.

## Source CI

Both peers run the verification model of the owner's other repositories. The installed ETHOS release owns the model;
this repository supplies its parameters in [verification.toml](../.config/ci/verification.toml), the runner
prerequisites in [runners.toml](../.config/ci/runners.toml) and its own publication jobs in
[pipeline.cue](../.config/ci/pipeline.cue). `ethos lane project` writes `.github/workflows/verify.yml` and
`.gitlab-ci.yml` from them, and `ethos lane project --check` refuses drift; the generated files are not edited by hand.

Every job takes its supply the same way: `mise install --locked` installs the tools of
[config.toml](../.config/mise/config.toml) at their locked versions, and `mise run ci-supply` puts the faces of Noto
Sans CJK SC that [noto-faces.sha256](supply/noto-faces.sha256) lists into the account's font folder and the Typst
packages into its package cache, each checked against that list, [ci-noto.sha256](supply/ci-noto.sha256) and
[typst-packages.sha256](supply/typst-packages.sha256), synchronizes the locked test environment and checks the PDF tools
of [brewfile](brewfile). Supply that matches is kept. A verification job then runs the full proof,
`mise exec --locked -- ethos prove --host --execute --full`, and keeps its report as an artifact; a publication job runs
`ci-artifacts` and keeps the PDF and the edition archive. Each publication job takes its supply steps, rules, time limit, variables and
artifact lifetime from the verification job of the same peer and trust.

GitHub runs the jobs on the hosted macOS runner that `verification.toml` names, for pushes to its accepted and release
branches and to `proposal/` branches, `v*` tags, pull requests and manual dispatch; a full checkout carries the tags, so
a tag event builds that tag's edition. GitLab runs them on the owner's local macOS arm64 runners, as his other
repositories do: a protected runner for the accepted and release branches and `v*` tags and a review runner for merge
requests and `proposal/` branches, each locked to this project and running under its own account in the CI guest.
`MISE_CONFIG_DIR` and `MISE_CEILING_PATHS` keep the account's own Mise settings out of the job. Each runner account
holds its own copy of Homebrew's package index; without it, `brew bundle check` fails on a lock it cannot write.

Configuration and fixtures are trusted source inputs, not credentials or business data. A passing job is the full
proof, or the built artifacts, at that commit on that platform; it does not certify typography or approve an edition.
[Publication acceptance](../docs/publication-acceptance.md) is separate. The job records stay with each Forge.

## Supply

Homebrew owns the host installation; the tasks install nothing and run the executors their environment selects. Mise
binds the tools to the versions of [config.toml](../.config/mise/config.toml) through its lock. Poppler supplies
`pdfinfo` and `pdftotext` for the PDF checks: [brewfile](brewfile) declares it, `pdf-tool` checks its presence with
Homebrew Bundle and runs the requested command in that bundle's environment, and `pdf-tools-check` checks both
executables before `test` and `bootstrap`. Homebrew auto-update is disabled for these tasks. The Brewfile does not lock
Poppler's exact version.

Typst imports the packages that [packages.typ](layout/packages.typ) declares: Neat Book (the publisher package) and
fletcher (for the figures), with the packages they import. A first build may fetch these official packages;
[typst-packages.sha256](supply/typst-packages.sha256) pins every file of them, a test fails when the compile reads a
file it does not pin, and `ci-supply` fetches each package root it lists and checks every file.

The faces are declared once in [style.typ](layout/style.typ) (`declared-faces`), and a test holds the PDF to them:

| Family           | Use                                      | Supply                             |
| ---------------- | ---------------------------------------- | ---------------------------------- |
| Songti SC        | Chinese body text                        | macOS system font                  |
| Charter          | Latin body text                          | macOS system font                  |
| Noto Sans CJK SC | Headings, tables, figures, Chinese code  | Homebrew font cask, or `ci-supply` |
| DejaVu Sans Mono | Code                                     | Embedded font of the locked Typst  |
| Libertinus Serif | Symbols in code that the code faces lack | Embedded font of the locked Typst  |

The [font notices](rights/third-party-notices.md#authored-publication-fonts) distinguish standalone font files from
PDF embedding. The layout depends on macOS fonts; different font files can change wrapping and page count with
identical source. The edition's date comes from git once (`edition_inputs`: the release tag's date, or a draft's
commit date) and sets the document date and the PDF timestamps.

## Reader spacing rhythm

The body uses aligned paragraph starts with the type size `body-size` and the baseline `body-line` of
[style.typ](layout/style.typ). A paragraph transition is one empty body line (`par-space`). The module's `space` relates
heading, note and table spacing; tables keep a compact row baseline, and notes keep body leading with a smaller
paragraph interval. No chapter overrides body leading.

Numbered chapters begin on a new page; sections stay inside their chapter. A short block moves to the next page whole,
and a taller one leaves at least the least part the layout declares on each page. Matrix cells, note margins and note
insets are multiples of `space`. A full-page look follows any change of the rhythm.

The contents group the chapters by the parts that `book/manuscript.typ` declares; no title or page number is copied by
hand.
