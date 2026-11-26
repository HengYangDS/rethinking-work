## Purpose

Identify each build as a version's edition or as a draft, from the release tag and one declared set of edition facts, both in what readers see and in the PDF's metadata.

## ADDED Requirements

### Requirement: Portable and attributable edition

The publication SHALL identify its title, author 衡阳, version, edition and language in visible front matter, and its title, author, date and language in PDF metadata. The version SHALL be the one in `VERSION`. Portable inputs MUST NOT depend on private stores or host-specific receipt paths.

#### Scenario: Reader opens the PDF

- **WHEN** the PDF is rebuilt through the declared entrypoint
- **THEN** its author and editorial date agree with the visible attribution, its cover shows the version in `VERSION`, and its references distinguish cases, recommendations and synthetic exercises.

### Requirement: Edition identity from the release tag

A build SHALL be that version's edition only when its source is the commit that the signed tag `v<VERSION>` names and no tracked file differs from it, and its date SHALL then be the tag's date. Every other build SHALL be a draft of the version that names its commit and says when tracked files differ from it. No date SHALL be written by hand.

#### Scenario: A build that is not the tagged commit

- **WHEN** the PDF is built from a commit that the tag `v<VERSION>` does not name, or with tracked changes
- **THEN** its cover and its reader notes call it a draft of the version and name the commit, and its cover shows no edition date.

#### Scenario: A build of the tagged commit

- **WHEN** the PDF is built from a clean checkout of the commit that the signed tag `v<VERSION>` names
- **THEN** its cover and its reader notes call it that version's edition with the tag's date, and its PDF metadata carries that date.

### Requirement: Edition facts declared once

The edition SHALL declare once the names its archive gives the folder, the PDF, the practice pack, the reader notes and the checksum list, where the book says the pack lies, the companion appendix's title, the tools the pack's checks need and the command that runs them. The book, both reader notes, the archive and its checks SHALL take them from there.

#### Scenario: A declared name changes

- **WHEN** the declaration renames the pack's folder or changes the check command
- **THEN** the printed commands, the prose, both reader notes, the archive's layout and the archive's check carry the new value without another edit.

#### Scenario: A printed block keeps a token

- **WHEN** a printed code block still carries a token meant to be filled from the declaration
- **THEN** a check fails and names the page.
