## MODIFIED Requirements

### Requirement: Truthful publication acceptance

A compiled document SHALL NOT be represented as reader-approved or published solely because its build passed. Delivery SHALL verify complete content, navigation, metadata and every final page within its stated review scope.

#### Scenario: Build succeeds before editorial review

- **WHEN** the native build succeeds but editorial revision or visual inspection remains unfinished
- **THEN** the artifact remains a candidate and the existing reader output is not silently replaced.

#### Scenario: A head is proved

- **WHEN** a head that changed the book's text or exercises is proved
- **THEN** its `book/` and `exercises/` trees carry a recorded commands review and reading, each point settled or declined.
