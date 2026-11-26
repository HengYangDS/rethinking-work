## Purpose

Keep the book's Chinese accurate, idiomatic and faithful to its source meaning, in standard written Chinese with the wording and punctuation the book has decided.

## ADDED Requirements

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

#### Scenario: A quoted question

- **WHEN** the book quotes the words asked after 问, 追问 or 反问
- **THEN** the question mark stands inside the quotation marks and no mark follows the closing one, while a question used as a name takes none.

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

#### Scenario: A passage is about people

- **WHEN** a passage describes colleagues, their work, their assessment or their growth
- **THEN** the person is the subject, the purpose comes before the mechanism, the support comes before the requirement, the procedure stays in proportion to the point, and the passage reads as written by a person for colleagues.

#### Scenario: An agent writes, edits or reads the book's Chinese

- **WHEN** an agent writes, revises or cold-reads the book's Chinese
- **THEN** it works from the repository skill `book-chinese-prose`, whose terms, translated forms, human voice and reading brief are the standard, and a reading marks translated or wrong Chinese, coldness toward people, behaviour unlike people, unclear sentences, and word choice or composition below the standard.
