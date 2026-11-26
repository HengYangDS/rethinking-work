## MODIFIED Requirements

### Requirement: Reviewed text before landing

A head whose `book/` or `exercises/` tree differs from every reviewed one SHALL NOT pass the proof. The repository SHALL record, for the head's `book/` and `exercises/` trees, a review of the printed commands and the prose beside them against the run records, and, for its `book/` tree, a reading of every changed passage by a reader who did not write it; each record SHALL name what was read, against what, when, its verdict, and how many points were settled and how many declined.

#### Scenario: A change to the text has no review

- **WHEN** a head changes `book/` or `exercises/` and no record covers its trees
- **THEN** a check fails and names the trees.

#### Scenario: A review has an open point

- **WHEN** a review ends with a point neither settled nor declined
- **THEN** it is not recorded, and the head does not pass until a later review is.

#### Scenario: A record names another baseline

- **WHEN** the latest commands review that covers a proved head records as its baseline a tag other than the last release, the latest release tag `v<major>.<minor>.<patch>` that carries a signature and was made no later than the review's findings were written
- **THEN** a check fails and names the recorded tag and the last release, because the printed commands are compared with the last release's.

#### Scenario: A review time has no offset

- **WHEN** a record's time of reading carries no time zone offset
- **THEN** a check fails and names the record, because the time would be read in the runner's own zone.

## ADDED Requirements

### Requirement: Review records hold only their declared fields

Each entry of the review record SHALL hold exactly the fields its kind declares; a reviewer's words and paths to local evidence SHALL stay with the findings, outside the tracked tree.

#### Scenario: A record holds more than its fields

- **WHEN** an entry of the review record holds a field its kind does not declare, such as the path of its findings or a point in the reviewer's words
- **THEN** a check fails and names the entry, because the record carries the review's facts, not its text.
