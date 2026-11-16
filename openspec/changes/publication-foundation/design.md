# Design

## Context

See `proposal.md`. The publication uses Typst 0.15.1 and unchanged Neat Book 0.1.0. Delivered editions and their original receipts remain outside this repository. Their presence is not current editorial or reader acceptance.

## Goals / Non-Goals

The source tree must let an editor change one argument, teaching case, figure or presentation rule without searching a monolith. It must let another person reproduce the publication without copying the author's private stores.

This Change does not create a publishing engine, a new governance framework or a broad software inventory. The author has authorized MIT licensing for the authored source; third-party terms remain independent. It does not assert independent aesthetic approval or measured teaching effectiveness.

## Decisions

### Separate meaning from presentation

`book/` owns the ordered manuscript and metadata; `book/back-matter.typ` owns reader-facing references and case qualifications. `publication/` owns document-level style and diagram rendering configuration. `diagrams/` owns the editable Mermaid inputs. `exercises/` owns synthetic fixtures and portable cards. `docs/` explains contributor procedures only. Generated images, PDFs, previews and diagnostics belong under ignored `build/`.

The manuscript is divided into front matter, one module per chapter under `book/parts/`, and back matter. A module holds one chapter's judgment, so an editor changes one argument without searching the rest; the reading order lives in `book/manuscript.typ` alone.

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
- A rebuilt manuscript has no page, semantic or reader qualification of its own. Structural completion does not satisfy editorial acceptance.
- Automated compilation and input checks cannot judge teaching effectiveness or taste. Inspect every changed page and retain explicit reader-review limits.

## Migration Plan

Preserve selected originals, admit exact destination paths, split the manuscript while checking native raw/table/figure parity, build through the declared tasks, and verify metadata and page extraction. Then rebuild the manuscript for the quant-data reader and inspect the complete new edition. Promote only a qualified artifact; keep the prior consumer output unchanged until that point. Local source commits, ETHOS landing and public release remain separate effects.

### Reader-led paragraph rhythm

Use flush-left body paragraphs and one complete blank body line, as requested by the reader. The presentation owner defines a 10.5 pt body size, 16 pt baseline and 32 pt paragraph transition; headings, notes, tables and code retain distinct, fixed roles on a 4 pt spacing module. Remove chapter-specific body leading overrides. Larger spacing must not be paid for with smaller type or lost prose: rebalance short spill-only continuations through native page and heading composition, and inspect every final page. This is an authored layout revision, not independent reader approval.

### Rebuild the manuscript as the leader's teaching account

The owner rejected three successive shapes on 2026-11-14. The 37-chapter edition was organized by the author's tool estate. A first rebuild followed a data work chain and so mistook the setting for the subject. A second restated the owner's phrases as its skeleton without reasoning of its own. The book is about work and team collaboration in the agentic era; one of its main purposes is to coach the team in how to think, act and collaborate; and it must cover principle, method, practice and tooling. The data department is where the book stands and where its cases come from.

The argument starts from one observation: producing a result now outruns understanding it. Understanding used to be a by-product of doing the work; an Agent can now produce the result without anyone having understood it. Unreliable output, review overload and juniors who cannot be coached follow from that.

Four conditions of work cannot be avoided: reality is not ours to set, results are for someone else, the answer is unknown beforehand, and attention is finite. Each gives one principle: fidelity to fact, making the implicit explicit, closing the loop, and spending attention where it matters. The principles are derived, not listed, so that a reader can tell a principle from a present habit and know when one may be relaxed. Accountability resting with people is stated with its reason, the Agent's present inability to bear consequences, not as an axiom.

The four traditional layers are read as rates of change: principle changes over decades, method over years, practice over a year or two, tooling over months. A higher layer judges a lower one; a lower one can be replaced without disturbing the higher. The layers are a reading aid, not the table of contents: a reader works by task, and a part that mixes why, how and practice for one activity keeps what is used together in one place.

| Part               | Modules                                                                                             | Reader question                                                                                                             |
| ------------------ | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Root               | `work`, `change`, `invariants`                                                                      | What is work, what did the technology change, what holds?                                                                   |
| One person         | `question`, `knowing`, `model`, `bounds`, `choice`, `practice-thinking`                             | How does one person come to understand?                                                                                     |
| The Agent          | `agent`, `first`, `context`, `tools`, `boundaries`, `memory`, `practice-agent`                      | What is the Agent that takes the work, layer by layer, and how is each layer operated?                                      |
| After handing over | `delegate`, `verify`, `walkthrough`, `run`, `diagnose`, `orchestrate`, `evaluate`, `practice-doing` | How does understanding survive delegation: handing out, taking back, finishing, several Agents, measuring a changed method? |
| Several people     | `team`, `roles`, `writing`, `review`, `standing`, `improve`, `leading`, `practice-collaborating`    | Why a team exists, and how several people and Agents understand together                                                    |
| The person         | `growth`, `closing`                                                                                 | What does a person grow by, and what stays with the person?                                                                 |

A role is objective: the work itself determines which judgments must be owned. Its carrier varies: a person, an Agent or a team may carry a role's work, and interchangeability is produced by putting intent, facts and evidence where a successor can read them. Accountability rests with the person who calls the Agent. This follows the Work Guidelines at signed tag v8.0.0.

The manuscript takes positions of its own and says where it differs from received formulations. Ranking system above process above management orders where a remedy should end; discovery runs the other way, and premature systems fix misunderstanding in place. A team of capable individuals with Agents drifts toward soloists, so a team's reason to exist shifts from sharing labour to mutual correction, shared standards and accumulation. Bounding a conclusion is for making it usable; piling on qualifications abdicates the judgment. A chapter states the conditions a method needs where those conditions carry substance; it does not append modest disclaimers. The ideas and practices in the book are the author's own, accumulated from leading the team and doing the work; the department's guidelines, charter and role design were written by the author or formed on the author's thinking, and the back matter says so plainly. The back matter carries no list of doubts.

The narrator is the department leader and writes as "we". Each chapter opens with a situation from real work, explains the principle, shows it in a case, states what the team does because of it, and names the limit. The owner's own works inform the thinking but are weighed, not restated. Team repositories, reports and meeting notes are raw material and evidence of the present state; a present practice is measured against the intended end state, including the team's own mistakes. Chinese terms follow the wording approved for the Guidelines' film, including 智能体 for Agent.

The owner's fourth correction on 2026-11-14 was about voice: keep the effect, drop the sermon. The structure stayed; the prose changed. A chapter's lead line is the plain question or situation it answers, not its conclusion. The text describes what the team does and why, in the first person, instead of issuing commands; a point is stated once in everyday words after the case has made it visible; coined labels, counted frameworks used for show, maxims and closing one-liners are removed. Part names are plain (道理、方法、练习、工具、改变), and the traditional four-layer wording appears once, in chapter 03. Method cards in the practice chapters stay terse because they are reference material.

The owner's fifth correction, on reading the 77-page candidate, was that the rebuild had removed almost all teaching of Agent technique, which the earlier handbook carried. The rebuild had filed that material under tooling and argued that the fastest-changing layer should be shortest. That conflated product brands with how an Agent works and is operated. The second changes far more slowly than the first and is what a team uses every day, so it gets its own part after method: the loop of model, host and tools; context and retrieval; the four ways a capability is attached; permissions, credentials and irreversible effects; long tasks, checkpoints and handoff; several Agents; diagnosis by layer; and evaluation, including when prompt, retrieval, tools or training is the thing to change. A fourth practice chapter uses the two companion cases the method chapters did not need. Product names stay out of this part; the tooling part remains short.

Adding the Agent part as a third block between method and practice exposed a structural fault: a reader had to cross three parts to learn one activity, delegation was taught five chapters before the chapter that explains what an Agent is, and the split between method and Agent operation was the author's taxonomy, not the reader's task. The book is therefore ordered by the three activities on its cover. Thinking keeps its five method chapters and gains its practice. Doing opens with four chapters on the Agent (loop, context, tools, boundaries), continues with handing out, taking back, long tasks, diagnosis and what to keep, walks one task end to end and ends with two practice chapters. Collaborating adds several Agents and the shared environment to roles, writing and review. Change holds the person, the team, measuring whether a changed method is better, choosing and replacing tools, and how to change.

After the committee review and the owner's reading of the 120-page candidate, the book was rebuilt around one line. The definition of work (turning uncertainty into a result others can rely on) yields the four conditions word by word, and two working criteria follow from them: reversibility and lossy restatement. The same question, how understanding is reached, is then asked at three scales: one person; after the work is handed to an Agent; several people. Part four opens with why a team still exists; the last part returns to the person and to leading. Thirty-two chapters became twenty-four; practice closes each scale without taking a chapter number; duplicated cases were removed. The owner also corrected the organizing principle of the Agent material: coverage follows the full picture of agentic AI (model, harness, context, tools, boundaries, memory, orchestration, evaluation), and a tool is explained by the layer it sits in and the problem it solves whether or not it was operated while drafting. Reasoned explanation and recorded event are kept distinct; neither is decorated with claims of verification, and versions appear once, in the tool map. A second independent review then ruled on the ending line by line: statements written for the author about his life and motives were removed, the epilogue's closing was rebuilt from the body's own argument (what is handed over, and what stays with the person who did the work), and the afterword states the book's method, reduce then derive, and closes on the author's own phrase without commentary. The picture of agentic AI gained unattended and scheduled work, what a request costs, sandboxes, the conditions under which injected instructions do harm, structured output, computer use, model dispatch within a task, agent-to-agent protocols, and evaluation of results, trajectory and cost.

A third independent review of the 117-page candidate (fact audit, a reader following every command, an editor) found the argument rooted but not derived, the proportions inverted, and case details and commands that the records and the machine did not support. The sixth draft answers all three. Chapter 03 now reads the definition as five components: the technology changed only "turning into"; the other four each give a condition, and the fourth, "can be relied on", carries the argument: someone must answer for the result, answering requires having understood, and one person can understand only so much. Responsibility rests on the consequence having nowhere to land on an Agent and on the organization not having authorized it, not on the Agent lacking memory; understanding therefore stays with people, attention becomes the binding constraint, and producing separates from understanding. Three criteria follow: reversibility, lossy restatement, and being able to check what one answers for. The model is reduced to one sentence, it continues the text with the most plausible next words, from which five properties of an Agent are derived; later chapters name the property or condition they apply. The former third part is split: "the Agent" explains every layer once, with memory and evaluation moved in from the team part and a hands-on section at each chapter's end, run in a scratch repository the reader builds in a new first-session chapter; "after handing over" keeps delegation, verification, long tasks, diagnosis and the walk-through. Leading moves into the team part so that the body ends on the person. Every case was restated from the original record: the two reports in the preface, the vendor comparison, the source selection, the duty bot, the nightly script, the comparison gate, the review timeline, the machine-generated minutes, the handover document, the incident remedies and the two sessions, whose real conditions (inherited standing rules, an added working-directory sentence, leftover files) are now stated. The author's own formulations from the charter, the Work Guidelines and the annual summaries are quoted where the earlier drafts had paraphrased them. Twenty-four chapters became twenty-nine and three practice modules became four.

A reader who followed every command and an editor who read for derivation then reviewed the sixth draft (141 pages), with a line editor. Their findings set the seventh draft. Structure: `orchestrate` and `evaluate` used delegation before it was taught, so they moved to the end of the handing-over part and `walkthrough` moved up to follow `delegate` and `verify`; the Agent part is now the anatomy of one Agent and the handing-over part is its use. Derivation: chapter 03 states that the doer is now also "someone else", that reliance rests on a person who understood or on a check built by one, that the three classes of conclusion someone must understand belong at the root, and that finite attention is an empirical premise; chapter 09 derives six properties from two sentences and names the two added facts; sentences that only labelled a chapter with a condition were replaced by the step itself or removed. Commands: printed shell blocks carry no trailing comments and no line-number gutter, because a bare interactive zsh treats `#` as a command and a PDF copy carried the numbers; short inline commands do not break across lines; the scheduled-run skeleton creates its output directory, allows only read-only queries and records a run with no output, and the chapter gains a model-free exercise that shows a zero exit code beside an empty result. Evidence: the two briefs of the walkthrough were each run three times with the same outcome, under the author's global rules, which the chapter discloses; no rule-free control was run. The companion pack gains two Chinese templates written in the book's own terms, and a fifth exercise for chapter 07.

The owner then ruled that his personal motto must not appear in the book, asked that the remaining open points be settled by strict derivation, and corrected how decisions had been put to him: a request must carry its cause, facts, options with consequences and a recommendation. The eighth draft follows. The afterword no longer rests on the motto; it applies chapter 26 to the book itself and leaves five lines of reason, the last of which (when to revisit) points to a table (first placed in chapter 03, moved to appendix D in the tenth draft) that binds each conclusion to its premise and to the condition under which it must be rewritten. First-person judgments without a record were replaced by the derivation or by the owner's documented rule (headcount does not remove a position; letting go is a delegation under chapter 15's three conditions). Three gaps named by the editor were derived from the root and written: what the limit of verification measures once verification itself is delegated (reach can be amplified, the rate of understanding a new kind of error cannot); what must stand in for a person before a step runs unattended; and the five stages by which an Agent practice enters department process, restated from the operating model without naming seats. Chapter 21 opens with the book's own three audit rounds, whose counts cannot be compared, in place of a supposed case. Chapter 24 gains a section on asking for a decision, built on the Work Guidelines' order for a decision document and on the exchange that prompted it.

A referee then read the eighth draft for logic alone: the derivations written out step by step, every chapter sorted into derived, locally premised or asserted, contradictions, counterexamples and consequences the root implies but the text omits. The ninth draft repairs the root accordingly. Chapter 03 no longer claims to derive the four conditions from the definition alone: each condition is one component of the definition plus one stated fact (truth is not ours to set; meaning degrades with each handover; doing can err and the error may be invisible; one person can understand only so much). Authority and responsibility are separated: an organization can bound what an automated system may do without it bearing anything, and who decides bears is stated as the team's convention, not as a deduction. Understanding must precede only for four classes that cannot wait for hindsight (irreversible, built upon by others, silent when wrong, met for the first time); otherwise diagnosis after the fact is legitimate, which chapter 19 had shown all along. Chapter 09 says five properties are derived and one is an observed tendency, and that the properties belong to the model while host and rules can alter how some of them show. The team thesis no longer leans on that tendency: an agent a person controls cannot fully correct him because he decides what it is asked and whether its answer is accepted, and one person cannot understand everything that must be understood. The limit after delegated verification is stated as what remains for people, not as a replacement of one limit by another. Thirty cross-chapter inconsistencies and a set of absolutes were corrected; nine consequences of the root were added in a sentence or two each (silent errors as a fourth class, orphaned checks degrade to leads, a ruler's own variance, a floor on headcount from finite understanding, a second reader per position, consequences must land on people too, a model change resets what checks know, downstream status cannot exceed upstream, a decision request carries what was verified).

A first-time reader then read the ninth draft once, as a data engineer two years into the job. Chapters 01 and 02 and the epilogue could be followed; chapter 03 could not: it presented the proof and the teaching at the same level, counted things the reader could not hold (fifty-four numbered names against seven in chapter 01), and stated the four classes without an example. The tenth draft changes the presentation and no step of the argument. Chapter 03 now follows its own opening question: why producing and understanding came apart (the two speeds and the four visible troubles), then what does not change (the definition read word by word, each condition introduced by a sentence from the opening case, then the fact it adds, then its name), then responsibility, the four classes as a list with an example each, where attention goes, and the three criteria each with a case from elsewhere in the book. The table of premises moved to appendix D, where every row is known to the reader; chapter 03 keeps the rule and one example. Chapter 09 opens with the two-sentence summary, numbers its six properties and says afterwards which are derived. Terms used before their explanation were glossed or replaced, repeated passages were cut to one occurrence, and back-references of the form "chapter N derived" became "chapter N said".

The same kind of reader then read parts two, four, five and six once, and judged twelve lists that the book takes from department documents against the root. The places where a reader stopped were almost all lists: four to nine items in one sentence, without an example or an origin. The eleventh draft therefore says, at each list, where it comes from. Where the list follows from the root it gives the two or three steps (the three questions on worth, the decision owner, the five items of a brief, the three distances, the five lines of reason, ranking system above process above management together with its condition that someone keeps the system, the five questions for a metric, the four stages of replacement, the three signs of growth). Where only part follows it says which part is the department's convention or experience (six kinds of statement, nine states, the roles and who decides, five situations in which to stop, the layers of a disagreement, four things that build density, three levels of expertise, the order of tracing an error). Claims that exceeded this were withdrawn, among them that roles are objective, that every layer of a disagreement has its own remedy, and that the earlier layers of error tracing are cheaper to check. The run conditions of the walkthrough moved after the two sessions, with one sentence of disclosure kept in front. One description that could identify a vendor was generalized.

A further review did three things: it re-read the last corrections of the eleventh draft, read part three once as the same first-time reader, and listed every place where the book repeats itself or only announces. The twelfth draft acts on all three. Ten of the last corrections were adjusted, two of them for content (a third-party comparison whose scope had been overstated; a pointer that named the wrong direction). In part three, sentences that interrupted a step with an unexplained aside were reordered, options and commands the reader does not use in the chapter moved to the quick reference together with their conditions, and three statements were tightened to what the root allows ("mostly" restored where chapter 09 says so). Repetitions were cut to one occurrence: the outcome of the walkthrough stated six times, the two reports of the preface restated with their figures, the reason responsibility stays with people restated in four places, the map of the book given five times, and a dozen smaller ones. Disclosures of limits and every conditional sentence were kept. Tool passages the owner asked for were not cut; where a tool is the author's own, the chapter now says what a reader without it does instead.

The thirteenth draft follows three reviews of a different kind: the first whole-book fact audit since the sixth draft, a reader who pasted every command into a bare shell, and an editor who read the book once from cover to cover. The audit found twenty-two groups of sentences that said more than the record, four of them written from corrections earlier reviews had proposed; each was rewritten from the record line itself, and one sentence without any record was replaced by what the tool's own help states. Command blocks became single chains that stop at the first failure, the unattended skeleton creates its output directory and reports an empty result, and the practice pack discloses its repeated runs. The editor's verdict set the direction: the argument holds, but six rounds of repair had left an annotator's voice beside the author's. The draft therefore removes labels and keeps reasons. A derivation stays in the sentence where it does its work; the status of a derivation (derived, convention, experience) is stated once, in the table of premises in appendix D, and no longer beside each list. Chapters cited as authority lost the citation where the sentence stands without it. The missing control run is disclosed once, where the conclusion is drawn, instead of four times. Passages about the making of the book stay where a reader can see or repeat the case; run conditions moved to appendix D, and draft numbers and reviewers' verdicts on the book left the text. Two condition names used once and never again were dropped. Not done, because each needs facts or runs that only the owner can supply: a control run without the rule, hands-on steps for a hook and a skill, a section on configuration shared by the team, and one real cost account.

The owner then authorized a bounded number of real model sessions, and the fourteenth draft replaces three disclosures with results. Seventeen headless sessions were run under a spending cap, each in a scratch directory without the author's rules, settings, hooks, plugins or servers. Chapter 17 gains the control group that it had only disclosed as missing: the one-sentence brief three times without a rule file and three times with a one-line rule to ask first. Without the rule every run opened with a verdict, chose conventions itself and asked at the end; with it every run withheld the verdict and asked first; all six reported the one fault that depends on no convention. The chapter states the size of this evidence (three runs each, one model, one task) and does not compare it with the earlier sub-agent sessions. The five-item brief was run once on the strongest and once on the lightest model of one family: the values agree, the reported cost differs by a factor of about thirty, and the lighter run left a query that had never been executed and a sentence nothing had checked; the text says that a denied first command shaped that run, so the difference is not the model alone. Chapter 12 gains two hands-on items, a hook and a skill, each printed as it was run; a test ties the hook settings and the skill to the practice-pack files and runs the printed hook script on the fixed and the old export. The script is created by the reader from the chapter and is not a tracked file: the repository's locked toolchain has no analyzer for shell sources. A first round of six runs was void because an aliased `ls` printed nothing and returned success; no session doubted the empty listing, and the chapter keeps that as a warning to the reader. Chapters 9, 11, 15 and 21 now point at these results instead of at their absence; the run conditions are in appendix D and the unchanged answers are in the practice pack.

The repository is public. The book names no internal organization scheme, seat count, person, vendor, internal system or performance figure. Cases are restated from real work with names withheld; counts and dates follow the original record, and the back matter says so.

Six figures carry relationships the prose cannot show as well: the chain from problem to feedback, the three collaboration distances, the work loop, what one request to the model contains, recall checked against current state, and the snapshot reconciliation used by the first practice exercise. The manuscript-specific publication tests bind the chapter navigation, the layer openings, the exercise cases named by the practice chapters and the back-matter sections.

Alternatives considered: keeping the data-chain handbook with a framing chapter would leave craft as the spine. Organizing by the department's present process steps would present what exists as what should be. Building the skeleton from the owner's phrases would restate guidance instead of reasoning from it.

The rebuild invalidates every page, semantic and delivery qualification of earlier editions for the successor. The 114-page edition remains the delivered edition until the rebuilt one is qualified. The owner's reading decides whether the account is sound.

## Native source CI

Local proof and remote publication are separate from hosted verification. One
CUE definition owns the shared job and projects the two native pipeline files;
the native `ci-projections` task checks their agreement before formatting and
the existing synthetic exercise tests. The job checks out the event's exact
commit, uses read-only public-forge permissions, cancels superseded work and
has a 20-minute deadline. It installs only the locked source-check tools and
does not install software on the authoring host or use credentials, live
services, business inputs, a PDF browser or fonts.

GitHub selects hosted macOS arm64, where a checksum-bound official Mise binary
keeps all tool state in the job under ignored `build/`. GitLab selects the
owner's local macOS arm64 runners, the arrangement the owner's other
repositories use: a protected shell runner for the protected `dev` and `main`
branches and `v*` tags, and a review runner for merge requests and `proposal/`
branches, each locked to this project under its own account in the CI guest.
Both peers therefore run the same commands from the same macOS lock records. On
GitLab the runner supplies Mise as a prerequisite; the job records its version,
and the runner account's Mise store keeps the locked tools, so a later job
needs no download. The job keeps that account's own Mise settings and parent
directories out of resolution.

The private peer first ran on a department Kubernetes runner, with a
digest-bound Node image and Linux x64 lock records; the records remain in the
lock without a consumer. That runner's evening path to public hosts was too
slow for the tool downloads, and jobs ended before any check. Alternatives
measured on it on 2026-11-16 and withdrawn: a native job cache, which the
runner saved and never restored; a public GitHub proxy, which was slower and
dropped connections. A longer deadline was not tried, because one archive alone
would have needed over an hour.

Each Forge step invokes one native command; a checksum manifest binds the hosted peer's bootstrap archive. The existing Just owner checks the actual platform and exact event commit before source verification. Native command steps avoid adding third-party action runtimes. Platform
execution remains unqualified until each peer's actual job passes.

The macOS CUE and exercise tools have bounded risk admission for trusted
repository configuration and synthetic fixtures. The earlier Linux job had its
own bounded owner acceptance, with eight further disclosed Go advisory
identifiers in CUE and a Node image whose SBOM scan timed out; it has no
current use. Scan limitations and
unresolved dependency advisories remain with the admission evidence; no
upstream constraints or security settings are changed. Source CI deliberately
does not replace full publication-input tests, the four ETHOS proof gates or
human editorial judgment. Pipeline files alone do not establish hosted success
or merge enforcement; those are separate platform effects.

### Hosted publication extension

Extend the existing public macOS job after its source checks rather than add a
second pipeline or installation controller. The same locked Mise environment
supplies Typst and Mermaid. Native download, checksum, archive and Just commands
provision complete official publisher packages and Noto fonts in job-local
state; Typst's supported paths bound discovery. The Runner's Apple fonts stay
within licensed macOS, and its existing Chrome exercises the unchanged
Puppeteer configuration with the sandbox enabled. GitLab retains source checks
because the edition currently depends on Apple font supply.

The existing Just owner builds the candidate and packages the selected tracked
teaching inputs as `.tgz`. A separate Chinese entrypoint serves readers without
changing source fixture bytes. Archive extraction tests run the actual native
recipe, compare complete file bytes and modes, exclude untracked inputs and
run all synthetic exercises. Exact staging is removed on success or failure.

Compilation and hashes alone do not prove artifact retrieval, independent
reading, navigation or editorial value. Those remain acceptance at their
existing owners. The job never replaces Documents output, supplies standalone
Apple fonts, installs Poppler, changes project locks or starts services.
The owner accepted official `actions/upload-artifact` 7.0.2 at the exact
`cf430e030ddbb5b0abf93d22962f4752f3646cd9` commit for this isolated CI. Two
separate steps upload the exact PDF and `.tgz` paths with `archive: false`,
missing-file failure and 14-day retention. Repository permissions remain
`contents: read`; no wildcard, business input, new credential or vendor
dependency edit is introduced. The 36 disclosed source-lock advisory identifiers
remain in the admission evidence; inclusion and exploitability in the released
Action bundle are unproved. Approval permits the bounded execution, not a claim
of dependency safety or successful artifact retrieval.
