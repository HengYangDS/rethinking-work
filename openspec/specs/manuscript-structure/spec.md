# manuscript-structure Specification

## Purpose

Give each kind of publication input one editable owner, keep reproducible generated output out of tracked source, and derive the book's parts, numbering and references from the one declared reading order.

## Requirements

### Requirement: Cohesive publication inputs

The publication SHALL maintain one editable owner for manuscript meaning, edition identity, presentation, diagram sources, synthetic exercises and reader references. Reproducible generated output SHALL stay outside tracked source.

#### Scenario: Editor follows a figure

- **WHEN** an editor selects a figure in the manuscript
- **THEN** its editable source is discoverable, and the figure is drawn from it in the same compile as the book, with the book's fonts and the layout's colours, without a browser.

#### Scenario: A figure is set in the column

- **WHEN** the book is built
- **THEN** each figure and its caption stand centred in the text column, and a check fails and names the figure that does not.

#### Scenario: A reader starts the exercises

- **WHEN** a reader opens the practice pack
- **THEN** the companion appendix is the one index of the exercises, and the pack holds no second copy of an exercise or its answer.

#### Scenario: A chapter joins a part

- **WHEN** a chapter is added to a part or moved between parts
- **THEN** only the parts declared in `book/manuscript.typ` change, and the chapter heads, the contents and the checks follow them.

### Requirement: Chapter references are derived

The manuscript SHALL take each chapter's, practice's and appendix's number, counted within its kind, and each part's number from the reading order that `book/manuscript.typ` declares, SHALL derive every reference to a chapter, a practice, an appendix or a part by its number from that order, and SHALL point each relative reference, 上一章 or 下一章, 上一部 or 下一部, at the chapter or part just before or after the one it stands in.

#### Scenario: A chapter is renumbered

- **WHEN** a chapter or a part is inserted, removed or moved in the reading order
- **THEN** every number and every reference by number reads the new order without an edit at the chapter, the part or the reference.

#### Scenario: A reference is written by hand

- **WHEN** a change writes 「第X章」 or 「第X部」 in the manuscript's prose
- **THEN** a check fails and names the file and the line.

#### Scenario: A relative reference points elsewhere

- **WHEN** 上一章 or 下一章 names a chapter that is not adjacent in the reading order, or names none
- **THEN** a check fails and names the file, the reference and the chapter it should name.

#### Scenario: A relative part reference points elsewhere

- **WHEN** 上一部 or 下一部 names a part that is not adjacent in the reading order, or names none
- **THEN** the build or a check fails and names the reference.
