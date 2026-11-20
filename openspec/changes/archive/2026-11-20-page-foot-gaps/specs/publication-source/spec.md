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
