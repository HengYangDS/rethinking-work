# Design

## Context

See `proposal.md`. The current candidate uses Typst 0.15.1 and unchanged Neat Book 0.1.0. It contains 67 complete raw examples, 42 tables and seven diagrams. The old published edition and original receipts remain outside this repository. Their presence is not current editorial or reader acceptance.

## Goals / Non-Goals

The source tree must let an editor change one argument, teaching case, figure or presentation rule without searching a monolith. It must let another person reproduce the publication without copying the author's private stores.

This Change does not create a publishing engine, a new governance framework or a broad software inventory. The author has authorized MIT licensing for the authored source; third-party terms remain independent. It does not assert independent aesthetic approval or measured teaching effectiveness.

## Decisions

### Separate meaning from presentation

`book/` owns the ordered manuscript and metadata; `book/back-matter.typ` owns reader-facing references and case qualifications. `publication/` owns document-level style and diagram rendering configuration. `diagrams/` owns the editable Mermaid inputs. `exercises/` owns synthetic fixtures and portable cards. `docs/` explains contributor procedures only. Generated images, PDFs, previews and diagnostics belong under ignored `build/`.

The manuscript is divided into front matter, judgment, environment, capability roles, end-to-end practice, failure analysis, team learning, longer-term choices and references. This preserves conceptual relationships rather than splitting by page number. Tool-specific submodules can follow when editorial boundaries justify them.

### Let directories express responsibilities

Group each synthetic case’s inputs, code and expected outcomes under
`exercises/cases/<case>/`. Reusable work materials belong in `templates/`;
transfer cases belong in `assessment/`. Tests select the case directory
explicitly so SQL-relative inputs and Python imports keep their original
behavior. Do not split one case across global data, SQL and expected-output
folders merely to classify file extensions.

Keep publication layout, diagnostics, consumed supply manifests and rights
notices distinct. The root README and Just interface remain navigation and
execution entry points. Small coherent trees need no additional nesting. ETHOS
owns common governance interfaces and native configuration admission; the
publication owns its content taxonomy. Leave configuration carriers in their
current admitted locations until their native owner accepts a supported move.

### Reuse native tools

Use Just as the visible task interface and Typst, Mermaid CLI, Prettier, Python unittest and Git as their native executors. Mise exposes the same common verbs and owns future locked repository resolution; its acceptance does not follow from configuration alone. Do not introduce a PDF engine or custom installer. Existing Homebrew installations remain the host owners for the current build. The pinned Neat Book import remains unchanged; no vendor code is copied or patched.

Alternatives considered: a single self-contained Typst file is easy to send but becomes difficult to edit; a new generic publication framework adds abstractions before a second real consumer exists. Modular document-owned sources are the proportionate choice. Archpub's separation of authored meaning, rendered media and acceptance is useful here; its current CLI is not claimed to build this PDF.

### Preserve migration before promotion

Record a complete selected-input manifest and verify exact bytes and modes against the current candidate before accepting the modular migration. Private machine source bindings stay in existing local evidence; portable references expose no host username or secret. Existing failures and old editions remain retained. No broad temporary-root deletion is part of formation.

### Keep edition identity in one place

`book/metadata.typ` owns title, subtitle, author, editorial date and keywords. Cover and PDF document metadata consume it. Git signing identity stays separate. Textual author attribution is not a certificate-based PDF signature. The root `LICENSE` owns the author's MIT grant; no ISBN, publisher or third-party endorsement is invented.

## Risks / Trade-offs

- Installed fonts make byte reproduction platform-dependent. Name the fonts and record the actual build; do not redistribute fonts without rights.
- Cached publisher packages may require a one-time official download on another workstation. State this supply step separately from offline builds.
- The imported draft still contains workstation-centric passages. Structural migration does not satisfy the general-reader revision.
- Automated compilation and input checks cannot judge teaching effectiveness or taste. Inspect every changed page and retain explicit reader-review limits.

## Migration Plan

Preserve selected originals, admit exact destination paths, split the manuscript while checking native raw/table/figure parity, build through the declared tasks, and verify metadata and page extraction. Then revise the general-reader narrative and inspect the complete new edition. Promote only a qualified artifact; keep the prior consumer output unchanged until that point. Local source commits, ETHOS landing and public release remain separate effects.

### Reader-led paragraph rhythm

Use flush-left body paragraphs and one complete blank body line, as requested by the reader. The presentation owner defines a 10.5 pt body size, 16 pt baseline and 32 pt paragraph transition; headings, notes, tables and code retain distinct, fixed roles on a 4 pt spacing module. Remove chapter-specific body leading overrides. Larger spacing must not be paid for with smaller type or lost prose: rebalance short spill-only continuations through native page and heading composition, and inspect every final page. This is an authored layout revision, not independent reader approval.

### Teach decisions through worked practice

The reader rejected the edition's intellectual depth and practical teaching value on 2026-11-08. The earlier editorial, layout, navigation and delivery receipts remain records of that edition; they do not accept its successor. Compilation, source counts and preserved bytes cannot decide whether a reader learns how to reason.

Organize the argument around work objects and consequential decisions: business meaning, data representation, research validity, implementation, production, product use, collaboration and capability growth. Tool roles enter at the point where they remove a named obstacle. Installed software is supporting context, not the book's scope model. The department guidelines contribute normative distinctions and explicitly illustrative cases; repository sources contribute bounded mechanisms; historical operation receipts contribute dated observations. None alone establishes department adoption or business benefit.

Each substantial case must expose the initial question, missing facts, serious alternatives, a discriminating check, the changed judgment and its consequences. Give the reader a nearby changed-condition problem and explain why the original answer may no longer hold. Model session guidance as a sequence of increasingly informed decisions, not a perfect opening prompt. Preserve the distinction between reconstructed teaching dialogue and verbatim conversation.

The selected approach is a case-led revision within the existing modules. Adding a larger brand catalogue would preserve the original selection error; a grand theory chapter without worked decisions would preserve the original teaching gap. Retain useful examples, commands, qualifications and references, while revising repetitive argument and defensive prose. Keep detailed source bindings in the existing evidence owner and portable case qualifications in the existing back matter. No second inventory or progress register is created.

Editorial review must follow the whole argument and inspect each load-bearing case against its selected sources. It must answer whether a reader can identify the decision, explain the rejected alternative, choose a next check, and adapt the method when one condition changes. This is an editorial judgment with explicit reasoning, not a measured classroom result or a self-awarded claim of mastery. Changed manuscript meaning invalidates final-page and promotion qualification for the next edition without undoing the earlier delivery.

### A connected reading path

The reader's 2026-11-08 feedback identifies a substantive coverage defect: two
brief Open Code Review mentions do not teach when, why or how to use it. Assess
capabilities by the work decision they support, the complete usable path, the
result and a changed-condition problem, not by product-name frequency. Keep the
existing source bindings and request mapping as navigation, never an exhaustive
teaching certificate or a new inventory authority.

Practicality does not replace theory or a technical system. The reading path
starts with an inspectable task, explains its reasoning, locates the required
technical roles, then uses failure and transfer to test the explanation. Show
that relationship in the front matter and explain the technical system through
the existing export case. Tool reference remains available for experienced
readers; the main path must not require memorizing the whole catalogue.

Use writing techniques only where they perform a teaching job: concrete openings
show the work object; a sustained case connects chapters; causal transitions
explain the next decision; serious alternatives reveal the cost of a choice;
worked outputs show the expected result; changed conditions teach transfer.
Remove empty elevation, repetitive disclaimers and generic conclusions in their
original prose owner while preserving distinct facts, qualifications and source
roles. This is author revision, not AI-detector certification or measured reader
learning.

Open Code Review belongs in the existing quality chapter. Distinguish deterministic
delegate preparation from a model-backed review, explain the actual target,
resolved rules, complete diff, findings and acceptance, and use the original
synthetic export contract for a worked comment. Native version/help and complete
installed publisher Skills support the command templates; no model call, new
reviewer, credential read, installation or consumer change is authorized.

### Mechanisms that support transfer

The reader explicitly retains both theory and the technical system alongside
practical teaching. Role definitions alone leave a gap: readers cannot yet
explain how an invocation becomes an observation, why a valid call can violate a
business contract, or when stable execution should replace dynamic choice.
Develop those relationships in the existing judgment, interface and data owners,
using the export and reconciliation cases. Keep theory as explanation and
condition-sensitive prediction, not an isolated slogan or a mandatory taxonomy.

The selected Hermes source supports one concrete tool-call implementation;
reading it does not qualify runtime branches or every Agent product. The
workflow discussion relates fixed dependencies, dynamic investigation and
durable effects to the existing ECB cancellation case. Preserve examples,
comparison data and qualifications. Advance the editorial date to November8
because the manuscript and selected observations changed, while retaining the
November7 environment snapshot's exact scope. No all-host refresh is implied.

### Select techniques by the missing work condition

The source-mechanism explanation still assumes that readers can distinguish a
model request from an indexed retrieval and model training. Develop these
mechanisms in the existing technical-system and knowledge owners. Explain
non-deterministic output and bounded context, then relate retrieval candidates
to complete sources through the export and CJK cases. Compare prompts, retrieval,
tool execution and fine-tuning by the object each changes, costs and acceptance,
not by a technology maturity ladder. Selected current public documentation
supports technical relationships only; no model, API or training experiment is
authorized or inferred. Keep all earlier examples, comparison bodies, case
identities and reader predecessors while extending the explanatory argument.

### Put explanation on the actual reading route

The chapter07 route currently starts after three unnumbered conceptual sections,
so following the advertised route can skip the very theory needed for transfer.
Place the preserved explanation inside chapter07 and give its mechanisms a
consistent subordinate hierarchy. Preserve complete examples, comparison
bodies, figures and dated qualifications rather than shorten the theory to fit
a page. Connect capability growth to a changed work question, quality to fitness
for the accepted use, and efficiency to the whole path at that quality. These are
reasoned teaching distinctions, not measured department gains.

The current deadline is November10 at 00:00 in the user's Asia/Shanghai time
zone. Continue within the admitted publication owners; no remote publication,
operational changes or additional authority follows from the deadline. Source
organization, every-page composition, exact semantics and delivery remain
separate acceptance boundaries. A source-level link must lead to the specific
case, not merely another heading whose label exists.

### Reconcile inquiry and chapter hierarchy

Chapter08 must also teach work whose question has not yet formed: distinguish
candidate explanations, choose an observation that could discriminate them,
and let a responsible reader accept a changed goal. The retention example is
synthetic teaching, not a new causal finding or business outcome. This extends
the existing together-thinking mode without turning exploration into a fixed
execution checklist.

Repeated unnumbered level1 headings currently compete with actual chapter
entries in the outline and page header. Keep their complete titles, labels and
content, but place them at level2 with level3 subtopics. Numbered chapters get a
new-page opening; short notes stay intact. Preserve body size and rhythm, table
children, complete commands, figures and historical qualifications. Native
Typst block composition supplies these changes; no vendor edit or new renderer
is needed. Every final page remains subject to the existing task2.2 review.

### Compose the preserved material rather than shrink it

The complete 104-page composition self-review identifies detached note-only
continuations, a one-row repeated-header table tail and overly short last pages.
Keep body type, complete paragraph rhythm and publisher source unchanged. Tune
repeated heading furniture, table-cell inset and note margins in the existing
presentation owner; move the complete evidence-scope passage to the work-route
entry, where it belongs beside adoption guidance. Recheck the whole frozen
edition rather than certify these effects from source or a successful build.

Short field reminders now have an unframed, full-size paragraph role, distinct
from worked reports and caution callouts. Complete short workflow tables stay
together. Developed memo, Notebook, TeamAI, data-asset, interface and diagnostic
sections receive deliberate breaks so their argument occupies a readable page
rather than a detached tail. The official-link block uses reference spacing.
These are native composition choices; all protected examples and comparison
cells remain complete. The final complete visual pass still decides the result.

### Balance generated navigation

The final contents formerly flowed almost entirely down the left column, leaving
only three appendix entries on the right. Use two native outline selections
split at the code-search chapter in a two-column grid. This retains the same
generated entries, order and destinations, without reducing type or duplicating
page numbers. Re-freeze the PDF and inspect every page after this change.

### Deadline-bound whole-book refinement

Continue the existing case-led approach instead of adding a tool catalogue or another theory framework. The cold editorial review identifies practical role imbalance, insufficient positive memory reuse, repeated protective qualifications and a false no-new-dependencies exercise claim. Strengthen a synthetic product decision, demonstrate memory-guided reuse through the existing reconciliation contract, retain source roles and limits, and correct exercise prerequisites. The opening and horizon must connect judgment, action, acceptance and shared capability without promising measured gains. Recompose short continuations without shrinking body type or removing required examples. All successor content, navigation and final pages are requalified before exact reader promotion; previous editions remain preserved.

Keep the horizon's capacity calculation, deliverable redesign, adoption choice and learning transfer within the same twelve-topic case. The adoption exercise must weigh the unchanged handoff, material-only assistance and change-focused delivery against the actual bottleneck; it must not restart with an unrelated weekly brief. Consolidate repeated investment and second-use passages with the existing team-learning explanation while retaining distinct time scales, method ownership and members' rights. Reopen successor page, semantic and promotion qualification after changing this argument.

## Quant-data teaching correction

The audience is a quantitative hedge fund's data department. The recruitment
charter supplies internal responsibility and boundary context, not measured
achievement or permission to reproduce private organizational detail. Public
examples remain wholly synthetic. The connected case is a late revision that
contaminates a frozen research snapshot: distinguish event, publication and
ingestion time; filter eligibility before ranking revisions; preserve legitimate
zero and negative returns; report coverage and input quality separately from
snapshot differences. Do not sum security returns into a portfolio metric.
Code review, report writing and knowledge reuse continue this same case. Existing
CI and consumer-state cases retain dated scope and unresolved boundaries.
Predecessor sources and reader artifacts are preserved under
`build/evidence/publication-foundation/quant-department-20261109/`.

## Native source CI

Local proof and remote publication are separate from hosted verification. One
CUE definition owns the shared job and projects the two native pipeline files;
the native `ci-projections` task checks their agreement before formatting and
the existing synthetic exercise tests. The job checks out the event's exact
commit, uses read-only public-forge permissions, cancels superseded work and
has a 20-minute deadline. A checksum-bound official Mise binary installs only
the locked source-check tools into job-local state under ignored `build/`.
It does not install software on the authoring host or use credentials, live
services, business inputs, a PDF browser or fonts.

GitHub selects hosted macOS arm64; GitLab selects the owner-associated general
Linux x64 Runner and its Kubernetes executor. The native lock preserves every
macOS record and npm sidecar while adding Linux records at the same versions.
A digest-bound official Node image is selected for Linux. Its official Dockerfiles
declare the shell, Git and HTTPS bootstrap tools. The exact image was pulled and
its generated native journey passed under local Linux amd64 emulation, preserving
all source bytes and modes. Mise installs the selected repository tools into job-local state.
Runner registration, global settings and services are unchanged.
Native command steps avoid adding third-party action runtimes. Platform
execution remains unqualified until each peer's actual job passes.

The macOS CUE and exercise tools have bounded risk admission for trusted
repository configuration and synthetic fixtures. Linux CUE adds eight disclosed
Go advisory identifiers, and the Node image's SBOM scan timed out. Linux execution
has bounded owner acceptance for isolated configuration checks and synthetic
exercises; actual platform qualification remains a separate requirement. Scan limitations and
unresolved dependency advisories remain with the admission evidence; no
upstream constraints or security settings are changed. Source CI deliberately
does not replace full publication-input tests, the four ETHOS proof gates or
human editorial judgment. Pipeline files alone do not establish hosted success
or merge enforcement; those are separate platform effects.
