## ADDED Requirements

### Requirement: Host behaviour states its basis

A statement in the book about how a host or tool behaves SHALL rest on runs or on the vendor's documentation, and SHALL say which, with the version it was observed on. Where repeated runs gave different results, the text SHALL describe what may happen rather than one outcome.

#### Scenario: A statement rests on the vendor's documentation

- **WHEN** the book states a host's default or rule that was read in the vendor's documentation and not run
- **THEN** the text says so where the statement stands, with the version the documentation names.

#### Scenario: Runs disagree

- **WHEN** repeated runs of one exercise gave different results
- **THEN** the text describes the possible results and the reader's check, not one of them as the outcome.
