# Changelog

All notable repository changes are recorded here. The format follows
[Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/), and repository
versions follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
[VERSION](VERSION) is the sole source of the repository version. PDF editorial
identity remains in [book/metadata.typ](book/metadata.typ).

Entries under Unreleased describe work awaiting a source release; they do not
claim editorial acceptance or public publication. A released version's PDF and
practice archive are attached to its release on both peers; a release does not
by itself claim editorial acceptance.

## [Unreleased]

## [0.1.0] - 2026-11-17

### Changed

- **Breaking:** rebuilt the manuscript as an account of work and team
  collaboration in the agentic era, set in a quantitative data team's business
  context, in twenty-nine chapters with four
  practice modules, an epilogue and an afterword. The definition of work yields
  four unavoidable conditions and three working criteria; responsibility stays
  with people, so understanding stays with people. The same question, how
  understanding is reached, is then asked for one person, after work is handed
  to an Agent, and for several people, before the book returns to the person.
  The Agent has a part of its own that explains one Agent layer by layer
  (model, harness, context, tools, boundaries, memory); several Agents and
  evaluation close the handing-over part, after delegation has been taught.
  Chapters on the Agent end with a hands-on section, most run in a
  scratch repository the reader builds in the first-session chapter. Examples are
  scenarios in that context. The figure set is
  six diagrams; the book gains a one-page quick reference; the companion pack
  carries two session briefs with the returned query and the conditions those
  sessions ran under, the unchanged answers of a control group and of one run
  each on a stronger and a lighter model, the hook and skill files of the tools
  chapter, two model-free evaluation files and two Chinese templates in the
  book's own terms, and its self-check has seventeen tests.
- Qualified the rebuilt edition of 2026-11-17 for delivery. Details that could
  identify a vendor, a colleague, an internal system or a schedule were
  rewritten or dropped, and the practice figures of the second part's fourth
  exercise were replaced by an invented set; an independent panel read the whole book for argument and teaching, for Chinese
  prose and for disclosure, and its accepted findings were applied and checked
  against the records. A readability round then read every sentence in parts of
  about thirty pages; terms are explained at first use and keep one meaning, and
  hands-on steps say where to run, what to do and what to expect. The edition
  acceptance guide now requires this cold read after the last content edit.
  The whole book was then rewritten for standard written Chinese in the
  author's register: non-standard words and calques replaced, oral fillers and
  colon-and-semicolon chains reduced, and fitting idioms used where they say a
  thing more exactly; verifiers checked every change for meaning, usage and
  idiom fit, and disagreements between checkers were settled by the checkers
  themselves. The whole book was then rewritten in an objective third-person
  register: the business context is stated once, examples are scenarios that do
  not claim to have happened, nothing stresses who did or wrote what, and
  details weakly related to a point were cut. The preface opens on one scenario
  whose stake is a decision; appendix D keeps the run conditions of the
  demonstrated sessions and the table of premises. Fresh readers read every
  sentence again in parts, and readers of a different model family read the
  first three parts, the fifth and sixth, and the whole book once for
  continuity. A section heading now starts the next page unless about
  six body lines fit under it. The edition's complete text, code, tables,
  figures, outline, links and metadata were checked against the native
  document, every page was reviewed, and the PDF and practice archive were
  delivered to the reader targets and read back.
- Check the edition's layout over every body paragraph: the publication test now
  joins Typst's own paragraph positions with the PDF's lines and requires flush
  starts, 16 pt line steps and 32 pt paragraph steps, instead of locating two
  manuscript sentences. Appendix D's sections are found by label, and the
  practice-pack test counts the pack's own tests.
- Build the PDF and the practice archive on both peers. The private peer's
  local macOS runners now run the same `ci-artifacts` recipe as the hosted job
  and keep both files as job artifacts for 14 days. The private peer had lacked
  this job only because its earlier Linux runner could not use the licensed
  Apple fonts. Each released version carries both files on both peers.
- Configure the third-party release age as `0h` in the repository Mise settings,
  keeping the value explicit and adjustable without changing global policy.
- Run private-peer source verification on the owner's local macOS arm64
  runners, as the owner's other repositories do, with one runner for protected
  refs and one for review. The runner supplies Mise and its account keeps the
  locked tools between jobs. The earlier Linux job on a department runner, its
  job cache and its 15-minute script deadline are withdrawn; the lock keeps its
  Linux x64 records without a consumer.
- Adopt the verification model of the owner's other repositories: the installed
  ETHOS release generates both pipelines from `.config/ci/verification.toml`,
  and each job runs the full proof with ETHOS 0.2.0-beta.10 and uv 0.13.8 locked
  as tools. A supply task provides the Noto faces, Typst packages, test
  environment and PDF tools against the repository's manifests. The hosted
  publication build remains as the repository's own job. The publication-inputs
  gate's time limit is 300 seconds; 120 seconds was exceeded under host load.
  On CI runners Mermaid uses Chrome for Testing's headless shell, which the
  supply task installs checksum-checked; Google Chrome did not start under the
  local runner's launch context.
- Organized synthetic exercises by teaching case, separating reusable templates
  and transfer assessment while preserving fixture bytes and behavior.
- Separated publication layout, diagnostics, supply manifests and third-party
  notices, updating their native task and manuscript consumers.
- Moved the publication Node lock to the 26.13.1 security release, preserving
  the other five tool versions and npm sidecars.
- Bound the native Mermaid task to software rasterization through supported
  Puppeteer configuration, with a real-browser replay regression. Same-host
  stability is qualified; changed raster pixels still require successor review.
- Reworked the opening around a quantitative data department's complete work
  chain, from the research question and source evaluation to modeling,
  production, quality, delivery and feedback.
- Connected tool choices to consequential uncertainties and inspectable outputs,
  and expanded the teaching path from repeated answers to transferable judgment.
- Dated the substantive PDF successor 2026-11-11; reader qualification and source
  integration retain their independent acceptance boundaries.

### Added

- Shared-source native GitHub and GitLab CI for pipeline consistency, formatting
  and all 15 synthetic exercise contracts, with exact-commit checkout and a
  checksum-bound, job-local toolchain. Private-peer execution needs a suitable
  Runner; source CI does not replace full PDF qualification or editorial review.
- Exact macOS arm64 locks for the four CI tools and Linux x64 records for the
  seven native source-CI tools, preserving existing records and npm sidecars.
- A modular Chinese handbook for quantitative data teams, with worked data,
  research, engineering, delivery and team-learning cases, explicit source
  qualifications and decision-led tool guidance.
- A single edition metadata owner and native Typst, Mermaid, formatting and
  verification tasks, with navigable figures and reader references.
- A synthetic practice companion with 15 executable checks covering source
  selection, entity-level reconciliation, effective-date mapping, explicit UTC
  cutoffs, exports, structural search and API contracts.
- A checksum-bound compiler, font and complete Typst package input manifest,
  with native replay and three missing/altered-input regression tests. The
  same-host network-disabled replay matches the delivered PDF. Approved native
  Mise locks now bind six publication tools on macOS arm64; independent-machine
  bootstrap and cross-machine reproduction remain unqualified.
- A repository version source and contributor links distinguishing source
  releases from PDF editorial editions.
- Repository-specific GitLab collaboration and GitHub public-distribution peer
  declarations, with exact signed-source publication and separate remote checks.
- An MIT license for the authored source, copyright 2026 衡阳.
- A locked Python 3.12 verification environment and native JUnit/Cobertura
  reports from the existing test cases, including subprocess exercise coverage.
