## MODIFIED Requirements

### Requirement: Independent publication build

Each publication peer SHALL build, in a macOS job of its own, the edition archive from the exact event commit and complete declared publication inputs, and keep it as a job artifact for 14 days.
It SHALL preserve project locks and exclude credentials, business data and
standalone restricted fonts from its outputs. A hosted success SHALL NOT
establish reader delivery or editorial approval.

#### Scenario: A clean macOS Runner builds the publication

- **WHEN** the exact event source, locked tools, declared fonts and complete official publisher packages are available
- **THEN** the native build regenerates the figures, produces the PDF and the edition archive, records input and artifact identities, and fails on missing or changed required inputs or project-lock drift.

#### Scenario: The practice archive is read outside the source checkout

- **WHEN** a reader safely extracts the archive in an environment with the declared exercise tools
- **THEN** the selected tracked teaching files keep their complete bytes, both reader notes state the version in `VERSION`, every file matches the archive's SHA-256 list, the exercises' own checks run and pass, and no installation, business-data access or service startup is performed.

#### Scenario: A package imports another package

- **WHEN** a declared Typst package imports a package of its own
- **THEN** the package supply lists that package too, and a compile whose cache holds only the declared packages fetches nothing and writes nothing to standard error.
