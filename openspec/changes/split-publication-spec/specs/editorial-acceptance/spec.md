## Purpose

Qualify an edition, and admit a change to its text, only on recorded reviews and readings that cover its final text, kept distinct from build and release success.

## ADDED Requirements

### Requirement: Qualified edition

An edition SHALL be qualified before its release is approved, through the stages that `docs/publication-acceptance.md` describes, each covering the edition's final text. A build that passed SHALL NOT by that alone be represented as qualified, reader-approved or published; until the edition qualifies, its PDF is a candidate and the copy readers already have is not replaced.

#### Scenario: Build succeeds before editorial review

- **WHEN** the native build succeeds but a stage has not yet covered the edition's final text
- **THEN** the artifact remains a candidate and the existing reader output is not silently replaced.

#### Scenario: The stages of qualification

- **WHEN** an edition is qualified
- **THEN** readers who did not edit a passage have read it under 信、达、雅 as the book's chapter on writing states them, a sentence-level cold read has covered the whole book and any passage changed after it has been read again, the prose beside each printed command has been compared with the run records and each command prints whole in the PDF, the built PDF's contents, links and metadata have been checked and every page of it has been looked at, and a sample of the final text has met the national error-rate bar.

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

### Requirement: Reviewed text before landing

A head SHALL pass the proof only when the repository records, for its `book/` and `exercises/` trees, its reader notes and the Python line its printed commands name, a review of those commands and the prose beside them against the run records, and, for its `book/` tree, a reading of every changed passage by a reader who did not write it. Each record SHALL name what was read, against what, when, its verdict, and how many points were settled and how many declined.

#### Scenario: A change to the text has no review

- **WHEN** a head changes `book/`, `exercises/` or the reader notes and no record covers them
- **THEN** a check fails and names the trees.

#### Scenario: Only the Python line changes

- **WHEN** a head changes the declared Python line and no commands review records it with the head's trees
- **THEN** a check fails and names the trees and the line, because the printed commands name the line.

#### Scenario: A review has an open point

- **WHEN** a review ends with a point neither settled nor declined
- **THEN** it is not recorded, and the head does not pass until a later review is.

#### Scenario: A record names another baseline

- **WHEN** the latest commands review that covers a proved head records as its baseline a tag other than the last release, the latest release tag `v<major>.<minor>.<patch>` that carries a signature and was made no later than the review's findings were written
- **THEN** a check fails and names the recorded tag and the last release, because the printed commands are compared with the last release's.

#### Scenario: A review time has no offset

- **WHEN** a record's time of reading carries no time zone offset
- **THEN** a check fails and names the record, because the time would be read in the runner's own zone.

### Requirement: Review records hold only their declared fields

Each entry of the review record SHALL hold exactly the fields its kind declares; a reviewer's words and paths to local evidence SHALL stay with the findings, outside the tracked tree.

#### Scenario: A record holds more than its fields

- **WHEN** an entry of the review record holds a field its kind does not declare, such as the path of its findings or a point in the reviewer's words
- **THEN** a check fails and names the entry, because the record carries the review's facts, not its text.
