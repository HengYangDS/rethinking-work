# publication-source Specification

## Purpose

Provide a complete and attributable source publication that editors can navigate, readers can learn from, and contributors can rebuild without inheriting private workstation state.

## Requirements

### Requirement: Cohesive publication inputs

The publication SHALL maintain one editable owner for manuscript meaning, edition identity, presentation, diagram sources, synthetic exercises and reader references. Reproducible generated output SHALL stay outside tracked source.

#### Scenario: Editor follows a figure

- **WHEN** an editor selects a figure in the manuscript
- **THEN** its editable source and rendering configuration are discoverable and its rendered image is generated under the declared build output.

### Requirement: Portable and attributable edition

The publication SHALL identify its title, author 衡阳, version, date and language in visible front matter, and its title, author, date and language in PDF metadata. The version SHALL be the one in `VERSION`. Portable inputs MUST NOT depend on private stores or host-specific receipt paths.

#### Scenario: Reader opens the PDF

- **WHEN** the PDF is rebuilt through the declared entrypoint
- **THEN** its author and editorial date agree with the visible attribution, its cover shows the version in `VERSION`, and its references distinguish cases, recommendations and synthetic exercises.

### Requirement: Meaning-preserving migration

The migration SHALL preserve complete examples, source facts, qualifications and historical recovery obligations. Changed prose SHALL be reviewed as authored revision rather than described as an exact copy. A later authored rebuild MAY replace migrated prose and examples; it SHALL keep the date, source role and limit of every case it retains, and earlier editions SHALL remain recoverable from source history and their delivered artifacts.

#### Scenario: Modular source replaces the candidate

- **WHEN** the candidate is divided into semantic modules
- **THEN** unchanged raw examples, tables and figures retain complete native content, and selected originals remain recoverable through their evidence owner.

#### Scenario: A rebuild replaces the migrated manuscript

- **WHEN** the owner authorizes a rebuilt manuscript
- **THEN** the retired modules are removed from the reading order and the tracked tree, the delivered predecessor is not represented as the rebuilt edition, and each retained case states its date, source role and limit once.

### Requirement: Truthful publication acceptance

A compiled document SHALL NOT be represented as reader-approved or published solely because its build passed. Delivery SHALL verify complete content, navigation, metadata and every final page within its stated review scope.

#### Scenario: Build succeeds before editorial review

- **WHEN** the native build succeeds but editorial revision or visual inspection remains unfinished
- **THEN** the artifact remains a candidate and the existing reader output is not silently replaced.

### Requirement: An account of work in the agentic era

The manuscript SHALL present an account of work and team collaboration in the agentic era, set in the business context of a quantitative data team, that teaches a team how to think, act and collaborate. It SHALL cover principle, method, how an Agent works and is operated, practice and tooling, and pair each principle with a worked scenario from data work. Each agent layer SHALL be taught through a named tool the team uses for it, with runnable commands and their expected output.

#### Scenario: Reader works through a principle

- **WHEN** a chapter states a principle
- **THEN** it explains why the principle holds, shows it in a worked scenario, states what the team does because of it, and states the conditions the method needs where they carry substance.

#### Scenario: Reader learns to operate an Agent

- **WHEN** a reader finishes the Agent part
- **THEN** they can explain the layers of an agentic system (model, harness, context, tools, boundaries, memory, orchestration, evaluation), place a named tool in its layer, and have run a first session of their own and read its record; after the part on handing over they can hand out, take back, checkpoint, diagnose and close a piece of work.

#### Scenario: Reader operates a layer's tool

- **WHEN** a chapter teaches a layer that the team serves with a named tool
- **THEN** it states what the tool is for, gives the commands for a first use, shows what the output looks like, says how to tell that it worked and how it fails, and the back matter states the version the commands were run on.

#### Scenario: Reader shares a team's configuration

- **WHEN** a reader finishes the part on several people
- **THEN** they can say where the team's skills, rules and instruction files live, how a change to them is reviewed, how they reach each member's hosts, and how to tell that a member's host has the current version.

#### Scenario: A worked example can be recomputed

- **WHEN** a chapter derives a result from a worked synthetic example that the companion exercises cover
- **THEN** the chapter names the exercise case, and running that case reproduces the stated result.

#### Scenario: Attractive output fails the intended purpose

- **WHEN** formatting or technical checks pass but the reader rejects the argument or teaching value
- **THEN** editorial acceptance remains open, the previous checks retain only their demonstrated scope, and revision changes the material selection or reasoning rather than merely adding length or tool names.

#### Scenario: Source meaning changes after a delivered edition

- **WHEN** the next candidate changes the manuscript after reader delivery
- **THEN** complete-content, navigation and every-page checks qualify that new candidate before promotion, while the prior edition and its dated delivery receipts remain preserved.

### Requirement: Invariants before tools and current practice

The manuscript SHALL be organized by how fast each layer changes, from principle to tooling, not by tools, products or present process steps. Tool material SHALL be placed in the layer it serves and SHALL be retained where it teaches practice. A present practice used as material SHALL be weighed against the end state the manuscript argues for.

#### Scenario: Material describes only a tool or a procedure

- **WHEN** a topic bears on no principle, method, practice or deliberate change
- **THEN** it is left out of the manuscript.

#### Scenario: A tool's details teach practice

- **WHEN** a passage teaches how to operate a layer and a review proposes cutting its tool name, command, configuration or output as weakly related
- **THEN** the detail stays, because it is the substance of the practice.

#### Scenario: A present practice falls short

- **WHEN** the manuscript uses a present practice as material
- **THEN** it says where that practice falls short of the end state.

### Requirement: Positions reasoned from conditions

The manuscript SHALL reason from stated conditions to its principles rather than restate guidance, SHALL present them as the book's own positions without asserting who devised or carried them out, and SHALL NOT pad its claims with modest disclaimers.

#### Scenario: A principle rests on a present condition

- **WHEN** a principle holds only because of a present condition
- **THEN** the manuscript states that condition as a fact where the principle is taught, and the back matter carries no list of doubts.

### Requirement: Public source without internal disclosure

The tracked publication source SHALL NOT disclose an internal organization scheme, person, vendor, internal system or performance figure. Examples SHALL be scenarios set in the stated business context, and the source SHALL NOT present them as accounts of real events.

#### Scenario: A scenario is adapted from an internal incident

- **WHEN** a chapter adapts an internal incident into a scenario
- **THEN** the scenario keeps only the elements its point needs, carries no name or detail that identifies a vendor, a person or an internal system, keeps its numbers internally consistent, and neither the chapter nor the back matter says that it happened or who took part.

### Requirement: Objective register

Chinese prose SHALL narrate in the third person and an even tone, stating facts and reasoning from them. It SHALL NOT narrate in the first person, stress who did or wrote something, or assert that an example really happened. Hands-on instructions MAY address the reader.

#### Scenario: A passage carries a detail

- **WHEN** a detail does not serve the point of its passage
- **THEN** the passage leaves it out, even when the detail is true.

### Requirement: Meaning-led Chinese editorial review

Chinese prose SHALL use accurate concepts and idiomatic paragraph structure. Editorial revision SHALL preserve the source's objects, actors, relationships, numbers, dates, negation, conditions, attribution and uncertainty. Practical instructions SHALL identify the actor, prerequisites, action and observable result. A reviewer score, agreement or word substitution SHALL NOT establish this acceptance.

#### Scenario: One source term has different meanings

- **WHEN** a source term refers to credentials in one passage and sensitive information or non-sensitive metadata in another
- **THEN** each passage expresses its own intended meaning in natural Chinese, and whole-paragraph source comparison and cold reading qualify the revision rather than a global replacement.

### Requirement: Direct prose with limits stated once

Chinese prose SHALL state what a thing is and does. A scope limit SHALL appear once where it applies, at the case or in the back matter, rather than after each passage.

#### Scenario: A case has a limited scope

- **WHEN** a demonstration or worked result holds only under stated conditions
- **THEN** those conditions appear once, where the result is used or in the back matter, and the chapter does not repeat them after each paragraph that uses the result.

### Requirement: Plain prose that leads the reader

Chinese prose SHALL reach its point through a concrete situation and standard written Chinese: every word in its dictionary sense, idiomatic collocations, and punctuation by GB/T 15834. It SHALL describe what the team does and why rather than instruct the reader, and SHALL NOT use coined labels, maxims or enumerations whose only purpose is to sound systematic.

#### Scenario: An idiom says it more exactly

- **WHEN** an established idiom, set phrase or allusion says a thing more exactly or more briefly than plain words
- **THEN** the prose uses it in its dictionary sense, and never as decoration or as a slogan.

#### Scenario: A chapter introduces a principle

- **WHEN** a chapter states a principle or method
- **THEN** a scenario precedes it, the statement appears once in everyday language with its reason, and the chapter's lead line poses the question the chapter answers.

### Requirement: Reproducible source verification

Both publication peers SHALL run the installed verification model of the owner's
repository family, generated from the repository's declarations. The job SHALL
verify the exact event commit by the repository's full proof with locked tools,
including formatting and all synthetic companion contracts, without business
data, services or credentials. Generated pipeline files SHALL match their
declarations. Hosted execution, full PDF qualification and editorial acceptance
SHALL remain distinct claims.

#### Scenario: A source change reaches the public peer

- **WHEN** a push or pull request triggers source CI
- **THEN** the job runs the full proof against that event's exact commit, and any failing gate, formatting defect or failing exercise makes the job fail.

#### Scenario: A pipeline declaration changes without its generated files

- **WHEN** a verification parameter, runner prerequisite or repository job changes and the native pipeline files are not regenerated
- **THEN** the projection check refuses the drift and names each file that differs.

#### Scenario: A peer lacks a suitable Runner

- **WHEN** the private peer has no authorized Runner for the locked platform
- **THEN** its job remains visibly pending, is not represented as passed, and does not prevent independent public-peer verification.

### Requirement: Versioned release

A version SHALL be released as a signed `v` tag on `main` that matches `VERSION`,
published to both peers through native ETHOS publication. Each peer SHALL carry
a release for that tag whose assets are the edition archive built from the tag
and a SHA-256 list of it. A release SHALL NOT by itself establish editorial
acceptance.

#### Scenario: A qualified edition is released

- **WHEN** the owner approves a qualified edition for release
- **THEN** the changelog's entries move under that version and date, the signed tag reaches both peers, both peers' tag pipelines build the archive independently, and each peer's release carries the archive whose downloaded bytes match the SHA-256 list.

### Requirement: Independent publication build

Each publication peer SHALL build, in a macOS job of its own, the edition archive from the exact event commit and complete declared publication inputs, and keep it as a job artifact for 14 days.
It SHALL preserve project locks and exclude credentials, business data and
standalone restricted fonts from its outputs. A hosted success SHALL NOT
establish reader delivery or editorial approval.

#### Scenario: A clean macOS Runner builds the publication

- **WHEN** the exact event source, locked tools, declared fonts and complete official publisher packages are available
- **THEN** the native build regenerates the figures, produces the PDF and the edition archive, records input and artifact identities, and fails on missing or changed required inputs or project-lock drift.

#### Scenario: The practice archive is read outside the source checkout

- **WHEN** a reader safely extracts the archive in an environment with the declared exercise tools
- **THEN** the selected tracked teaching files keep their complete bytes, both reader notes state the version in `VERSION`, every file matches the archive's SHA-256 list, the exercises' own checks run and pass, and no installation, business-data access or service startup is performed.

### Requirement: Behaviour claims grounded in runs

A statement about what a tool, a host or an Agent does SHALL rest on a run recorded on the stated version, on a primary source, or on reasoning presented as reasoning. A claim about an Agent's tendency SHALL state the conditions and the number of runs where the result is used, once.

#### Scenario: A tendency is stated

- **WHEN** a chapter states that an Agent tends to do something
- **THEN** a recorded experiment with stated model, host, conditions and number of runs supports it, or the chapter derives it from how the model works and says so, or the statement is removed.

#### Scenario: A tool changes after the edition

- **WHEN** a later version of a named tool changes a command or an output printed in the manuscript
- **THEN** the back matter's version for that tool identifies which version the printed command and output belong to, and the next edition reruns the experiment before reprinting them.

### Requirement: One versioned edition archive

An edition SHALL be delivered as one archive holding one folder with a reader note, the PDF named with its version, the exercises with their own reader note, and a SHA-256 list of every other file in the folder. Both reader notes SHALL state the version in `VERSION` and SHALL be generated from it, not written by hand.

#### Scenario: A reader unpacks a downloaded edition

- **WHEN** a reader unpacks the archive on macOS or Windows
- **THEN** the folder's names read correctly, the PDF's name and cover and both reader notes state the same version as the tag, and every file matches the folder's SHA-256 list.

### Requirement: Bounded verification time

The publication checks SHALL lay out the book a fixed number of times per run, however many checks read it. Each document check SHALL spend less CPU time than half of one layout of the book measured in the same run, and a check that does not SHALL fail the run. Each test gate of the proof SHALL carry an absolute timeout taken from measured local and hosted durations, with that reason stated beside it.

#### Scenario: A check lays out the book again

- **WHEN** a check evaluates the book itself instead of reading the facts the run has already read
- **THEN** the check spends nearly one layout's CPU time, more than its budget of half a layout, and fails the run, however loaded or fast the host is.

#### Scenario: A test gate hangs

- **WHEN** a test gate runs past its declared timeout
- **THEN** the proof stops the gate and fails, and the timeout's stated reason names the measurements it came from.

### Requirement: Declared supply release age

The repository SHALL declare, in each resolver's own configuration, the minimum age a tool or package release must have before it enters the locked supply, and SHALL admit a newer version only when it is at least that old. The age SHALL NOT be restated as a number in a test or script.

#### Scenario: A locked tool is moved

- **WHEN** a locked tool or Python package is moved to a newer version
- **THEN** the resolver refuses a release younger than the declared age, the lock and the pipeline declarations with their generated files state the new version in the same commit, and contributor documents name those declarations instead of stating the version.

### Requirement: One test run per proof

The proof SHALL run the publication tests once per run, taking every test file that the local `test` task takes. That run's test and coverage reports SHALL be the proof's evidence for behavior, coverage and publication inputs alike.

#### Scenario: A full proof runs

- **WHEN** the repository's full proof runs
- **THEN** the complete declared diagram set is rendered and the publication tests run once, and the proof passes only if that run passes and leaves its coverage report.

### Requirement: Tests and exercises need only the standard library

Every Python file under `tests/` and `exercises/cases/` SHALL import only Python's standard library and modules in its own directory. The proof SHALL run the reader's exercise command from the edition archive under the host's Python, outside the locked test environment. Either check SHALL fail the run when its condition does not hold, even where the locked test environment provides the package.

#### Scenario: A test file imports a package outside the standard library

- **WHEN** a Python file under `tests/` or `exercises/cases/` imports a package that is neither part of Python's standard library nor a module in the file's own directory
- **THEN** a test fails and lists the file and the package, although the locked test environment can import that package.

#### Scenario: An exercise needs a package only at run time

- **WHEN** an exercise contract loads a package outside the standard library by a name computed at run time
- **THEN** the reader's exercise command fails in the archive test, as it would for a reader, and the proof fails.

### Requirement: Page feet without false endings

The layout SHALL keep what is read as one piece on one page only while it is short. A table or a sample box no taller than six body lines, and a code block of at most six lines, SHALL move to the next page whole; a taller one SHALL continue there, a continued table repeating its header. A section heading SHALL have room for three body lines under it on its page. A page that the manuscript ends on purpose SHALL be declared as such.

#### Scenario: A tall table meets the foot of a page

- **WHEN** a table or a sample box taller than six body lines does not fit in the space left on a page
- **THEN** it begins on that page and continues on the next; a table repeats its header there and keeps each row whole.

#### Scenario: A short block does not fit

- **WHEN** a table or a sample box no taller than six body lines does not fit in the space left on a page
- **THEN** it moves to the next page whole, and the page it leaves is short by no more than a block of that height and one paragraph step.

#### Scenario: An exercise asks the reader to answer before turning the page

- **WHEN** the manuscript ends a page on purpose
- **THEN** it declares the page turn through the layout's function, and the check of page feet leaves that page out.

#### Scenario: A rule keeps a tall block whole again

- **WHEN** a change makes a table or a sample box of any height move to the next page whole
- **THEN** a check fails on a page left emptier than a whole block allows before such a block, and names the page.

### Requirement: Printed commands work as pasted

A printed shell block SHALL give the stated result when a reader pastes it whole into an interactive shell with default options: it carries no trailing comment, and a request to a process the block starts in the background waits for it. A printed command that registers a job which later runs by itself SHALL be followed, before the next such registration, by the command that removes it.

#### Scenario: A reader pastes a block into the default macOS terminal

- **WHEN** a printed shell block is pasted whole into an interactive zsh without `interactivecomments`
- **THEN** no word beginning with `#` reaches a command, and the block gives the result the text states.

#### Scenario: A block starts a listener and requests it

- **WHEN** a printed block starts a process in the background and then sends it a request
- **THEN** a wait stands between the two lines, so that the request does not arrive before the process listens.

#### Scenario: A chapter registers a scheduled job

- **WHEN** a printed command registers a job that a scheduler will run by itself
- **THEN** the text says that the job is live and what a run costs, and the command that removes it follows before the next registration.

#### Scenario: A printed block gains a trailing comment

- **WHEN** a change adds a `#` comment to a printed command, removes the wait after a background start, or removes a job's removal command
- **THEN** a check fails and names the page.

### Requirement: Host behaviour states its basis

A statement in the book about how a host or tool behaves SHALL rest on runs or on the vendor's documentation, and SHALL say which, with the version it was observed on. Where repeated runs gave different results, the text SHALL describe what may happen rather than one outcome.

#### Scenario: A statement rests on the vendor's documentation

- **WHEN** the book states a host's default or rule that was read in the vendor's documentation and not run
- **THEN** the text says so where the statement stands, with the version the documentation names.

#### Scenario: Runs disagree

- **WHEN** repeated runs of one exercise gave different results
- **THEN** the text describes the possible results and the reader's check, not one of them as the outcome.

### Requirement: Printed commands survive copying

Copying a printed command from the PDF SHALL give the text that the source prints: every line of a code block with a declared language prints whole on one line, and an inline command prints whole.

#### Scenario: A reader copies a command from the PDF

- **WHEN** a reader copies a line of a code block with a declared language, or an inline command, from the PDF
- **THEN** the copy holds the line as printed, with no line break inside it.

#### Scenario: A printed line grows wider than its block

- **WHEN** a change makes a line of a code block with a declared language too wide to print on one line
- **THEN** a check fails and names the page.

### Requirement: Qualified edition

An edition SHALL be qualified before its release is approved, through the stages that `docs/publication-acceptance.md` describes, each covering the edition's final text.

#### Scenario: The stages of qualification

- **WHEN** an edition is qualified
- **THEN** readers who did not edit a passage have read it under 信、达、雅 as chapter 24 states them, a sentence-level cold read has covered the whole book and any passage changed after it has been read again, the prose beside each printed command has been compared with the run records and each command prints whole in the PDF, every page of the built PDF has been looked at, and a sample of the final text has met the national error-rate bar.

#### Scenario: A release is recommended

- **WHEN** an agent recommends releasing an edition
- **THEN** it names, for each stage, the record that covers the edition's final text, and a stage without such a record leaves the edition unqualified.

#### Scenario: The error rate is sampled

- **WHEN** the error rate of an edition is measured
- **THEN** at least 100,000 consecutive layout characters and the cover, title page, copyright page and contents of a PDF whose body text equals the final one are read, errors are counted by CY/T 266, and the edition qualifies at no more than one error per 10,000 characters.

#### Scenario: Text changes after a stage

- **WHEN** the book's text changes after a stage has read it
- **THEN** that stage reads the changed passages again before the edition qualifies.

### Requirement: Typeset output keeps to its declared supply

The PDF SHALL embed only the fonts that the toolchain declares, SHALL compile without warnings, SHALL end no wrapped line of a body paragraph, a table cell or a sample box with a single character alone, SHALL leave on each page of a table or sample box that continues on the next page at least the least part the layout declares, and SHALL open the space between two Chinese characters of a justified body line by no more than the bound the layout declares.

#### Scenario: A glyph is missing from the declared fonts

- **WHEN** a printed character has no glyph in the fonts its text names
- **THEN** a check fails and names the font that was embedded in its place.

#### Scenario: A change leaves a character alone on a line

- **WHEN** a change makes a body paragraph, a table cell or a sample box wrap with a single character on its last line
- **THEN** a check fails and names the page.

#### Scenario: A block splits with too little on one page

- **WHEN** a table or sample box continues on the next page and one of its two parts is shorter than the least part the layout declares
- **THEN** a check fails and names the page and the part's height.

#### Scenario: A justified line reads as letter-spaced

- **WHEN** a Latin word, a time or a command too long for the rest of a body line makes justification open the line's Chinese characters past the declared bound
- **THEN** a check fails and names the page and the line.

### Requirement: Talent judged by a stated standard

The manuscript SHALL state how a piece of work and a member's performance are judged: a work score for one piece, a tier for one period at the member's own grade, and the professional sequence of grades, joined by one chain of evidence. It SHALL state them in its own words, derived from the department's guidelines, so that a reader without those guidelines can apply them.

#### Scenario: A reader judges a period

- **WHEN** a reader applies the chapter to a member's period of work
- **THEN** they can name the evidence each tier needs, read the tier against the member's own grade, and record it with its period, scope and records.

#### Scenario: The guidelines change

- **WHEN** the department's guidelines revise a grade, a tier or the procedure
- **THEN** a later Change brings the chapter into agreement, and the book defines no standard of its own beside them.

### Requirement: Edition within its page ceiling

The built PDF SHALL hold no more pages than the ceiling that the layout declares.

#### Scenario: A change makes the book longer

- **WHEN** a change makes the PDF exceed the declared ceiling
- **THEN** a check fails and names the page count and the ceiling, and room is made by removing a second statement of something the book says once elsewhere, not by removing substance.

### Requirement: Book prose keeps its decided wording

The book's sources SHALL use none of the words that the book-wide decisions replaced or avoid, and SHALL set full-width punctuation against Chinese characters where GB/T 15834 decides it. The rules SHALL be held in one declared style, each with its source, date and cases that show it alerting and passing, and a proof gate SHALL run the cases and the rules on every change.

#### Scenario: A replaced word comes back

- **WHEN** a change brings a replaced or avoided word, or half-width punctuation against a Chinese character, into the book's prose
- **THEN** the gate fails and names the file, the line and the decided form.

#### Scenario: A quotation keeps a speaker's words

- **WHEN** the book quotes a speaker whose own words a rule would flag
- **THEN** the quotation stands where the declared style skips a speaker's words, and the prose around it is still read.

#### Scenario: A decision depends on sense

- **WHEN** a decision cannot be told from the words alone
- **THEN** it is left to the reader, and the rules do not claim it.

### Requirement: Reviewed text before landing

A head whose `book/` or `exercises/` tree differs from every reviewed one SHALL NOT pass the proof. The repository SHALL record, for the head's `book/` and `exercises/` trees, a review of the printed commands and the prose beside them against the run records, and, for its `book/` tree, a reading of every changed passage by a reader who did not write it; each record SHALL name what was read, against what, when, where the findings are, and how each point was settled or why it was declined.

#### Scenario: A change to the text has no review

- **WHEN** a head changes `book/` or `exercises/` and no record covers its trees
- **THEN** a check fails and names the trees.

#### Scenario: A review has an open point

- **WHEN** a review ends with a point neither settled nor declined
- **THEN** it is not recorded, and the head does not pass until a later review is.

### Requirement: Chapter references are derived

The manuscript SHALL derive every reference to a chapter, a practice or an appendix by its number from the number that the chapter's opening declares, and SHALL point each relative reference, 上一章 or 下一章, at the chapter just before or after the one it stands in, in the manuscript's reading order.

#### Scenario: A chapter is renumbered

- **WHEN** a chapter is inserted, removed or moved and the openings' numbers change
- **THEN** every reference by number reads the new number without an edit at the reference.

#### Scenario: A reference is written by hand

- **WHEN** a change writes 「第X章」 in the manuscript's prose
- **THEN** a check fails and names the file and the line.

#### Scenario: A relative reference points elsewhere

- **WHEN** 上一章 or 下一章 names a chapter that is not adjacent in the reading order, or names none
- **THEN** a check fails and names the file and the word.
