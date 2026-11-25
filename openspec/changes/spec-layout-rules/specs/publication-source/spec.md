## ADDED Requirements

### Requirement: Layout rules declared once

The layout SHALL declare once, and the checks SHALL hold: horizontal alignment by kind of element, the text block's
width as a declared number of characters a line, curly quotation marks set in full character cells, and a lead-in that
ends with a colon kept on the page of the block it introduces and spaced as a paragraph.

#### Scenario: A table is set

- **WHEN** a table is laid out
- **THEN** its first column and text columns are flush left, a column of numbers is flush right on its units digit with its heading over it, and nothing in it is centred.

#### Scenario: A body line is full

- **WHEN** a body line runs the full measure
- **THEN** it holds the declared number of Chinese characters, and a curly quotation mark in it takes a full cell, two marks side by side one and a half.

#### Scenario: A lead-in falls at a page foot

- **WHEN** a paragraph ending with a colon would end a page
- **THEN** it moves with the block it introduces, and stands a paragraph step from the text before it.

## REMOVED Requirements

### Requirement: Meaning-preserving migration

**Reason**: The migration it governed (2026-11-13) and the rebuild that replaced the migrated manuscript (2026-11-16)
are finished; no Change refers to it.

**Migration**: A case the book keeps states its date, source role and limit once, as "Direct prose with limits stated
once" requires; earlier editions stay recoverable from Git and their published releases.
