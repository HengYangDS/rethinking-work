## MODIFIED Requirements

### Requirement: Declared supply release age

The repository SHALL declare, in each resolver's own configuration, the minimum age a tool or package release must have before it enters the locked supply, and SHALL admit a newer version only when it is at least that old. The age SHALL NOT be restated as a number in a test or script.

#### Scenario: A locked tool is moved

- **WHEN** a locked tool or Python package is moved to a newer version
- **THEN** the resolver refuses a release younger than the declared age, the lock and the pipeline declarations with their generated files state the new version in the same commit, and contributor documents name those declarations instead of stating the version.

### Requirement: One test run per proof

The proof SHALL run the publication tests once per run, taking every test file that the local `test` task takes. That run's test and coverage reports SHALL be the proof's evidence for behavior, coverage and publication inputs alike.

#### Scenario: A full proof runs

- **WHEN** the repository's full proof runs
- **THEN** the complete declared diagram set is rendered and the publication tests run once, and the proof passes only if that run passes and leaves its coverage report.
