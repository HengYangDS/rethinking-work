## MODIFIED Requirements

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
- **THEN** appendix A is the one index of the exercises, and the pack holds no second copy of an exercise or its answer.

#### Scenario: A chapter joins a part

- **WHEN** a chapter is added to a part or moved between parts
- **THEN** only the parts declared in `book/manuscript.typ` change, and the chapter heads, the contents and the checks follow them.
