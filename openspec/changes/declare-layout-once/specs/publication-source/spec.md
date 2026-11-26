## ADDED Requirements

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
