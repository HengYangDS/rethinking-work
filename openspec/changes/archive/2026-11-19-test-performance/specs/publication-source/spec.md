## ADDED Requirements

### Requirement: Bounded verification time

The publication checks SHALL lay out the book a fixed number of times per run, however many checks read it. Each document check SHALL spend less CPU time than half of one layout of the book measured in the same run, and a check that does not SHALL fail the run. Each test gate of the proof SHALL carry an absolute timeout taken from measured local and hosted durations, with that reason stated beside it.

#### Scenario: A check lays out the book again

- **WHEN** a check evaluates the book itself instead of reading the facts the run has already read
- **THEN** the check spends nearly one layout's CPU time, more than its budget of half a layout, and fails the run, however loaded or fast the host is.

#### Scenario: A test gate hangs

- **WHEN** a test gate runs past its declared timeout
- **THEN** the proof stops the gate and fails, and the timeout's stated reason names the measurements it came from.
