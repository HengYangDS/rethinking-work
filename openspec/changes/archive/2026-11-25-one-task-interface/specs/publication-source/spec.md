## MODIFIED Requirements

### Requirement: One test run per proof

The proof SHALL run the publication tests once per run, taking every test file that the local `test` task takes. That run's test and coverage reports SHALL be the proof's evidence for behavior, coverage and publication inputs alike.

#### Scenario: A full proof runs

- **WHEN** the repository's full proof runs
- **THEN** the publication tests run once, and the proof passes only if that run passes and leaves its coverage report.

#### Scenario: A contributor runs the tests locally

- **WHEN** a contributor runs the local test task
- **THEN** the tests run with the runner and configuration that the proof uses, without its reports.
