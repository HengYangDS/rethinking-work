## MODIFIED Requirements

### Requirement: Versioned release

A version SHALL be released as a signed `v` tag on `main` that matches `VERSION`,
published to both peers through native ETHOS publication. Each peer SHALL carry
a release for that tag whose assets are the edition archive built from the tag
and a SHA-256 list of it. A release SHALL NOT by itself establish editorial
acceptance.

#### Scenario: A qualified edition is released

- **WHEN** the owner approves a qualified edition for release
- **THEN** the changelog's entries move under that version and date, the signed tag reaches both peers, both peers' tag pipelines build the archive independently, and each peer's release carries the archive whose downloaded bytes match the SHA-256 list.

#### Scenario: A maintainer makes a release

- **WHEN** a maintainer prepares a release
- **THEN** the steps, their order and which of them need the owner's word stand in `docs/publication-acceptance.md`, and the release Change cites them instead of restating them.
