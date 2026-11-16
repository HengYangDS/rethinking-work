# Publication Source

## Purpose

Provide a complete and attributable source publication that editors can navigate, readers can learn from, and contributors can rebuild without inheriting private workstation state.

## ADDED Requirements

### Requirement: Cohesive publication inputs

The publication SHALL maintain one editable owner for manuscript meaning, edition identity, presentation, diagram sources, synthetic exercises and reader references. Reproducible generated output SHALL stay outside tracked source.

#### Scenario: Editor follows a figure

- **WHEN** an editor selects a figure in the manuscript
- **THEN** its editable source and rendering configuration are discoverable and its rendered image is generated under the declared build output.

### Requirement: Portable and attributable edition

The publication SHALL identify its title, author 衡阳, date and language in visible front matter and PDF metadata. Portable inputs MUST NOT depend on private stores or host-specific receipt paths.

#### Scenario: Reader opens the PDF

- **WHEN** the PDF is rebuilt through the declared entrypoint
- **THEN** its author and editorial date agree with the visible attribution and its references distinguish cases, recommendations and synthetic exercises.

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

### Requirement: Leader's account of work in the agentic era

The manuscript SHALL present, in the department leader's voice, an account of work and team collaboration in the agentic era that teaches a team how to think, act and collaborate. It SHALL cover principle, method, how an Agent works and is operated, practice and tooling, and pair each principle with worked practice drawn from data work.

#### Scenario: Reader works through a principle

- **WHEN** a chapter states a principle
- **THEN** it explains why the principle holds, shows it in a worked case, states what the team does because of it, and states the conditions the method needs where they carry substance.

#### Scenario: Reader learns to operate an Agent

- **WHEN** a reader finishes the Agent part
- **THEN** they can explain the layers of an agentic system (model, harness, context, tools, boundaries, memory, orchestration, evaluation), place a named tool in its layer, and have run a first session of their own and read its record; after the part on handing over they can hand out, take back, checkpoint, diagnose and close a piece of work.

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

The manuscript SHALL be organized by how fast each layer changes, from principle to tooling, not by tools, products or present process steps. A present practice used as material SHALL be weighed against the end state the manuscript argues for.

#### Scenario: Material describes only a tool or a procedure

- **WHEN** a topic bears on no principle, method or deliberate change
- **THEN** it is left out of the manuscript.

#### Scenario: A present practice falls short

- **WHEN** the manuscript uses a present practice as material
- **THEN** it says where that practice falls short of the end state.

### Requirement: Positions of the author's own

The manuscript SHALL reason from stated conditions to its principles rather than restate guidance, SHALL state its authorship as it is, and SHALL NOT pad its claims with modest disclaimers.

#### Scenario: A principle rests on a present condition

- **WHEN** a principle holds only because of a present condition
- **THEN** the manuscript states that condition as a fact where the principle is taught, and the back matter carries no list of doubts.

### Requirement: Public source without internal disclosure

The tracked publication source SHALL NOT disclose an internal organization scheme, person, vendor, internal system or performance figure. Cases SHALL be rewritten from real work and identified as rewritten.

#### Scenario: A case comes from an internal incident

- **WHEN** a chapter uses an internal incident as a case
- **THEN** its objects and numbers are replaced, and the back matter states that cases are rewritten.

### Requirement: Meaning-led Chinese editorial review

Chinese prose SHALL use accurate concepts and idiomatic paragraph structure. Editorial revision SHALL preserve the source's objects, actors, relationships, numbers, dates, negation, conditions, attribution and uncertainty. Practical instructions SHALL identify the actor, prerequisites, action and observable result. A reviewer score, agreement or word substitution SHALL NOT establish this acceptance.

#### Scenario: One source term has different meanings

- **WHEN** a source term refers to credentials in one passage and sensitive information or non-sensitive metadata in another
- **THEN** each passage expresses its own intended meaning in natural Chinese, and whole-paragraph source comparison and cold reading qualify the revision rather than a global replacement.

### Requirement: Direct prose with limits stated once

Chinese prose SHALL state what a thing is and does. A scope limit SHALL appear once where it applies, at the case or in the back matter, rather than after each passage.

#### Scenario: A case has a limited scope

- **WHEN** a retained case supports only what was checked on its date
- **THEN** the back matter records that limit with the case's date and source role, and the chapter does not repeat it after each paragraph that uses the case.

### Requirement: Plain prose that leads the reader

Chinese prose SHALL reach its point through a concrete situation and plain words. It SHALL describe what the team does and why rather than instruct the reader, and SHALL NOT use coined labels, maxims or enumerations whose only purpose is to sound systematic.

#### Scenario: A chapter introduces a principle

- **WHEN** a chapter states a principle or method
- **THEN** a case from real work precedes it, the statement appears once in everyday language with its reason, and the chapter's lead line poses the question the chapter answers.

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

### Requirement: Independent publication build

The public publication job SHALL build the candidate PDF and a `.tgz` practice
archive from the exact event commit and complete declared publication inputs.
It SHALL preserve project locks and exclude credentials, business data and
standalone restricted fonts from its outputs. A hosted success SHALL NOT
establish reader delivery or editorial approval.

#### Scenario: A clean macOS Runner builds the publication

- **WHEN** the exact event source, locked tools, declared fonts and complete official publisher packages are available
- **THEN** the native build regenerates the figures, produces the PDF and practice archive, records input and artifact identities, and fails on missing or changed required inputs or project-lock drift.

#### Scenario: The practice archive is read outside the source checkout

- **WHEN** a reader safely extracts the archive in an environment with the declared exercise tools
- **THEN** the selected tracked teaching files and Chinese entrypoint retain their complete bytes, all 15 synthetic exercise contracts run, and no installation, business-data access or service startup is performed.
