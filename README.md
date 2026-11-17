# Rethinking Work

The source publication for **《重新理解工作》**, a Chinese book on work and team
collaboration in the agentic era, by **衡阳**. Written from a data department
leader's position, it teaches a team how to think, act and collaborate when
producing a result has become cheaper than understanding it.

This is a publication repository, not a workstation manager or a new publishing
engine. The editable manuscript is Chinese; contributor guidance is English.
The edition identity lives in [book/metadata.typ](book/metadata.typ).
The repository version comes only from [VERSION](VERSION); its source changes
are recorded in [CHANGELOG.md](CHANGELOG.md). Repository versions and PDF
editorial editions have separate identities. A version file is not a release
tag or evidence of editorial acceptance.

## Read and edit

| Reader task                           | Source owner                                                                    |
| ------------------------------------- | ------------------------------------------------------------------------------- |
| Follow the argument and reading order | [Book](book/README.md)                                                          |
| Change one subject or teaching case   | [Manuscript parts](book/parts/README.md)                                        |
| Change page design or build settings  | [Publication](publication/README.md)                                            |
| Explain a relationship visually       | [Editable diagrams](diagrams/README.md)                                         |
| Practice with public synthetic inputs | [Companion exercises](exercises/README.md)                                      |
| Maintain and qualify an edition       | [Contributor guides](docs/README.md)                                            |
| Understand active change commitments  | [Official OpenSpec Change](openspec/changes/publication-foundation/proposal.md) |

The companion-exercise index and the statement of run conditions and limits belong in
[book/back-matter.typ](book/back-matter.typ). Examples are scenarios set in a
quantitative data team's business context; they name no person, vendor or project. Machine-specific receipts and private state do not belong in tracked
publication inputs.

## Source and output boundaries

The dependency path is `metadata + style + ordered manuscript + rendered
diagram inputs -> book/main.typ -> candidate PDF -> qualification -> reader
delivery`. Exercises are companion source, not a second copy of the book.
Contributor guides explain this path; the active Change alone tracks progress.
Each `exercises/cases/<case>/` keeps one case’s inputs, executable example and
expected outcome together; `exercises/templates/` and `exercises/assessment/`
serve reusable work materials and transfer practice respectively.

| Path                                 | Responsibility                                                 | Retention                                                     |
| ------------------------------------ | -------------------------------------------------------------- | ------------------------------------------------------------- |
| `book/`, `diagrams/`, `exercises/`   | Authored teaching and its editable inputs                      | Source history in Git                                         |
| `publication/`, `tests/`, `.config/` | Presentation, native tasks, checks and supply declaration      | Source history in Git                                         |
| `docs/`, `AGENTS.md`, `openspec/`    | Contributor navigation, agent entry and official change intent | Their existing native owners                                  |
| `build/artifacts/`                   | Candidate PDF, generated figures and page previews             | Rebuildable; preserve edition-bound bytes when required       |
| `build/evidence/`                    | Exact-input checks, review and failure receipts                | Retain through their named consumers; not a permanent archive |
| `build/runtime/`                     | Tool caches and bounded test work                              | Release only known owned residue after its consumers finish   |

Keep these distinctions when adding material. The manuscript follows one line: the root, then understanding at three scales (one person; the Agent and what happens after handing over; several people), then the person; four practice modules close the first five parts. A tool is named only
as an example of a role it plays. A new medium should
consume the same manuscript and identity rather than introduce another editable
edition. Do not add a generic `scripts/`, raw conversation dump or mirrored
source tree when the native task interface and topic owners already suffice.

## Build a candidate

Use the existing installed tools declared in
[publication/supply/toolchain.json](publication/supply/toolchain.json). The build requires
Typst's pinned publisher packages, the declared fonts and a headless browser for
Mermaid. See [supply and reproduction](publication/README.md#supply-and-reproduction)
before running it on a new machine; these commands do not install tools.

```sh
just --justfile publication/justfile bootstrap
just --justfile publication/justfile build
just --justfile publication/justfile check
just --justfile publication/justfile render
```

On a machine without Puppeteer's default browser, select an existing supported
browser executable through `PUPPETEER_EXECUTABLE_PATH` before `build`. Do not
add a personal browser profile or disable the browser sandbox.

The candidate is written to `build/artifacts/pdf/rethinking-work.pdf`; page
previews go to `build/artifacts/pages/`. These are generated, ignored outputs.
A successful build is not reader approval or publication. See
[edition acceptance](docs/publication-acceptance.md) for the remaining boundary.

## Contribute and retain

Start at [CONTRIBUTING.md](CONTRIBUTING.md). ETHOS governs source change; official
OpenSpec owns intent and task progress. Git retains committed source history.
Unique evidence and recovery originals stay with their declared consumers until
released, rather than being copied into a second archive here.

## Continuous verification

Both peers run the verification model of the owner's other repositories. The
installed ETHOS release writes their pipelines from the repository's
[verification parameters](.config/ci/verification.toml), and each job runs the
full proof with the repository's exact macOS arm64 tool lock
(`mise exec --locked -- ethos prove --host --execute --full`). The jobs use no
business data, accounts or services.

See [source CI](publication/README.md#source-ci) for the platform bindings,
passing hosted job records and supply qualifications. A passing job does not
replace full PDF qualification or human editorial review.

## Repository destinations and license

The same accepted source is published through ETHOS to two independent peers:

| Peer     | Role                       | Destination             | Visibility |
| -------- | -------------------------- | ----------------------- | ---------- |
| `github` | Public distribution        | A public forge project  | Public     |
| `gitlab` | Organization collaboration | A private forge project | Private    |

The peer declarations live in [.ethos/release.toml](.ethos/release.toml).
Publication preserves exact signed Git objects and verifies each remote
separately. Source publication does not certify editorial approval or a working
remote build. Both peers declare their native CI surfaces; actual job records
establish execution separately. Independent-machine PDF bootstrap remains
unqualified.

The authored source is available under the [MIT License](LICENSE), copyright
2026 衡阳. Third-party package licenses remain in
[publication/rights/third-party-notices.md](publication/rights/third-party-notices.md) and are
not replaced by this license.
