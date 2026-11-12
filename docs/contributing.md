---
subject: rethinking-work:editing
role: how-to
state: active
relations:
  canonical_for: publication editing procedure
---

# Editing and build journey

Change the source that owns the reader's difficulty, then verify its actual
consumers. Start with the [source map](../README.md#read-and-edit), not a global
search-and-replace or an additional publishing framework.

## Select one responsibility

An unclear argument belongs in its manuscript part. A repeated presentation
defect belongs in `publication/style.typ` or the document entrypoint. A wrong
relationship belongs in the editable diagram and its nearby explanation. A
teaching failure belongs in the case, fixture or instructions that produced it.
Title, author and editorial date belong only in `book/metadata.typ`.

The main entrypoint assembles the selected publisher and edition. The
`publication-design` show rule in `publication/style.typ` owns repeated heading,
table and caption design. The native date also supplies its human-readable form;
do not maintain a separate date string in a cover, task or contributor guide.

For a general-reader revision, keep the transferable mechanism in the argument
and the dated observation in the case qualifications. Do not mechanically replace
every occurrence of “本机”: that can hide source scope without improving the
reader's understanding. Never convert package metadata into a claim of actual
use, or a failed trial into a success story.

## Follow the editing path

| Change                              | Find the owner                                                             | Check the consumer                                        |
| ----------------------------------- | -------------------------------------------------------------------------- | --------------------------------------------------------- |
| Improve a claim or case             | Root source map, `book/parts/README.md`, then its module and qualification | Full changed meaning and affected PDF pages               |
| Correct a diagram relationship      | Manuscript caption, `diagrams/README.md`, then the `.mmd` input            | Rebuilt figure and its actual book page                   |
| Repair recurring page spacing       | `publication/style.typ`, composed by `book/main.typ`                       | Every page affected by the rule                           |
| Change reading order or attribution | `book/manuscript.typ` or `book/metadata.typ`                               | Contents, bookmarks, visible attribution and PDF metadata |
| Improve a practice task             | `exercises/README.md`, fixture and expected outcome                        | The stated command and both failing/valid controls        |

Use [Diátaxis](https://diataxis.fr/) to identify what the reader needs: explanation,
a guided learning task, a practical procedure or reference material. These are
writing purposes, not four mandatory directory trees. Keep a case with its
conditions and put a contributor procedure here; avoid duplicating the book's
lesson merely to fill a documentation category.

## Edit through the current owners

1. Run the installed `ethos status --root . --json` and read its version-matched
   guidance. Reuse the owned lane; preserve foreign or unknown edits.
2. Read the selected official Change, including its capability requirements and
   tasks. Obtain exact passing `lane prewrite` admission before source edits.
3. Make the smallest coherent change. Update links, figure captions and source
   qualifications in the same change when their meaning is affected.
4. For publication-input changes, run `just --justfile publication/justfile check`.
   Run `build` for changed diagrams and a candidate PDF; `check` rebuilds figures
   before checking the document, while `pdf` alone consumes existing renders.
   For contributor-guide or task-only edits, run `format-check` and the current
   official specification/task validation; do not rebuild unchanged publication
   inputs. Select the supported headless browser only when needed, as described
   in [publication supply](../publication/README.md#supply-and-reproduction).
5. For a new rendered edition, run `render` and inspect every affected page,
   then qualify the complete candidate before delivery. Reuse bound evidence
   for an unchanged artifact. Follow [edition acceptance](publication-acceptance.md).
6. Commit source and follow the current native proof and landing result. Source
   integration, artifact promotion and remote publication remain separate.

## Format only authored inputs

The original installed Prettier owns Markdown, JSON and YAML formatting with
preserved prose wrapping. Its input list and exclusions live in the native
Just task and `.config/checks/prettier/`. Typst, Mermaid and Python retain their
native syntax; do not run a generic whitespace rewrite over them.

Preserved exercises are complete originals during migration acceptance. Exclude
them from automated rewriting until the exact migration consumer releases that
binding. Later exercise edits are intentional revisions, checked against their
teaching contract rather than described as byte-identical copies.

## Keep source and retention separate

Commit the manuscript, diagram inputs, fixtures, configuration and necessary
guidance. Keep reproducible PDFs and previews in ignored `build/artifacts/`.
Local diagnostic output belongs in `build/evidence/` or `build/ethos/` under its
native producer, with an exact source binding and consumer.

A unique original or recovery preimage is not disposable because a successor
compiled. Preserve it with its existing evidence owner until migration, recovery
and failed-input review release their bindings. Do not move a user's windows,
application state or other tasks' scratch during publication cleanup.
