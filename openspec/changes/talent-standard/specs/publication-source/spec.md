## ADDED Requirements

### Requirement: Talent judged by a stated standard

The manuscript SHALL state how a piece of work and a member's performance are judged: a work score for one piece, a tier for one period at the member's own grade, and the professional sequence of grades, joined by one chain of evidence. It SHALL state them in its own words, derived from the department's guidelines, so that a reader without those guidelines can apply them.

#### Scenario: A reader judges a period

- **WHEN** a reader applies the chapter to a member's period of work
- **THEN** they can name the evidence each tier needs, read the tier against the member's own grade, and record it with its period, scope and records.

#### Scenario: The guidelines change

- **WHEN** the department's guidelines revise a grade, a tier or the procedure
- **THEN** a later Change brings the chapter into agreement, and the book defines no standard of its own beside them.

### Requirement: Edition within its page ceiling

The built PDF SHALL hold no more pages than the ceiling that the layout declares.

#### Scenario: A change makes the book longer

- **WHEN** a change makes the PDF exceed the declared ceiling
- **THEN** a check fails and names the page count and the ceiling, and room is made by removing a second statement of something the book says once elsewhere, not by removing substance.
