## MODIFIED Requirements

### Requirement: Typeset output keeps to its declared supply

The PDF SHALL embed only the fonts that the layout declares, SHALL compile without warnings, SHALL end no wrapped line of a body paragraph, a table cell or a sample box with a single character alone, SHALL leave on each page of a table or sample box that continues on the next page at least the least part the layout declares, and SHALL open the space between two Chinese characters of a justified body line by no more than the bound the layout declares.

#### Scenario: A glyph is missing from the declared fonts

- **WHEN** a printed character has no glyph in the fonts its text names
- **THEN** a check fails and names the font that was embedded in its place.

#### Scenario: A change leaves a character alone on a line

- **WHEN** a change makes a body paragraph, a table cell or a sample box wrap with a single character on its last line
- **THEN** a check fails and names the page.

#### Scenario: A block splits with too little on one page

- **WHEN** a table or sample box continues on the next page and one of its two parts is shorter than the least part the layout declares
- **THEN** a check fails and names the page and the part's height.

#### Scenario: A justified line reads as letter-spaced

- **WHEN** a Latin word, a time or a command too long for the rest of a body line makes justification open the line's Chinese characters past the declared bound
- **THEN** a check fails and names the page and the line.
