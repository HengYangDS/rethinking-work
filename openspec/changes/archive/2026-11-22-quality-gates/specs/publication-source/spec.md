## ADDED Requirements

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

The PDF SHALL embed only the fonts that the toolchain declares, SHALL compile without warnings, and SHALL end no body paragraph with a single character alone on its last line.

#### Scenario: A glyph is missing from the declared fonts

- **WHEN** a printed character has no glyph in the fonts its text names
- **THEN** a check fails and names the font that was embedded in its place.

#### Scenario: A change leaves a character alone on a line

- **WHEN** a change makes a body paragraph end with a single character on its own line
- **THEN** a check fails and names the page.
