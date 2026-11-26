## ADDED Requirements

### Requirement: Runner supply in the account's caches

A CI runner's supply of fonts SHALL be kept in the runner account's cache, outside the checkout, and its Typst
packages in the package cache that Typst reports, by default also the account's. Both SHALL reach Typst through
Typst's own settings, and the supply task SHALL NOT write into the account's font folder.

#### Scenario: A job starts after the checkout lost its ignored files

- **WHEN** the runner has removed the checkout's ignored files at a job's start and the account's cache holds the declared supply
- **THEN** the supply task fetches nothing, and the build reads the declared faces and packages from that cache.

#### Scenario: Typst keeps its packages elsewhere

- **WHEN** Typst reports a package cache other than its default
- **THEN** the supply task fills that cache, and the check that every package read is supplied reads the same cache.
