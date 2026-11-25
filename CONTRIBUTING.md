---
subject: rethinking-work:editing
role: how-to
state: active
relations:
  canonical_for: publication editing procedure
---

# Contributing

This repository maintains one Chinese publication. A contribution improves its argument, teaching cases, figures,
exercises, presentation or verification; it does not configure a reader's workstation or grant operational authority.
Keep the manuscript Chinese and contributor guidance English. Public examples stay synthetic or explicitly licensed.
Preserve facts, source roles, qualifications and old editions; a smoother sentence cannot erase an unknown. An author's
name in a PDF is attribution, not a certificate-based signature.

Change the source that owns the reader's difficulty, then verify its consumers. Start with the
[source map](README.md#read-and-edit), not a global search-and-replace or another publishing framework.
[Edition acceptance](docs/publication-acceptance.md) says what must be checked before a candidate becomes a delivered
edition, and how a release is made.

## Select one responsibility

An unclear argument belongs in its chapter. A repeated presentation defect belongs in `publication/layout/style.typ`.
A wrong relationship belongs in the figure's source in `diagrams/` and its nearby explanation; the look shared by all
figures belongs in `publication/layout/figures.typ`. A teaching failure belongs in the case, fixture or instructions
that produced it. Title and author belong only in `book/metadata.typ`; the edition and its date come from git
(`edition_inputs` in `publication/justfile`), never from a written date. The parts, their chapters and the reading
order are declared once in `book/manuscript.typ`.

When revising, keep the transferable mechanism in the argument and state a case's limit once. Rewrite any internal
detail before it enters the manuscript. Never convert package metadata into a claim of actual use, or a failed trial
into a success story.

| Change                              | Find the owner                                                      | Check the consumer                                        |
| ----------------------------------- | ------------------------------------------------------------------- | --------------------------------------------------------- |
| Improve a claim or case             | `book/parts/README.md`, then the chapter                            | Full changed meaning and affected PDF pages               |
| Correct a figure                    | The chapter's caption, `diagrams/README.md`, then the `.typ` source | The figure on its rebuilt page                            |
| Repair recurring page spacing       | `publication/layout/style.typ`                                      | Every page the rule affects                               |
| Change reading order or attribution | `book/manuscript.typ` or `book/metadata.typ`                        | Contents, bookmarks, visible attribution and PDF metadata |
| Improve a practice task             | The case in `exercises/cases/`, its fixture and expected outcome    | The stated command and both failing and valid controls    |

## Edit through the current owners

1. Run the installed `ethos status --root . --json` and read its version-matched guidance. Reuse the owned lane;
   preserve foreign or unknown edits.
2. Read the selected official Change, including its capability requirements and tasks. Obtain an exact passing
   `lane prewrite` admission before source edits.
3. Make the smallest coherent change. Update links, captions and source qualifications in the same change when their
   meaning is affected.
4. For publication inputs, run `just --justfile publication/justfile check`; it includes `prose-check`, the book's
   decided wording and punctuation. `build` compiles a candidate PDF, figures included. For guide-only edits, run
   `format-check` and the OpenSpec validation; do not rebuild unchanged inputs.
5. For a new edition, run `render` and look at every affected page, then qualify the complete candidate before
   delivery, as [edition acceptance](docs/publication-acceptance.md) describes.
6. Commit and follow the native proof and landing result. Source integration, artifact promotion and remote
   publication are separate, and a passing test grants no landing permission.

## Verify source behavior

The full proof, run locally through the host's admission as the ETHOS guidance describes, is the same one that the
hosted jobs and integration run ([source CI](publication/README.md#source-ci)). For a quick check without the PDF
supply, `exercises` runs the synthetic exercise contracts and `format-check` the formatting. After editing
`.config/ci/`, write the pipelines with `ethos lane project` (preview, then its printed apply) and check them with
`ethos lane project --check`. `edition-archive` packages the PDF and the tracked exercises as one versioned `.tgz`;
`tests/test_practice_pack.py` checks the extracted archive. How the proof and the local tasks run the tests, and what
the tests hold themselves to, is in [the test notes](tests/README.md).

The repository keeps Python on the 3.12 line; `VERSION` owns the version. Install the locked test environment with
`uv sync --locked --no-build --no-python-downloads --python python3.12`.

## Format only authored inputs

The installed Prettier owns Markdown, JSON and YAML formatting with preserved prose wrapping; its inputs and exclusions
live in the Just task and `.config/checks/prettier/`. Typst and Python keep their native syntax.

## Keep source and retention separate

Commit the manuscript, figure sources, fixtures, configuration and necessary guidance. Keep reproducible PDFs and
previews in ignored `build/artifacts/`, and local diagnostic output in `build/evidence/` or `build/ethos/` under its
native producer, with an exact source binding and consumer. A unique original or recovery preimage is not disposable
because a successor compiled; keep it with its evidence owner until its consumer releases it.
