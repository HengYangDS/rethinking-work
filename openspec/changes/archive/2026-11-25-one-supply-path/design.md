## Context

See [proposal.md](proposal.md).

## Goals / Non-Goals

**Goals:**

- One supply path for every job; each fact of the supply in one manifest; documents that state the current contract.

**Non-Goals:**

- A second-machine or offline build. The replay qualified a closure of 2026-11-10 that no longer exists; a new one would
  need its own decision.

## Decisions

- The hosted publication job no longer isolates fonts in its workspace; like the GitLab job, it finds Songti SC, Charter
  and the Noto faces that `ci-supply` installs. The font test holds every build to the declared faces.
- The checkout and Mise action pins repeat the verification model's; the model does not expose them to the repository.
- The Noto faces keep their checksums, in their own manifest, because `ci-supply` checks them.

## Risks / Trade-offs

- The hosted publication job's first run on the new shape is its acceptance; it runs when the lane is pushed.
