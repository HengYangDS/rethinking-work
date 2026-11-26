## Purpose

Set the book from one declared layout, so that its pages, blocks, lines and fonts keep to stated typographic rules within the declared page ceiling.

## ADDED Requirements

### Requirement: Page feet without false endings

The layout SHALL keep what is read as one piece on one page only while it is short. A table or a sample box no taller than six body lines, and a code block of at most six lines, SHALL move to the next page whole; a taller one SHALL continue there, a continued table repeating its header. A section heading SHALL have room for three body lines under it on its page. A page that the manuscript ends on purpose SHALL be declared as such.

#### Scenario: A tall table meets the foot of a page

- **WHEN** a table or a sample box taller than six body lines does not fit in the space left on a page
- **THEN** it begins on that page and continues on the next; a table repeats its header there and keeps each row whole.

#### Scenario: A short block does not fit

- **WHEN** a table or a sample box no taller than six body lines does not fit in the space left on a page
- **THEN** it moves to the next page whole, and the page it leaves is short by no more than a block of that height and one paragraph step.

#### Scenario: An exercise asks the reader to answer before turning the page

- **WHEN** the manuscript ends a page on purpose
- **THEN** it declares the page turn through the layout's function, and the check of page feet leaves that page out.

#### Scenario: A rule keeps a tall block whole again

- **WHEN** a change makes a table or a sample box of any height move to the next page whole
- **THEN** a check fails on a page left emptier than a whole block allows before such a block, and names the page.

### Requirement: Typeset output without typographic faults

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

#### Scenario: The layout's measure changes

- **WHEN** the layout declares a different type size or baseline
- **THEN** the spacing checks follow the declaration without a change of their own.

### Requirement: Edition within its page ceiling

The built PDF SHALL hold no more pages than the ceiling that the layout declares.

#### Scenario: A change makes the book longer

- **WHEN** a change makes the PDF exceed the declared ceiling
- **THEN** a check fails and names the page count and the ceiling, and room is made by removing a second statement of something the book says once elsewhere, not by removing substance.

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

### Requirement: Presentation facts declared once

The layout SHALL declare once the Typst packages and their versions, the type sizes by role, the paper and its margins,
the language, the faces and sizes of the cover and the contents, and the marks and patterns the checks apply. The
manuscript, the figures, the colophon, the guides and the checks SHALL read them rather than restate them.

#### Scenario: A package or a size changes

- **WHEN** the layout declares another version of a Typst package, another type size for a role or another paper that holds the text block
- **THEN** the entrypoint, the figures, the cover, the contents and the colophon follow without another edit, and a check fails when the compile reads a package file that the supply manifest does not pin.

#### Scenario: A check applies a layout rule

- **WHEN** a check needs the marks that never open a line, the pattern of a number cell or the language
- **THEN** it reads them from the layout, and a check that guards against finding too little derives what it must find from other facts of the edition rather than from a fixed count.
