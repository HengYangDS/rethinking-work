## MODIFIED Requirements

### Requirement: Layout rules declared once

The layout SHALL declare once, and the checks SHALL hold: horizontal alignment by kind of element, the text block's
width as a declared number of characters a line, curly quotation marks set in full character cells, and a lead-in that
ends with a colon kept on the page of the block it introduces and spaced as a paragraph. The layout SHALL also declare
once the Typst packages and their versions, the type sizes by role, the paper and its margins, the language, the
faces and sizes of the cover and the contents, and the marks and patterns the checks apply; the manuscript, the
figures, the colophon, the guides and the checks SHALL read them rather than restate them.

#### Scenario: A table is set

- **WHEN** a table is laid out
- **THEN** its first column and text columns are flush left, a column of numbers is flush right on its units digit with its heading over it, and nothing in it is centred.

#### Scenario: A body line is full

- **WHEN** a body line runs the full measure
- **THEN** it holds the declared number of Chinese characters, and a curly quotation mark in it takes a full cell, two marks side by side one and a half.

#### Scenario: A lead-in falls at a page foot

- **WHEN** a paragraph ending with a colon would end a page
- **THEN** it moves with the block it introduces, and stands a paragraph step from the text before it.

#### Scenario: A package or a size changes

- **WHEN** the layout declares another version of a Typst package, another type size for a role or another paper
- **THEN** the entrypoint, the figures, the cover, the contents and the colophon follow without another edit, and a check fails when the compile reads a package file that the supply manifest does not pin.

#### Scenario: A check applies a layout rule

- **WHEN** a check needs the marks that never open a line, the pattern of a number cell or the language
- **THEN** it reads them from the layout, and a check that guards against finding nothing requires that something be found rather than a fixed count.
