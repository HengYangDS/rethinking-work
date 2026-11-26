## ADDED Requirements

### Requirement: Repository Skills held to their packages

Every Skill under `.agents/skills/` SHALL be registered in its activation record with a package manifest whose
expected digest matches the files the manifest includes, and every proof SHALL run ETHOS's skill portfolio check and
fail when a Skill, its record or its package does not match.

#### Scenario: A Skill changes without its digest

- **WHEN** a commit changes a file that a Skill's package includes and leaves the package's expected digest as it was
- **THEN** the proof fails at the skills gate, naming the Skill

#### Scenario: A Skill without a record

- **WHEN** a folder under `.agents/skills/` holds a Skill that the activation record does not register
- **THEN** the proof fails at the skills gate, naming the folder
