## ADDED Requirements

### Requirement: Printed commands survive copying

Copying a printed command from the PDF SHALL give the text that the source prints: every line of a code block with a declared language prints whole on one line, and an inline command prints whole.

#### Scenario: A reader copies a command from the PDF

- **WHEN** a reader copies a line of a code block with a declared language, or an inline command, from the PDF
- **THEN** the copy holds the line as printed, with no line break inside it.

#### Scenario: A printed line grows wider than its block

- **WHEN** a change makes a line of a code block with a declared language too wide to print on one line
- **THEN** a check fails and names the page.
