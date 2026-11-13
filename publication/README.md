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

The document entrypoint selects the publisher, paper, margins, fonts and edition
metadata. The local show rule owns repeated page-design behavior; manuscript
parts consume it without owning another style system. Change a global heading,
table or caption rule here and check every affected page.

This follows Typst's [separate-template pattern](https://typst.app/docs/tutorial/making-a-template/):
keep reusable presentation in an imported module and compose it through a show
rule. It does not add a publisher framework or modify the pinned package.

## Native tasks

Run from the repository root:

| Task                                 | Effect                                                  |
| ------------------------------------ | ------------------------------------------------------- |
| `bootstrap`                          | Print installed executor versions; install nothing      |
| `pdf-tools-check`                    | Check declared, already-installed PDF inspection tools  |
| `pdf-tool <command> [arguments]`     | Run PDF inspection in the declared Homebrew environment |
| `diagram name [format]` / `diagrams` | Rebuild one / all declared Mermaid figures              |
| `pdf`                                | Compile a candidate using already-rendered figures      |
| `build`                              | Rebuild figures, then compile the candidate             |
| `render`                             | Render all pages for visual inspection                  |
| `test`                               | Rebuild figures, then check publication and exercises   |
| `exercises`                          | Check synthetic data, export, search and API contracts  |
| `format-check` / `format`            | Check / apply Prettier to declared authored formats     |
| `check`                              | Run formatting, publication and exercise checks         |
| `ci-generate` / `ci-projections`     | Generate / verify both native pipelines from CUE        |
| `ci`                                 | Check pipeline agreement, formatting and 15 exercises   |

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

[pipeline.cue](../.config/ci/pipeline.cue) owns shared source verification and
projects the native GitHub and GitLab pipeline files. After changing it, run
`just --justfile publication/justfile ci-generate`, then `ci`. The projection
check rejects drift; generated files are not independent policy owners.

The job installs only Node 26.13.1, Python 3.12.16, Just 1.59.0, Prettier 3.10.1,
DuckDB 2.0.0, ast-grep 0.51.2, oasdiff 1.37.0 and CUE 0.17.1 from the peer-specific macOS arm64 or Linux x64
lock. The exact official Mise 2026.11.7 bootstrap is checksum-bound. Tool state
and downloads belong to the job's `build/runtime/ci/`; host Homebrew tools are
unchanged. Configuration and fixtures are trusted source inputs, not credentials
or business data. CUE and oasdiff retain disclosed unresolved Go advisories;
DuckDB and ast-grep scans did not establish complete dependency identity.
The approved macOS use is bounded to configuration checks and synthetic exercises,
without services, accounts or upstream dependency changes. Linux CUE adds eight
disclosed Go advisory identifiers, and the Node image's SBOM scan timed out.
The owner accepted this exact Linux toolchain for isolated configuration checks
and synthetic exercises. That acceptance does not establish dependency safety
or a passing hosted job.

GitHub runs on hosted macOS arm64 for pushes, pull requests and manual dispatch.
Both branch jobs passed at `8747f90`: pipeline projections, formatting and all
15 exercises. GitLab's first two jobs failed while pulling the image from Docker
Hub, before checkout or source execution. The private pipeline now retrieves
the same official Node manifest from Amazon ECR Public, with its digest,
configuration and seven layer bindings unchanged. The owner-associated general
Linux Runner and its global settings are unchanged; hosted acceptance of this
transport repair remains pending. Check the native job record, not the
presence of YAML, before reporting hosted success. This task does not render the
PDF, launch a browser, certify typography or establish merge protection. The
original four ETHOS proof gates and publication acceptance remain in force.

## Supply and reproduction

Homebrew remains the host installation owner. The native tasks install nothing
and run the executors selected by their invocation environment. The current
project Mise environment uses Node 26.13.1, Python 3.12.16, Typst 0.15.1, Just
1.59.0, Mermaid CLI 12.2.0 and Prettier 3.10.1, plus the four source-CI tools
listed above. Version checks and the native
`check` pass on the authoring host; coverage 7.17.3 also passes its pytest-cov
consumer checks. The earlier isolated six-tool qualification used Prettier
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
[active Change](../openspec/changes/publication-foundation/tasks.md). Human
editorial acceptance and measured teaching effectiveness also remain unproved
in task 2.1. Earlier tool and companion-reference journeys retain their original
edition bindings. Reuse each result only for its bound edition and demonstrated
scope.
The renderer-specific observations above do not qualify the prose. Running
`diagram` alone never accepts or replaces a reader edition.

The current PDF uses the following font supply. The diagram browser has a
separate selection; it does not need every Typst family.

| Family            | Publication use                         | Supply                                      |
| ----------------- | --------------------------------------- | ------------------------------------------- |
| Songti SC         | Chinese body text                       | Existing macOS system font                  |
| Charter           | Latin body text                         | Existing macOS system font                  |
| Noto Sans CJK SC  | Headings, tables and Mermaid labels     | Existing Homebrew font cask, version 2.004  |
| DejaVu Sans Mono  | Code                                    | Embedded font in Typst 0.15.1, version 2.37 |
| Apple Color Emoji | Observed fallback for the memory credit | Existing macOS system font                  |

DejaVu Sans Mono does not require a separate host installation with the current
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
the ten declared tools. The scoped Prettier 3.10.1 update regenerated its two
sidecars through native Mise; Mermaid CLI 12.2.0 and all other tool records remain
unchanged. All ten tools have macOS arm64 records; the seven native source-CI tools
also have Linux x64 records, while Prettier uses its portable npm sidecar.
Native resolution recognizes the installed tools and their sidecar-derived
paths. This adoption does not qualify an independent-machine bootstrap. Generated
Aube YAML remains byte-exact and outside the prose formatter's inputs. Poppler's
separate Homebrew Bundle binding is
described above; it is not an exact-version lock. See the
[active Change](../openspec/changes/publication-foundation/tasks.md) for those
acceptance boundaries rather than treating a configuration file as runtime proof.
Frozen edition manifests retain the exact state they qualified; later contributor
documentation changes are not backdated into those manifests.

## Bound Typst input replay

`supply/typst-inputs.sha256` binds the existing compiler executable, six font files
and every file in the eight resolved publisher package roots. It contains no
font binaries, package source, credentials or private paths. The executable
binding also fixes its embedded fonts; this does not separately verify their
source provenance.

Provide these already-admitted inputs in one local supply directory:

```text
supply/
  bin/typst
  fonts/                     # The six named files in the checksum manifest
  packages/preview/          # The eight complete, unmodified package roots
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
replaces the reader edition. It consumes the seven diagram images currently in
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

The body uses aligned paragraph starts, 10.5 pt type and a 16 pt baseline.
Paragraph transitions are 32 pt: one complete empty body line, not a manually
inserted blank text object. A 4 pt module relates heading, note and table
spacing. Tables retain a compact 14 pt row-text baseline; notes retain body
line leading with a smaller internal paragraph interval. Contents and code
keep their own native roles. No manuscript chapter overrides body leading.

Numbered chapters begin on a new page. Unnumbered topic sections remain inside
their chapter and use a smaller, consistent hierarchy; the contents show chapter
entries rather than treating every topic as a second chapter. Short notes stay
intact. Sticky headings and repeated table headers preserve navigation; a
full-page visual pass remains required after changing the rhythm.

Matrix cells use a 6 pt vertical inset; note margins use 12 pt and their
vertical inset uses 10 pt. These repeated furniture spaces can be tuned without
shrinking body type or changing the 16/32 pt paragraph rhythm. Evidence-scope
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
