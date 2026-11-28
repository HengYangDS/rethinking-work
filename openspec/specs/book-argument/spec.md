# book-argument Specification

## Purpose

Give the manuscript an argument that teaches a team how to think, act and collaborate in the agentic era, reasoned from stated conditions and grounded in recorded runs or named sources, and keep every tracked source of the publication free of internal disclosure, its examples scenarios rather than accounts of real events.

## Requirements

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

### Requirement: Growth toward stated goals

The manuscript SHALL present the professional sequence and a period's assessment as goals for a member's growth: what each grade asks, what each tier means against the member's own grade and the next step it points to, and the principles of assessment. It SHALL state these essentials in its own words from the department's guidelines, beginning with their purpose, and SHALL leave detailed conditions, evidence counts, procedure and the work score to the guidelines.

#### Scenario: A member reads where they stand

- **WHEN** a member reads the chapter after a period
- **THEN** they can name what their grade asks, what their tier means, and the next step it points to.

#### Scenario: A reader judges a period

- **WHEN** a leader applies the chapter to a member's period of work
- **THEN** they look at the records the work left, read the tier against the member's own grade, tell the member the result in person, and agree the next step with them.

#### Scenario: The guidelines change

- **WHEN** the department's guidelines revise a grade, a tier or the procedure
- **THEN** a later Change brings the chapter into agreement, and the book defines no standard of its own beside them.

#### Scenario: A reader needs a procedural detail

- **WHEN** a reader needs a tier's detailed conditions, the evidence it needs, the steps of an assessment, the work score or the evidence for a crossing
- **THEN** the chapter says that the department's guidelines decide it and states no rule of its own.

### Requirement: Both halves of the stance

The manuscript SHALL derive from its root both what does not change and what may be redesigned. It SHALL tell the
conditions a result must meet from the practices that vouched for them while making was dear, SHALL show how its later
parts replace such practices, and SHALL state where people's work is heading as a judgement derived from its premises,
with the conditions that would overturn it, not from what agents cannot yet do.

#### Scenario: A reader meets a change the book does not name

- **WHEN** a reader faces a new tool or practice the book does not discuss
- **THEN** they can ask which practice it cuts loose from which condition, what now carries that condition, and change
  the rest.

#### Scenario: Models get stronger

- **WHEN** models and tools improve
- **THEN** the book's judgement of where people's work gathers still follows from its four facts and the convention
  that whoever decides answers for it, and its back matter says when that judgement is to be revisited.

#### Scenario: The opening and the ending

- **WHEN** a reader reads the preface and the closing
- **THEN** the preface states what is kept and what is redesigned, and the closing draws the reshaped work before the
  person's own step.
