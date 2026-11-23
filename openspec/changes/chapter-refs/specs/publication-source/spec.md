## ADDED Requirements

### Requirement: Chapter references are derived

The manuscript SHALL derive every reference to a chapter, a practice or an appendix by its number from the number that the chapter's opening declares, and SHALL point each relative reference, 上一章 or 下一章, at the chapter just before or after the one it stands in, in the manuscript's reading order.

#### Scenario: A chapter is renumbered

- **WHEN** a chapter is inserted, removed or moved and the openings' numbers change
- **THEN** every reference by number reads the new number without an edit at the reference.

#### Scenario: A reference is written by hand

- **WHEN** a change writes 「第X章」 in the manuscript's prose
- **THEN** a check fails and names the file and the line.

#### Scenario: A relative reference points elsewhere

- **WHEN** 上一章 or 下一章 links a chapter that is not adjacent in the reading order
- **THEN** a check fails and names the file, the word and the expected chapter.
