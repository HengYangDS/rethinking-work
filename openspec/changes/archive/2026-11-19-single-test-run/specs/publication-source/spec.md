## ADDED Requirements

### Requirement: One test run per proof

The proof SHALL run the publication tests once per run, taking every test file that the local `test` task takes. That run's test and coverage reports SHALL be the proof's evidence for behavior, coverage and publication inputs alike.

#### Scenario: A full proof runs

- **WHEN** the repository's full proof runs
- **THEN** the six diagrams are rendered and the publication tests run once, and the proof passes only if that run passes and leaves its coverage report.

### Requirement: Tests and exercises need only the standard library

Every Python file under `tests/` and `exercises/cases/` SHALL import only Python's standard library and modules in its own directory. The proof SHALL run the reader's exercise command from the edition archive under the host's Python, outside the locked test environment. Either check SHALL fail the run when its condition does not hold, even where the locked test environment provides the package.

#### Scenario: A test file imports a package outside the standard library

- **WHEN** a Python file under `tests/` or `exercises/cases/` imports a package that is neither part of Python's standard library nor a module in the file's own directory
- **THEN** a test fails and lists the file and the package, although the locked test environment can import that package.

#### Scenario: An exercise needs a package only at run time

- **WHEN** an exercise contract loads a package outside the standard library by a name computed at run time
- **THEN** the reader's exercise command fails in the archive test, as it would for a reader, and the proof fails.
