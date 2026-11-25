## Context

See [proposal.md](proposal.md). The ETHOS console is installed from the `http:ethos` platform table; `mise.lock` holds no
Windows entry here.

## Goals / Non-Goals

**Goals:**

- No Windows in the supply, the CI or the reader's promise.
- The three remote arrangements stated and checked: local-only, one remote, two remotes.

**Non-Goals:**

- Removing Linux, which the owner kept.

## Decisions

- Remove the rows, not the table: macOS and Linux keep their pins.
- Local-only, one remote and two remotes, read from the current files: the build, the tests and the full proof run
  with no remote (`publication/justfile`, `ethos prove --full`); the remotes are the peers declared in
  `.ethos/release.toml`, each with its own CI surface, and ETHOS publishes to the declared peers and passes hosted
  observation when none is declared, so dropping a peer is dropping its entry and its section of
  `.config/ci/verification.toml`; where both exist their CI is generated from that one declaration, the same
  verification command and the same publication build on each, which is the mirror the owner asked for.

## Risks / Trade-offs

- A Windows reader can still open the PDF; only the archive's promise and the supply change.
