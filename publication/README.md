# Publication design and execution

This directory owns presentation and the native task interface. It does not own
manuscript claims or a second edition identity.

- [style.typ](style.typ) owns the `publication-design` show rule and typography
  helpers, tables, notes and reader figures over the unchanged publisher package.
- [justfile](justfile) exposes the executable build and check commands.
- [brewfile](brewfile) declares the Homebrew-owned PDF inspection supply.
- [mermaid.json](mermaid.json) defines the shared diagram rendering settings.
- [puppeteer.json](puppeteer.json) selects software rasterization for the existing
  headless diagram browser without changing its executable or sandbox.
- [toolchain.json](toolchain.json) records the selected supply and reproduction
  limits, rather than installing software.
- [instrumented.typ](instrumented.typ) is a diagnostic entrypoint that exposes
  native page-bound text for complete-content comparison, not a second book.
- [third-party-notices.md](third-party-notices.md) preserves publisher attribution
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

## Supply and reproduction

Homebrew remains the host installation owner. The native tasks install nothing
and run the executors selected by their invocation environment. An isolated Mise
environment has qualified the six declared versions: Node 26.13.0, Python
3.12.16, Typst 0.15.1, Just 1.59.0, Mermaid CLI 12.2.0 and Prettier 3.9.10. Its
installation, version checks and native `check` pass; it is not a parallel host
installation or an accepted repository bootstrap. The selected supply and font
families are recorded in [toolchain.json](toolchain.json).

Poppler supplies `pdfinfo` and `pdftotext` for PDF Info, XMP and visible-cover
checks. [brewfile](brewfile) declares the package; the native `pdf-tool` task
checks its presence with Homebrew Bundle and executes the requested command in
that bundle's environment. `pdf-tools-check` checks both executables and is a
prerequisite of `test` and `bootstrap`. These tasks install or upgrade nothing
and disable Homebrew auto-update. The binding and native checks pass on the
authoring host. The Brewfile does not lock Poppler's exact version or qualify a
second-machine bootstrap; [toolchain.json](toolchain.json) records the version
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
metadata and every-page author visual self-review. Representative contents,
tool, return, official URL and companion-reference journeys also pass in Preview
and Chrome on the exact delivered PDF. These technical and reader-navigation
results do not establish human editorial acceptance or measured teaching
effectiveness; those remain open in the
[active Change](../openspec/changes/publication-foundation/tasks.md), which links
the edition-bound qualification and actual-reader receipts. The renderer-specific
observations above do not qualify the prose. Running `diagram` alone never
accepts or replaces a reader edition.

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
[font notices](third-party-notices.md#authored-publication-fonts) distinguish
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

The Mise declaration exposes the same tasks. The repository still has no
accepted `mise.lock` or complete dependency sidecars. Qualification of the
isolated environment does not promote those files into the repository or qualify
an independent-machine bootstrap. Poppler's separate Homebrew Bundle binding is
described above; it is not an exact-version lock. See the
[active Change](../openspec/changes/publication-foundation/tasks.md) for those
acceptance boundaries rather than treating a configuration file as runtime proof.
Frozen edition manifests retain the exact state they qualified; later contributor
documentation changes are not backdated into those manifests.

## Bound Typst input replay

`typst-inputs.sha256` binds the existing compiler executable, six font files
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
review the [font terms](third-party-notices.md#authored-publication-fonts).

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
