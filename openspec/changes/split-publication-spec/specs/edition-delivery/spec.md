## Purpose

Release each version from a signed tag on `main` as one versioned archive, with its checksums and the names it declares once, which each peer builds from every event's exact commit; a build or a release does not by itself establish acceptance.

## ADDED Requirements

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

### Requirement: Independent publication build

Each publication peer SHALL build, in a macOS job of its own, the edition archive from the exact event commit and complete declared publication inputs, and keep it as a job artifact for as long as the same peer's verification job keeps its own.
It SHALL preserve project locks and exclude credentials, business data and
standalone restricted fonts from its outputs. A hosted success SHALL NOT
establish reader delivery or editorial approval.

#### Scenario: A clean macOS Runner builds the publication

- **WHEN** the exact event source, locked tools, declared fonts and complete official publisher packages are available
- **THEN** the native build regenerates the figures, produces the PDF and the edition archive, records input and artifact identities, and fails on missing or changed required inputs or project-lock drift.

#### Scenario: The practice archive is read outside the source checkout

- **WHEN** a reader safely extracts the archive in an environment with the declared exercise tools
- **THEN** the selected tracked teaching files keep their complete bytes, both reader notes state the version in `VERSION`, every file matches the archive's SHA-256 list, the exercises' own checks run and pass, and no installation, business-data access or service startup is performed.

#### Scenario: A package imports another package

- **WHEN** a declared Typst package imports a package of its own
- **THEN** the package supply lists that package too, and a compile whose cache holds only the declared packages fetches nothing and writes nothing to standard error.

### Requirement: One versioned edition archive

An edition SHALL be delivered as one archive holding one folder with a reader note, the PDF named with its version, the exercises with their own reader note, and a SHA-256 list of every other file in the folder. Both reader notes SHALL state the version in `VERSION` and SHALL be generated from it, not written by hand.

#### Scenario: A reader unpacks a downloaded edition

- **WHEN** a reader unpacks the archive on macOS or Linux
- **THEN** the folder's names read correctly, the PDF's name and cover and both reader notes state the same version as the tag, and every file matches the folder's SHA-256 list.

### Requirement: Edition facts declared once

The edition SHALL declare once the names its archive gives the folder, the PDF, the practice pack, the reader notes and the checksum list, where the book says the pack lies, the companion appendix's title, the tools the pack's checks need and the command that runs them. The book, both reader notes, the archive and its checks SHALL take them from there.

#### Scenario: A declared name changes

- **WHEN** the declaration renames the pack's folder or changes the check command
- **THEN** the printed commands, the prose, both reader notes, the archive's layout and the archive's check carry the new value without another edit.

#### Scenario: A printed block keeps a token

- **WHEN** a printed code block still carries a token meant to be filled from the declaration
- **THEN** a check fails and names the page.
