# Rethinking Work

The source publication for **《重新理解工作》**, a Chinese field guide to judgment,
agent-assisted practice and durable team capability, by **衡阳**. It helps readers
choose a useful task, assemble the smallest effective toolchain, verify its
result and leave work another person can continue.

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

Reader references and case qualifications belong in
[book/back-matter.typ](book/back-matter.typ), alongside the manuscript they
qualify. Machine-specific receipts and private state do not belong in tracked
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

Keep these distinctions when adding material. A new tool example belongs under
the reader problem it solves, not in a new brand directory. A new medium should
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

Both native pipelines consume one [CUE definition](.config/ci/pipeline.cue) and
the repository's exact platform-specific tool locks. Pushes and pull requests on the
public forge run `just --justfile publication/justfile ci`: pipeline projection
checks, authored-file formatting and all 15 synthetic exercise contracts.
This job uses no business data, accounts, services, PDF fonts or browser.

The public hosted jobs passed on both `dev` and `main` at commit `1ee35a9`.
The private pipeline uses an owner-associated general Linux Runner with an
isolated Kubernetes executor. Its first jobs failed during image retrieval,
before source checks. Retrieval of the same approved image from a public mirror
passed at `38c6706`; Mise downloads then failed over both HTTP/2 and HTTP/1.1.
The Linux bootstrap now uses the official installer's primary download endpoint,
with the same version, archive checksum and HTTPS restrictions. Its isolated
bootstrap passed; private hosted source acceptance remains pending.
Source CI does not replace
the four ETHOS proof gates, full PDF qualification or human editorial review.
See [CI scope and supply](publication/README.md#source-ci) for exact boundaries.

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
