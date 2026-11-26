## ADDED Requirements

### Requirement: Edition facts declared once

The edition SHALL declare once the names its archive gives the folder, the PDF, the practice pack, the reader notes and the checksum list, the place where the book tells the reader the pack lies, the companion appendix's title and the command that runs the pack's checks. The book, both reader notes, the archive and its checks SHALL take them from that declaration.

#### Scenario: A declared name changes

- **WHEN** the declaration renames the pack's folder or changes the check command
- **THEN** the printed commands, the prose, both reader notes, the archive's layout and the archive's check carry the new value without another edit.

## MODIFIED Requirements

### Requirement: Cohesive publication inputs

The publication SHALL maintain one editable owner for manuscript meaning, edition identity, presentation, diagram sources, synthetic exercises and reader references. Reproducible generated output SHALL stay outside tracked source.

#### Scenario: Editor follows a figure

- **WHEN** an editor selects a figure in the manuscript
- **THEN** its editable source is discoverable, and the figure is drawn from it in the same compile as the book, with the book's fonts and the layout's colours, without a browser.

#### Scenario: A figure is set in the column

- **WHEN** the book is built
- **THEN** each figure and its caption stand centred in the text column, and a check fails and names the figure that does not.

#### Scenario: A reader starts the exercises

- **WHEN** a reader opens the practice pack
- **THEN** the companion appendix is the one index of the exercises, and the pack holds no second copy of an exercise or its answer.

#### Scenario: A chapter joins a part

- **WHEN** a chapter is added to a part or moved between parts
- **THEN** only the parts declared in `book/manuscript.typ` change, and the chapter heads, the contents and the checks follow them.

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

### Requirement: Chapter references are derived

The manuscript SHALL take each chapter's, practice's and appendix's number, counted within its kind, and each part's number from the reading order that `book/manuscript.typ` declares, SHALL derive every reference to a chapter, a practice, an appendix or a part by its number from that order, and SHALL point each relative reference, 上一章 or 下一章, at the chapter just before or after the one it stands in.

#### Scenario: A chapter is renumbered

- **WHEN** a chapter or a part is inserted, removed or moved in the reading order
- **THEN** every number and every reference by number reads the new order without an edit at the chapter, the part or the reference.

#### Scenario: A reference is written by hand

- **WHEN** a change writes 「第X章」 or 「第X部」 in the manuscript's prose
- **THEN** a check fails and names the file and the line.

#### Scenario: A relative reference points elsewhere

- **WHEN** 上一章 or 下一章 names a chapter that is not adjacent in the reading order, or names none
- **THEN** a check fails and names the file, the reference and the chapter it should name.
