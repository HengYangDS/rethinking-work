# Publication Source

## ADDED Requirements

### Requirement: Declared supply release age

The repository SHALL declare, in each resolver's own configuration, the minimum age a tool or package release must have before it enters the locked supply, and SHALL admit a newer version only when it is at least that old. The age SHALL NOT be restated as a number in a test or script.

#### Scenario: A locked tool is moved

- **WHEN** a locked tool or Python package is moved to a newer version
- **THEN** the resolver refuses a release younger than the declared age, and the lock, the pipeline declarations with their generated files and the contributor documents state the new version in the same commit.
