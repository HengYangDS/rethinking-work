# Publication design and execution

This directory owns presentation and the native task interface. It does not own
manuscript claims or a second edition identity.

- [style.typ](layout/style.typ) owns the `publication-design` show rule and typography
  helpers, tables, notes and reader figures over the unchanged publisher package.
- [justfile](justfile) exposes the executable build and check commands.
- [brewfile](brewfile) declares the Homebrew-owned PDF inspection supply.
- [mermaid.json](mermaid.json) defines the shared diagram rendering settings.
- [puppeteer.json](puppeteer.json) selects software rasterization for the existing
  headless diagram browser without changing its executable or sandbox.
- [toolchain.json](supply/toolchain.json) records the selected supply and reproduction
  limits, rather than installing software.
- [instrumented.typ](diagnostics/instrumented.typ) is a diagnostic entrypoint that exposes
  native page-bound text for complete-content comparison, not a second book.
- [third-party-notices.md](rights/third-party-notices.md) preserves publisher attribution
  and distinguishes third-party rights from the authored publication.

The document entrypoint selects the publisher and passes it the edition metadata
with the paper, margins and fonts that the layout module declares. The local show
rule owns repeated page-design behavior; manuscript
parts consume it without owning another style system. Change a global heading,
table or caption rule here and check every affected page.

This follows Typst's [separate-template pattern](https://typst.app/docs/tutorial/making-a-template/):
keep reusable presentation in an imported module and compose it through a show
rule. It does not add a publisher framework or modify the pinned package.

## Native tasks

Run from the repository root:

| Task                                 | Effect                                                        |
| ------------------------------------ | ------------------------------------------------------------- |
| `bootstrap`                          | Print installed executor versions; install nothing            |
| `pdf-tools-check`                    | Check declared, already-installed PDF inspection tools        |
| `pdf-tool <command> [arguments]`     | Run PDF inspection in the declared Homebrew environment       |
| `diagram name [format]` / `diagrams` | Rebuild one / all declared Mermaid figures                    |
| `pdf`                                | Compile a candidate using already-rendered figures            |
| `build`                              | Rebuild figures, then compile the candidate                   |
| `render`                             | Render all pages for visual inspection                        |
| `test`                               | Rebuild figures, then check publication and exercises         |
| `exercises`                          | Check synthetic data, export, search and API contracts        |
| `edition-archive`                    | Package the PDF and tracked exercises as one versioned `.tgz` |
| `format-check` / `format`            | Check / apply Prettier to declared authored formats           |
| `check`                              | Run formatting, publication and exercise checks               |
| `ci-supply`                          | Supply a CI account with fonts, packages, tests and PDF tools |
| `typst-package-check supply`         | Check the complete official publisher package trees           |
| `ci-publication [supply]`            | Check package inputs, build the PDF and edition archive       |

The invocation is `just --justfile publication/justfile <task>`.
`diagram name` produces PNG by default; `diagram name svg` renders the same
source and configuration as SVG for relationship and arrow-direction checks.
`pdf` intentionally does not prove that images are freshly rebuilt; use `build`
when figure sources change. Rendering does not inspect its own output.
`test` and `check` rebuild the declared figures, so neither depends on images
left by an earlier build. They require the same headless browser as `build`.
`exercises` runs only the companion checks through existing DuckDB, Python 3.12,
ast-grep and oasdiff; it does not render figures or compile the PDF. See the
[exercise instructions](../exercises/README.md#check-all-runnable-examples).

## Source CI

Source CI follows the verification model of the owner's other repositories. The
installed ETHOS release owns the common model; this repository supplies its
parameters in [verification.toml](../.config/ci/verification.toml), the runner
prerequisites in [runners.toml](../.config/ci/runners.toml) and one job of its
own in [pipeline.cue](../.config/ci/pipeline.cue). `ethos lane project` writes
`.github/workflows/verify.yml` and `.gitlab-ci.yml` from them, and
`ethos lane project --check` refuses drift; the generated files are not edited
by hand.

Each verification job installs the locked tools, runs `mise run ci-supply` and
then the full proof that local integration runs,
`mise exec --locked -- ethos prove --host --execute --full`. Its report,
`build/evidence/ci/verification.json`, is kept as the job's artifact. The tools
and their versions come from [config.toml](../.config/mise/config.toml) and its
macOS arm64 lock; the ETHOS console is declared there by the release's own file.
`ci-supply` puts the Regular, Bold and Black faces of Noto Sans CJK SC into the
account's font folder and the Typst packages into its package cache, checked against
[ci-noto.sha256](supply/ci-noto.sha256), the font lines of
[typst-inputs.sha256](supply/typst-inputs.sha256) and
[typst-packages.sha256](supply/typst-packages.sha256). It synchronizes the
locked test environment with uv and checks the PDF tools of [brewfile](brewfile),
installing them only where the account owns Homebrew. It also installs Chrome
for Testing's headless shell of `headless_shell_version` in the task file, the
build the locked Mermaid CLI expects, checked against
[ci-chrome-headless-shell.sha256](supply/ci-chrome-headless-shell.sha256), into
Puppeteer's own cache layout. Present supply that matches is kept. The task file
states Mermaid's browser once, so a proof does not depend on the shell that
starts it: the headless shell where it is installed, otherwise Google Chrome at
its standard path. On the local runners Google Chrome stopped at start under the
runner's launch context, while the headless shell runs.

Configuration and fixtures are trusted source inputs, not credentials or
business data. CUE and oasdiff retain disclosed unresolved Go advisories; DuckDB
and ast-grep scans did not establish complete dependency identity. The owner's
approval of this macOS toolchain was bounded to configuration checks and
synthetic exercises, without services, accounts or upstream dependency changes;
the full proof applies the same tools to the same trusted inputs. The lock keeps
its Linux x64 records from the earlier private-peer job; no pipeline reads them.

GitHub runs the verification job on hosted macOS arm64 for pushes to `dev`,
`main` and `proposal/` branches, `v*` tags, pull requests and manual dispatch.
GitLab runs it on the owner's local macOS arm64 runners, as the owner's other
repositories do: a protected shell runner (tag `ci-macos-arm64-shell`) for the
protected `dev` and `main` branches and `v*` tags, and a review runner (tag
`ci-macos-arm64-review`) for merge requests and `proposal/` branches. Each is
locked to this project and runs under its own account in the CI guest, whose
Mise store, font folder and package cache keep their supply between jobs.
`MISE_CONFIG_DIR` and `MISE_CEILING_PATHS` keep the account's own Mise settings
and parent directories out of the job. The guest's Homebrew supplies Poppler.
Each runner account holds its own copy of Homebrew's package index; without it,
`brew bundle check` fails on a lock it cannot write.

Until 2026-11-17 both peers ran a hand-written source job of pipeline
projections, formatting and the 17 exercises; the full proof replaced it. Until
2026-11-16 the GitLab job ran on a department Kubernetes runner under Linux x64.
That runner's evening downloads from public hosts were too slow for the tool
installation (6 to 12 kB/s per download from GitHub release hosts on
2026-11-16), so jobs ended before any check. Two remedies were measured on it
and withdrawn: a job cache, which the runner saved and never restored, and a
public GitHub proxy, which was slower and dropped connections. The records are
under `build/evidence/publication-foundation/` on the authoring host, in
`gitlab-download-cache-20261116/` and `gitlab-mirror-trial-20261116/`.

Hosted acceptance on 2026-11-14 verified all four branch jobs at commit
`9e293fab29bf079435766b4e21b22c2ab75f136d`. Each passed event and platform identity,
locked installation, pipeline projections, formatting and all 17 exercises,
without changing the locks. The two GitLab rows ran on the earlier Linux
runner. The initial GitHub `dev` attempt failed before a hosted Runner acquired
the job; the unchanged-commit rerun passed.

| Peer   | Branch | Run or pipeline        | Job          | Result  |
| ------ | ------ | ---------------------- | ------------ | ------- |
| GitHub | `dev`  | 43483107986, attempt 2 | 132095925245 | Success |
| GitHub | `main` | 43483340206            | 132085231533 | Success |
| GitLab | `dev`  | 15484                  | 70302        | Success |
| GitLab | `main` | 15485                  | 70303        | Success |

Hosted acceptance on 2026-11-17 verified both GitLab branch jobs on the local
runners at commit `c885a3b8c31c4db253234af3df8528ce76775a23`. Each ran
`verify:macos:protected` on runner `ci-p1444-macos-arm64-shell-protected` and
passed the same source checks without changing the locks. The first job installed the
eight tools; the second found them installed.

| Branch | Pipeline | Job   | Duration | Result  |
| ------ | -------- | ----- | -------- | ------- |
| `dev`  | 16094    | 72276 | 72 s     | Success |
| `main` | 16095    | 72277 | 7 s      | Success |

Hosted acceptance on 2026-11-17 verified the family's verification model at
commit `3e693f686b97b7ee2f62ccd8a0523fd8aad29cdc` on both peers. Each
verification job passed all twelve gates of the full proof. On GitLab the two
jobs ran on runner `ci-p1444-macos-arm64-shell-protected`, with all twelve tools
and the headless shell already supplied, in 165 s and 153 s. On GitHub the
publication job also built and uploaded the PDF and the practice archive.

The review runner `ci-p1444-macos-arm64-shell-review` ran its first hosted job
on 2026-11-17 for a `proposal/` push of the same commit: pipeline 16147, job
72430, passed all twelve gates in 182 s. A merge request whose source adds no
commit gets no merge-request pipeline from GitLab, so that trigger is exercised
by a merge request that carries a commit.

| Peer   | Branch | Run or pipeline | Jobs                                          | Result  |
| ------ | ------ | --------------- | --------------------------------------------- | ------- |
| GitHub | `dev`  | 43969851081     | verify 133658824993, publication 133658825372 | Success |
| GitHub | `main` | 43969850935     | verify 133658824363, publication 133658824693 | Success |
| GitLab | `dev`  | 16118           | 72344                                         | Success |
| GitLab | `main` | 16119           | 72345                                         | Success |

The job records and traces, including predecessor failures, remain under
`build/evidence/publication-foundation/` on the authoring host, in
`hosted-ci-20261113/` and `gitlab-local-runner-20261116/`. They are not
portable source inputs. A passing verification job is the full proof at that
commit on that platform; it does not certify typography, approve an edition or
establish merge protection.
[Publication acceptance](../docs/publication-acceptance.md) remains separate.

## Hosted publication build

The public macOS pipeline has a second job of the repository's own,
`publication`, which runs the native `ci-publication` task beside the
verification job. It bootstraps the checksum-bound official Mise that
[verification.toml](../.config/ci/verification.toml) names, as the verification
job does, and installs the locked tools
into job-local Mise state; it does not alter the authoring host or project lockfiles.
The private peer's `publication:macos` jobs run the native `ci-artifacts` task
on the project's macOS runners with the Mise those runners carry.

The job fetches the official Noto Sans CJK SC archive, verifies
[ci-noto.sha256](supply/ci-noto.sha256), and makes its Regular, Bold and Black
faces available to Typst and the disposable Runner's browser. Songti SC,
Charter and Apple Color Emoji remain native Apple-system inputs, referenced
only inside the licensed macOS job. No standalone Apple font is included in
the outputs. The exact browser version and font hashes are recorded in the
job log; differing Apple fonts or Chrome versions can change the rendered PDF.

The complete official Typst package trees of the package manifest are provisioned under
`build/runtime/ci/typst/packages/preview/` and checked against
[typst-packages.sha256](supply/typst-packages.sha256) before compilation.
Typst's supported environment settings disable ambient system-font discovery
and select the job-local font and package paths. Embedded fonts remain enabled.
Mermaid uses the Runner's existing Chrome through its supported executable
setting and the unchanged Puppeteer configuration; the sandbox stays enabled.

The task rebuilds every diagram of the `diagrams` recipe and produces
`build/artifacts/pdf/rethinking-work.pdf` and
`build/artifacts/edition/rethinking-work-<version>.tgz`, then refuses any
project-lock drift and prints both hashes. The edition archive holds one folder
`重新理解工作/` with a Chinese `先读.txt`, the PDF named with its version, the
exercises under `实战练习/` (only tracked `VERSION`, `LICENSE`, `exercises/` and
`tests/test_exercises.py`, plus their own `先读.txt`) and a `SHA256SUMS` of every
other file. Both reader notes are filled from `VERSION` and the edition date in
`book/metadata.typ`, and the exercises' note with the number of checks in
`tests/test_exercises.py`; a leftover token fails the task. The archive is a gzipped
tar, the format of the owner's other repositories: entries are sorted, dated to
the edition, owned by no host user and carry their names as UTF-8 in pax
headers, so a rebuild of the same commit yields the same bytes. The archive test checks the layout,
every checksum, both notes' version and reproducibility, and runs every
exercise check after extraction.

Official Noto bytes and all 238 listed package files have passed local input
verification. Hosted execution and artifact readback at `ea65454` are recorded
in task 1.4; successful source CI, compilation and author review are distinct
evidence boundaries.

## Supply and reproduction

Homebrew remains the host installation owner. The native tasks install nothing
and run the executors selected by their invocation environment. The project
Mise environment uses the tools and versions of
[config.toml](../.config/mise/config.toml). Version checks and the native
`check` pass on the authoring host; coverage, as locked in `uv.lock`, also passes
its pytest-cov consumer checks. The earlier isolated six-tool qualification used Prettier
3.9.10. Neither journey qualifies an independent-machine bootstrap.
[toolchain.json](supply/toolchain.json) retains its original edition's supply and
font binding rather than describing later tool updates.

Poppler supplies `pdfinfo` and `pdftotext` for PDF Info, XMP and visible-cover
checks. [brewfile](brewfile) declares the package; the native `pdf-tool` task
checks its presence with Homebrew Bundle and executes the requested command in
that bundle's environment. `pdf-tools-check` checks both executables and is a
prerequisite of `test` and `bootstrap`. These tasks install or upgrade nothing
and disable Homebrew auto-update. The binding and native checks pass on the
authoring host. The Brewfile does not lock Poppler's exact version or qualify a
second-machine bootstrap; [toolchain.json](supply/toolchain.json) records the version
used by the current build.

For example, inspect a candidate through the same declared binding:

```sh
just --justfile publication/justfile pdf-tool pdfinfo build/artifacts/pdf/rethinking-work.pdf
```

Typst imports `@preview/neat-book:0.1.0` and its publisher-declared dependencies.
Their first use may fetch official packages; subsequent builds can use the
existing package cache. The compiler's `inputs.json` records the actual package
and source closure, not a complete font closure. Do not call a first build offline
unless that supply exists.

Mermaid requires a supported Puppeteer browser. When its default browser is
absent, set `PUPPETEER_EXECUTABLE_PATH` to an already-installed compatible browser.
The task inherits this upstream setting and uses a separate headless
process, not a user's browser profile. Browser identity is part of a concrete
build receipt, not a portable hard-coded path. Never pass `--no-sandbox` merely
to obtain a successful render. The [upstream browser guide](https://github.com/mermaid-js/mermaid-cli/blob/master/docs/already-installed-chromium.md)
warns that only the bundled browser is guaranteed; an existing Chrome build must
be exercised with the selected CLI. A successful concrete build is not a promise
that every Chrome version is compatible.

The native diagram task passes [puppeteer.json](puppeteer.json) through Mermaid's
supported `--puppeteerConfigFile` option. Its only launch argument is
`--disable-gpu`. This avoids the default graphics path's observed pixel drift
with Mermaid CLI 12.2.0 and Chrome 157.0.8103.51 on the authoring host. Two
independent renders of each of the seven figures had identical PNG bytes with
this setting; the native-task regression also compares repeated output to a
same-input software-rendered reference. These are bounded host observations,
not a cross-browser or cross-machine guarantee.

The setting changes real antialiasing and shadow pixels, not only metadata.
Observed SVG geometry, labels and arrows are preserved; the exact Chrome-internal
cause is unproved. The delivered prose/supply successor includes substantive
manuscript revisions and has passed complete-content, structural navigation,
metadata and every-page author visual self-review. The current 113-page Documents
PDF loaded in Preview; representative contents jumps, cross-references, returns
and the DuckDB official link passed. The owned PDF window and external browser
tab closed; the remaining Open panel was dismissed, and Preview reported no
available windows. Original foreground restoration remains unproved because its
identity was not captured, as recorded in task 2.4 of the
[archived Change](../openspec/changes/archive/2026-11-17-publication-foundation/tasks.md). Human
editorial acceptance and measured teaching effectiveness also remain unproved
in task 2.1. Earlier tool and companion-reference journeys retain their original
edition bindings. Reuse each result only for its bound edition and demonstrated
scope.
The renderer-specific observations above do not qualify the prose. Running
`diagram` alone never accepts or replaces a reader edition.

The current PDF uses the following font supply. The diagram browser has a
separate selection; it does not need every Typst family.

| Family            | Publication use                          | Supply                            |
| ----------------- | ---------------------------------------- | --------------------------------- |
| Songti SC         | Chinese body text                        | Existing macOS system font        |
| Charter           | Latin body text                          | Existing macOS system font        |
| Noto Sans CJK SC  | Headings, tables and Mermaid labels      | Existing Homebrew font cask       |
| DejaVu Sans Mono  | Code                                     | Embedded font of the locked Typst |
| Libertinus Serif  | Symbols in code that the code faces lack | Embedded font of the locked Typst |
| Apple Color Emoji | Observed fallback for the memory credit  | Existing macOS system font        |

DejaVu Sans Mono and Libertinus Serif do not require a separate host installation with the current
Typst binary. [mermaid.json](mermaid.json) selects Noto Sans CJK SC; that family
must be available to the selected headless browser. The actual delivered PDF's
font list can be inspected with Poppler's `pdffonts`. The
[font notices](rights/third-party-notices.md#authored-publication-fonts) distinguish
standalone font files from PDF embedding and explain the applicable rights.

The current layout depends on macOS font supply. A second-machine build has not
been qualified. Same-host byte-identical replay is qualified only for the bound
inputs described below. Different font files or browser versions can change
wrapping and page count even with identical source.
Typst's supported `--font-path`, `--ignore-system-fonts` and
`--ignore-embedded-fonts` options control discovery; they do not supply fonts or
grant distribution rights. An open-font substitution requires a separate layout
decision, complete relayout and successor acceptance, not a silent build change.

The explicit date in `book/metadata.typ` supplies Typst's document date and PDF
timestamps; task commands do not carry a second copy. This reduces time drift
but does not establish byte-identical reproduction across machines. Match the
actual font files and renderer identities as well as the compiler, resolved
packages and diagram inputs before assessing reproduction.

The Mise declaration exposes the same tasks. The native lock at
`.config/mise/mise.lock` and its `aube-lock.yaml` and `package.json` sidecars bind
the declared tools. The scoped Prettier 3.10.1 update regenerated its two
sidecars through native Mise; Mermaid CLI 12.2.0 and all other tool records remain
unchanged. Each native tool has a macOS arm64 record, and the lock shows which
also have Linux x64 records; Prettier and Mermaid CLI use their npm sidecars.
Native resolution recognizes the installed tools and their sidecar-derived
paths. This adoption does not qualify an independent-machine bootstrap. Generated
Aube YAML remains byte-exact and outside the prose formatter's inputs. Poppler's
separate Homebrew Bundle binding is
described above; it is not an exact-version lock. See the
[archived Change](../openspec/changes/archive/2026-11-17-publication-foundation/tasks.md) for those
acceptance boundaries rather than treating a configuration file as runtime proof.
Frozen edition manifests retain the exact state they qualified; later contributor
documentation changes are not backdated into those manifests.

## Bound Typst input replay

`supply/typst-inputs.sha256` binds the existing compiler executable, the font files
it names and every file in the resolved publisher package roots. It contains no
font binaries, package source, credentials or private paths. The executable
binding also fixes its embedded fonts; this does not separately verify their
source provenance.

Provide these already-admitted inputs in one local supply directory:

```text
supply/
  bin/typst
  fonts/                     # The font files named in the checksum manifest
  packages/preview/          # The complete, unmodified package roots it names
```

Use the native checksum and compiler tasks from the repository root:

```sh
just --justfile publication/justfile typst-input-check /path/to/supply
just --justfile publication/justfile pdf-isolated /path/to/supply
```

The second task depends on the first. A missing or altered required input fails
before compilation. It selects only the supplied font directory and package
roots; Typst's embedded fonts remain enabled. Do not add alternate fonts or
packages to that directory. The checksum task verifies listed bytes, not the
absence of extra files. It neither downloads supply nor grants font-copying or
distribution rights. Keep Apple fonts local to a licensed Apple environment;
review the [font terms](rights/third-party-notices.md#authored-publication-fonts).

The output is `build/artifacts/pdf-isolated/rethinking-work.pdf`; this task never
replaces the reader edition. It consumes the diagram images currently in
`build/artifacts/diagrams/`. The checksum task does not bind those images, and
`pdf-isolated` neither freezes nor restores them. For an exact edition replay,
restore their bytes from that edition's qualification bindings before compiling.
This does not qualify their renderer or prove that they were freshly rebuilt.
Use the normal `build` task when changing diagram sources and qualify its new
output before replacing a reader edition.

The 2026-11-10 same-host qualification used a separate local input directory,
disabled network access and denied reads of the original font directories and
Typst package cache. All 245 required files were compared. The complete output
was byte-identical to the delivered edition. This proves a bounded replay with
those actual inputs, not an independent-machine bootstrap, dependency security,
source integration or complete locked publication supply. The original Change
retains those remaining acceptance boundaries.

The November 11 successor also reproduced byte-for-byte under the same isolation
after two drifted generated diagrams were restored from its frozen edition
inputs. Before restoration, every page's decoded content stream and extracted
text matched, but the full PDF bytes did not. Replacing only those two diagrams
restored the complete delivered PDF. The failed replay and changed images remain
with its qualification evidence. This establishes the effect of the changed
image inputs; it does not establish why the renderer produced different pixels
or prove deterministic regeneration from Mermaid source. The later software
rasterization qualification above narrows the remaining gap to other renderer
identities and machines; it does not retroactively qualify the default path.

## Reader spacing rhythm

The body uses aligned paragraph starts, with the type size `body-size` and the
baseline `body-line` of [style.typ](layout/style.typ). A paragraph transition is
one complete empty body line (`par-space`), not a manually inserted blank text
object. The module `space` relates heading, note and table spacing. Tables keep
a compact row baseline of their own; notes keep body line leading with a smaller
internal paragraph interval. Contents and code
keep their own native roles. No manuscript chapter overrides body leading.

Numbered chapters begin on a new page. Unnumbered topic sections remain inside
their chapter and use a smaller, consistent hierarchy; the contents show chapter
entries rather than treating every topic as a second chapter. Short notes stay
intact. Sticky headings and repeated table headers preserve navigation; a
full-page visual pass remains required after changing the rhythm.

Matrix cells, note margins and note insets are multiples of `space`, declared
in `matrix` and `note` of the same file. These repeated furniture spaces can be
tuned without shrinking body type or changing the paragraph rhythm. Evidence-scope
guidance follows the work-route matrix rather than orphaning the reading entry.

Worked reports retain framed notes. Short field reminders use an unframed
`takeaway` paragraph at full body size; they do not need a separate title row
and padded box. Complete short workflow tables can be kept together through
Typst's native block. Deliberate section breaks balance developed cases without
inserting filler or reducing body spacing. The official-link reference block
uses a compact reference rhythm, not the body-paragraph rule.

The contents use two generated native outlines in a grid, divided at the code
search chapter. The split preserves chapter order and destinations while
balancing the column lengths; no title or page number is manually copied.
