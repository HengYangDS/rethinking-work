## MODIFIED Requirements

### Requirement: Behaviour claims grounded in runs

A statement about what a tool, a host or an Agent does SHALL rest on a run recorded on the stated version, on a primary source, or on reasoning presented as reasoning. A claim about an Agent's tendency SHALL state the conditions and the number of runs where the result is used, once.

#### Scenario: A tendency is stated

- **WHEN** a chapter states that an Agent tends to do something
- **THEN** a recorded experiment with stated model, host, conditions and number of runs supports it, or the chapter derives it from how the model works and says so, or the statement is removed.

#### Scenario: A tool changes after the edition

- **WHEN** a later version of a named tool changes a command or an output printed in the manuscript
- **THEN** the back matter's version for that tool identifies which version the printed command and output belong to, and the next edition reruns the experiment before reprinting them.

#### Scenario: A risk the runs did not show

- **WHEN** a chapter states a risk that its own runs did not exercise
- **THEN** it says what those runs showed and that the risk was not tested.
