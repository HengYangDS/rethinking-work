## Context

See [proposal.md](proposal.md). A PDF viewer copies a visual line break as a newline. A wrapped shell line therefore
splits a command, a wrapped quoted string changes its content, and a wrapped JSON string becomes invalid.

## Goals / Non-Goals

**Goals:**

- Every line of a code block with a declared language, and every inline command, survives copying.
- The behaviour of each printed command and the output printed after it stay unchanged, so no experiment is rerun.

**Non-Goals:**

- Output blocks without a language, and long quotations of output or prompts set inline: copying them runs nothing.
- Fonts and other page findings deferred to the quality-gate work.

## Decisions

- Rewrites keep behaviour by construction: a long single-quoted argument is assembled from shorter quoted parts or
  a variable, so the argument a program receives is byte for byte the same; a redirection moves after a line
  continuation; JSON changes only in whitespace; Python statements move from `;` to new lines only inside the
  hooks' scripts, whose output nothing prints; jq reads `.compactMetadata` once and interpolates the same fields.
- The box limit counts display width (a Chinese character as two), which is what decides whether a span fits.
- The test reads the edition's own layout: a line counts as whole when it appears on one line of its page, or of the
  next page for a block that continues there. It holds no width of its own.

## Risks / Trade-offs

- [Assembled strings read less plainly than one long line] → Used only where the argument must stay identical to
  the run record; elsewhere the line breaks at a natural boundary.
- [Pages after the first change move] → The pages are rebuilt and the moved pages are looked at.
