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

### Requirement: Direct prose with limits stated once

Chinese prose SHALL state what a thing is and does, once. A scope limit SHALL appear once where it applies, at the case or in the back matter, rather than after each passage. Prose SHALL NOT deny or exclude a meaning the text never gave, restate a point just made, or explain what is already plain.

#### Scenario: A case has a limited scope

- **WHEN** a demonstration or worked result holds only under stated conditions
- **THEN** those conditions appear once, where the result is used or in the back matter, and the chapter does not repeat them after each paragraph that uses the result.

#### Scenario: A judgement is described

- **WHEN** the book states what a judgement of work or of a member rests on
- **THEN** it names what the judgement rests on and nothing that the judgement does not judge.

#### Scenario: A run is cited

- **WHEN** a chapter rests a claim on a run
- **THEN** the chapter states the behaviour and its reasoning, and the run's conditions and versions stand once in the appendix it points to.
