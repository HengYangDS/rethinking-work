## MODIFIED Requirements

### Requirement: Reviewed text before landing

A head whose `book/` or `exercises/` tree differs from every reviewed one SHALL NOT pass the proof. The repository SHALL record, for the head's `book/` and `exercises/` trees, a review of the printed commands and the prose beside them against the run records, and, for its `book/` tree, a reading of every changed passage by a reader who did not write it; each record SHALL name what was read, against what, when, where the findings are, and how each point was settled or why it was declined.

#### Scenario: A change to the text has no review

- **WHEN** a head changes `book/` or `exercises/` and no record covers its trees
- **THEN** a check fails and names the trees.

#### Scenario: A review has an open point

- **WHEN** a review ends with a point neither settled nor declined
- **THEN** it is not recorded, and the head does not pass until a later review is.

#### Scenario: A record names another baseline

- **WHEN** the latest commands review that covers a proved head records as its baseline a tag other than the last release, the latest signed release tag in the head's history that was made no later than the review
- **THEN** a check fails and names the recorded tag and the last release, because the printed commands are compared with the last release's.
