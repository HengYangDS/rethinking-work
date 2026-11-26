## MODIFIED Requirements

### Requirement: Behaviour claims grounded in runs

A statement about what a tool, a host or an Agent does SHALL rest on a run recorded on the stated version, on a primary source such as the vendor's documentation, or on reasoning presented as reasoning, and SHALL say which, with the version it was observed on. A claim about an Agent's tendency SHALL state the conditions and the number of runs where the result is used, once. Where repeated runs gave different results, the text SHALL describe what may happen rather than one outcome.

#### Scenario: A tendency is stated

- **WHEN** a chapter states that an Agent tends to do something
- **THEN** a recorded experiment with stated model, host, conditions and number of runs supports it, or the chapter derives it from how the model works and says so, or the statement is removed.

#### Scenario: A tool changes after the edition

- **WHEN** a later version of a named tool changes a command or an output printed in the manuscript
- **THEN** the back matter's version for that tool identifies which version the printed command and output belong to, and the next edition reruns the experiment before reprinting them.

#### Scenario: A risk the runs did not show

- **WHEN** a chapter states a risk that its own runs did not exercise
- **THEN** it says what those runs showed and that the risk was not tested.

#### Scenario: A statement rests on the vendor's documentation

- **WHEN** the book states a host's default or rule that was read in the vendor's documentation and not run
- **THEN** the text says so where the statement stands, with the version the documentation names.

#### Scenario: Runs disagree

- **WHEN** repeated runs of one exercise gave different results
- **THEN** the text describes the possible results and the reader's check, not one of them as the outcome.

### Requirement: Printed commands work as pasted

A printed command SHALL give the stated result when a reader copies it from the PDF and pastes it whole into an interactive shell with default options. A printed command that registers a job which later runs by itself SHALL be followed, before the next such registration, by the command that removes it.

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

#### Scenario: A reader copies a command from the PDF

- **WHEN** a reader copies a line of a code block with a declared language, or an inline command, from the PDF
- **THEN** the copy holds the line as printed, with no line break inside it.

#### Scenario: A printed line grows wider than its block

- **WHEN** a change makes a line of a code block with a declared language too wide to print on one line
- **THEN** a check fails and names the page.

### Requirement: Qualified edition

An edition SHALL be qualified before its release is approved, through the stages that `docs/publication-acceptance.md` describes, each covering the edition's final text. A build that passed SHALL NOT by that alone be represented as qualified, reader-approved or published; until the edition qualifies, its PDF is a candidate and the copy readers already have is not replaced.

#### Scenario: Build succeeds before editorial review

- **WHEN** the native build succeeds but a stage has not yet covered the edition's final text
- **THEN** the artifact remains a candidate and the existing reader output is not silently replaced.

#### Scenario: The stages of qualification

- **WHEN** an edition is qualified
- **THEN** readers who did not edit a passage have read it under 信、达、雅 as chapter 24 states them, a sentence-level cold read has covered the whole book and any passage changed after it has been read again, the prose beside each printed command has been compared with the run records and each command prints whole in the PDF, the built PDF's contents, links and metadata have been checked and every page of it has been looked at, and a sample of the final text has met the national error-rate bar.

#### Scenario: A release is recommended

- **WHEN** an agent recommends releasing an edition
- **THEN** it names, for each stage, the record that covers the edition's final text, and a stage without such a record leaves the edition unqualified.

#### Scenario: The error rate is sampled

- **WHEN** the error rate of an edition is measured
- **THEN** at least 100,000 consecutive layout characters and the cover, title page, copyright page and contents of a PDF whose body text equals the final one are read, errors are counted by CY/T 266 with the readings `docs/publication-acceptance.md` declares, a reader's note that a judge finds to be an error counts, a two-point error or note counts when either of two blind judges from outside the raising family finds an error, at the higher figure, and the edition qualifies at no more than one error per 10,000 characters.

#### Scenario: Text changes after a stage

- **WHEN** the book's text changes after a stage has read it
- **THEN** that stage reads the changed passages again before the edition qualifies.

#### Scenario: Readers leave notes

- **WHEN** a reading or a sample leaves notes that it did not count as errors
- **THEN** the editors decide each note against the current text before the next reading, change what is improper, and record a reason for each note they keep.

#### Scenario: A reading finds errors

- **WHEN** a whole-book reading's judged errors come back
- **THEN** each is corrected or kept with its reason before the sample, and the corrected passages are read again.

## ADDED Requirements

### Requirement: Chinese prose

Chinese prose SHALL reach its point through a concrete situation, in standard written Chinese and an even, third-person register that states facts and reasons from them, and SHALL state what a thing is and does, and what the team does and why, once. Editorial revision SHALL preserve the source's meaning, and a reviewer score, agreement or word substitution SHALL NOT establish that it did.

#### Scenario: A sentence is written or revised

- **WHEN** a sentence of the book is written or revised
- **THEN** its concepts are accurate, every word is in its dictionary sense, its collocations and paragraph are idiomatic, and its punctuation follows GB/T 15834.

#### Scenario: A passage could say more than it needs

- **WHEN** a passage would narrate in the first person, stress who did or wrote something, assert that an example really happened, deny or exclude a meaning the text never gave, restate a point just made, explain what is already plain, or use a coined label, maxim or enumeration whose only purpose is to sound systematic
- **THEN** it does none of these.

#### Scenario: The reader is told what to do

- **WHEN** a hands-on passage tells the reader what to do
- **THEN** it may address the reader and names the actor, prerequisites, action and observable result, while the rest of the book describes what the team does and why rather than instructing the reader.

#### Scenario: A passage is revised

- **WHEN** an editor revises a passage
- **THEN** its objects, actors, relationships, numbers, dates, negation, conditions, attribution and uncertainty stay as the source had them.

#### Scenario: A passage carries a detail

- **WHEN** a detail does not serve the point of its passage
- **THEN** the passage leaves it out, even when the detail is true.

#### Scenario: One source term has different meanings

- **WHEN** a source term refers to credentials in one passage and sensitive information or non-sensitive metadata in another
- **THEN** each passage expresses its own intended meaning in natural Chinese, and whole-paragraph source comparison and cold reading qualify the revision rather than a global replacement.

#### Scenario: A case has a limited scope

- **WHEN** a demonstration or worked result holds only under stated conditions
- **THEN** those conditions appear once, where the result is used or in the back matter, and the chapter does not repeat them after each paragraph that uses the result.

#### Scenario: A judgement is described

- **WHEN** the book states what a judgement of work or of a member rests on
- **THEN** it names what the judgement rests on and nothing that the judgement does not judge.

#### Scenario: A run is cited

- **WHEN** a chapter rests a claim on a run
- **THEN** the chapter states the behaviour and its reasoning, and the run's conditions and versions stand once in the appendix it points to.

#### Scenario: An idiom says it more exactly

- **WHEN** an established idiom, set phrase or allusion says a thing more exactly or more briefly than plain words
- **THEN** the prose uses it in its dictionary sense, and never as decoration or as a slogan.

#### Scenario: A chapter introduces a principle

- **WHEN** a chapter states a principle or method
- **THEN** a scenario precedes it, the statement appears once in everyday language with its reason, and the chapter's lead line poses the question the chapter answers.

## REMOVED Requirements

### Requirement: Host behaviour states its basis

**Reason**: It restated "Behaviour claims grounded in runs" for hosts and tools.

**Migration**: Its rule and both scenarios now stand in "Behaviour claims grounded in runs".

### Requirement: Printed commands survive copying

**Reason**: Copying from the PDF is the first half of pasting a printed command.

**Migration**: Its rule and both scenarios now stand in "Printed commands work as pasted".

### Requirement: Truthful publication acceptance

**Reason**: It stated in general what "Qualified edition" states stage by stage, and its proof scenario restated "Reviewed text before landing".

**Migration**: A build that passed is a candidate until the edition qualifies, and the PDF's contents, links and metadata are checked, as "Qualified edition" now says; a proved head's reviews stand in "Reviewed text before landing".

### Requirement: Objective register

**Reason**: One of four overlapping requirements on Chinese prose.

**Migration**: Its rule and scenario now stand in "Chinese prose".

### Requirement: Meaning-led Chinese editorial review

**Reason**: One of four overlapping requirements on Chinese prose.

**Migration**: Its rule and scenario now stand in "Chinese prose".

### Requirement: Direct prose with limits stated once

**Reason**: One of four overlapping requirements on Chinese prose.

**Migration**: Its rule and its three scenarios now stand in "Chinese prose".

### Requirement: Plain prose that leads the reader

**Reason**: One of four overlapping requirements on Chinese prose.

**Migration**: Its rule and its two scenarios now stand in "Chinese prose".
