# Publication design and execution

This directory owns presentation and the native task interface. It does not own
manuscript claims or a second edition identity.

- [style.typ](style.typ) owns the `publication-design` show rule and typography
  helpers, tables, notes and reader figures over the unchanged publisher package.
- [justfile](justfile) exposes the executable build and check commands.
- [mermaid.json](mermaid.json) defines the shared diagram rendering settings.
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

| Task                        | Effect                                                 |
| --------------------------- | ------------------------------------------------------ |
| `bootstrap`                 | Print installed executor versions; install nothing     |
| `diagram name` / `diagrams` | Rebuild one / all declared Mermaid figures             |
| `pdf`                       | Compile a candidate using already-rendered figures     |
| `build`                     | Rebuild figures, then compile the candidate            |
| `render`                    | Render all pages for visual inspection                 |
| `test`                      | Rebuild figures, then check publication and exercises  |
| `exercises`                 | Check synthetic data, export, search and API contracts |
| `format-check` / `format`   | Check / apply Prettier to declared authored formats    |
| `check`                     | Run formatting, publication and exercise checks        |

The invocation is `just --justfile publication/justfile <task>`.
`pdf` intentionally does not prove that images are freshly rebuilt; use `build`
when figure sources change. Rendering does not inspect its own output.
`test` and `check` rebuild the declared figures, so neither depends on images
left by an earlier build. They require the same headless browser as `build`.
`exercises` runs only the companion checks through existing DuckDB, Python 3.12,
ast-grep and oasdiff; it does not render figures or compile the PDF. See the
[exercise instructions](../exercises/README.md#check-all-runnable-examples).

## Supply and reproduction

The existing Homebrew installations own Typst, Mermaid CLI, Just, Prettier and
Python 3.12 on the current authoring workstation. No parallel tools are installed
by these tasks. The selected versions and font families are recorded in
[toolchain.json](toolchain.json).

Poppler supplies `pdfinfo` and `pdftotext` for PDF Info, XMP and visible-cover
checks. It is required by `test` and inspected by `bootstrap`, not installed by
either command. The concrete build version and its unresolved repository supply
qualification are recorded in `toolchain.json`.

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

The Mise declaration exposes the same tasks. No accepted `mise.lock` or complete
dependency sidecars exist yet. Its full locked supply qualification
must pass before it is claimed as a second-machine bootstrap path; the current
Just journey uses existing Homebrew executors. See the active Change for that
acceptance rather than treating a configuration file as runtime proof.

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
or prove deterministic regeneration from Mermaid source.

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
