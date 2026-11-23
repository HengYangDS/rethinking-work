## ADDED Requirements

### Requirement: Book prose keeps its decided wording

The book's sources SHALL use none of the words that the book-wide decisions replaced or avoid, and SHALL set full-width punctuation against Chinese characters where GB/T 15834 decides it. The rules SHALL be held in one declared style, each with its source, date and cases that show it alerting and passing, and a proof gate SHALL run the cases and the rules on every change.

#### Scenario: A replaced word comes back

- **WHEN** a change brings a replaced or avoided word, or half-width punctuation against a Chinese character, into the book's prose
- **THEN** the gate fails and names the file, the line and the decided form.

#### Scenario: A quotation keeps a speaker's words

- **WHEN** the book quotes a speaker whose own words a rule would flag
- **THEN** the quotation stands where the declared style skips a speaker's words, and the prose around it is still read.

#### Scenario: A decision depends on sense

- **WHEN** a decision cannot be told from the words alone
- **THEN** it is left to the reader, and the rules do not claim it.
