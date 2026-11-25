## MODIFIED Requirements

### Requirement: One versioned edition archive

An edition SHALL be delivered as one archive holding one folder with a reader note, the PDF named with its version, the exercises with their own reader note, and a SHA-256 list of every other file in the folder. Both reader notes SHALL state the version in `VERSION` and SHALL be generated from it, not written by hand.

#### Scenario: A reader unpacks a downloaded edition

- **WHEN** a reader unpacks the archive on macOS or Linux
- **THEN** the folder's names read correctly, the PDF's name and cover and both reader notes state the same version as the tag, and every file matches the folder's SHA-256 list.
