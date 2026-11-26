# source-verification Specification

## Purpose

Verify every source change on both peers by one locked, bounded and reproducible proof whose toolchain and supply are each declared once.

## Requirements

### Requirement: Reproducible source verification

Both publication peers SHALL run the installed verification model of the owner's
repository family, generated from the repository's declarations. The job SHALL
verify the exact event commit by the repository's full proof with locked tools,
including formatting and all synthetic companion contracts, without business
data, services or credentials. Generated pipeline files SHALL match their
declarations. Hosted execution, full PDF qualification and editorial acceptance
SHALL remain distinct claims.

#### Scenario: A source change reaches the public peer

- **WHEN** a push or pull request triggers source CI
- **THEN** the job runs the full proof against that event's exact commit, and any failing gate, formatting defect or failing exercise makes the job fail.

#### Scenario: A pipeline declaration changes without its generated files

- **WHEN** a verification parameter, runner prerequisite or repository job changes and the native pipeline files are not regenerated
- **THEN** the projection check refuses the drift and names each file that differs.

#### Scenario: A peer lacks a suitable Runner

- **WHEN** the private peer has no authorized Runner for the locked platform
- **THEN** its job remains visibly pending, is not represented as passed, and does not prevent independent public-peer verification.

### Requirement: Bounded verification time

The publication checks SHALL lay out the book a fixed number of times per run, however many checks read it. Each document check SHALL spend less CPU time than half of one layout of the book measured in the same run, and a check that does not SHALL fail the run. Each test gate of the proof SHALL carry an absolute timeout taken from measured local and hosted durations, with that reason stated beside it.

#### Scenario: A check lays out the book again

- **WHEN** a check evaluates the book itself instead of reading the facts the run has already read
- **THEN** the check spends nearly one layout's CPU time, more than its budget of half a layout, and fails the run, however loaded or fast the host is.

#### Scenario: A test gate hangs

- **WHEN** a test gate runs past its declared timeout
- **THEN** the proof stops the gate and fails, and the timeout's stated reason names the measurements it came from.

### Requirement: Declared supply release age

The repository SHALL declare, in each resolver's own configuration, the minimum age a tool or package release must have before it enters the locked supply, and SHALL admit a newer version only when it is at least that old. The age SHALL NOT be restated as a number in a test or script.

#### Scenario: A locked tool is moved

- **WHEN** a locked tool or Python package is moved to a newer version
- **THEN** the resolver refuses a release younger than the declared age, the lock and the pipeline declarations with their generated files state the new version in the same commit, and contributor documents name those declarations instead of stating the version.

### Requirement: One test run per proof

The proof SHALL run the publication tests once per run, taking every test file that the local `test` task takes. That run's test and coverage reports SHALL be the proof's evidence for behavior, coverage and publication inputs alike.

#### Scenario: A full proof runs

- **WHEN** the repository's full proof runs
- **THEN** the publication tests run once, and the proof passes only if that run passes and leaves its coverage report.

#### Scenario: A contributor runs the tests locally

- **WHEN** a contributor runs the local test task
- **THEN** the tests run with the runner and configuration that the proof uses, without its reports.

#### Scenario: The governance asks for toolchain verbs

- **WHEN** the installed ETHOS release asks the repository for its toolchain verbs
- **THEN** the Mise configuration provides them, each calling the Just recipe that does the work.

### Requirement: Toolchain facts declared once

The Python line, each tool's release and download address, the CI supply sources and the build's output names SHALL each be declared once, in the configuration of the tool that installs or produces it. Every task, test, reader note, printed command and CI job that names one SHALL read that declaration; a tool that cannot read it MAY repeat it only in its own field, where it refuses a disagreement.

#### Scenario: The Python line changes

- **WHEN** the declared Python line changes together with `requires-python`
- **THEN** the test environment, the reader note, the back matter and the practice-pack test follow without another edit, and the command the reader note prints runs on that line.

#### Scenario: One declaration of the Python line changes alone

- **WHEN** the Mise configuration and `requires-python` name different lines
- **THEN** building the test environment fails.

#### Scenario: The verification model changes a job

- **WHEN** the installed verification model or `verification.toml` changes a verification job's supply, rules, time limit, variables or artifact lifetime
- **THEN** after projection each peer's publication jobs carry the same, and before it the projection check names the files that differ.

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

### Requirement: Repository Skills held to their packages

Every Skill under `.agents/skills/` that OpenSpec's own record does not own SHALL be registered in its activation
record with a package manifest whose expected digest matches the files the manifest lists, and every repository proof
SHALL run ETHOS's skill portfolio check and fail when a Skill, its record or its package does not match.

#### Scenario: A Skill changes without its digest

- **WHEN** a commit changes a file that a Skill's package lists and leaves the package's expected digest as it was
- **THEN** the repository proof fails at the skills gate, naming the Skill

#### Scenario: A Skill without a record

- **WHEN** a folder under `.agents/skills/` holds a Skill that the activation record does not register
- **THEN** the repository proof fails at the skills gate, naming the folder
