## Why

One specification, `publication-source`, holds all 32 requirements of the repository: the book's argument, its
Chinese, the manuscript's structure, the layout, the reader's exercises, the edition's identity and delivery, source
verification and editorial acceptance. A change to one theme is read and reviewed against all of them, and a
requirement's home says nothing about what it governs. The owner approved on 2026-11-26 splitting it by theme into
nine capabilities, moving each requirement's text verbatim and changing only the one title that does not describe its
requirement.

## What Changes

- Nine capabilities each take the requirements of one theme, word for word with their scenarios: `book-argument`,
  `chinese-prose`, `manuscript-structure`, `layout`, `reader-exercises`, `edition-identity`, `edition-delivery`,
  `source-verification` and `editorial-acceptance`. Each states its purpose.
- "Typeset output keeps to its declared supply" becomes "Typeset output without typographic faults": the requirement
  holds five typographic obligations, of which the old title names the first. An earlier Change left this rename for
  a later one.
- `publication-source` is retired once it holds no requirement.
- The guides that link to the one specification link to the specifications' folder.

No obligation, scenario or check changes. **BREAKING** for links and Changes outside this one: the name
`publication-source` and the path `openspec/specs/publication-source/spec.md` go away. Splitting a requirement that
spans two themes is out of scope.

## Capabilities

### New Capabilities

- `book-argument`, `chinese-prose`, `manuscript-structure`, `layout`, `reader-exercises`, `edition-identity`,
  `edition-delivery`, `source-verification`, `editorial-acceptance`: the requirements of `publication-source`, by theme.

### Modified Capabilities

- `publication-source`: every requirement moves to the capability of its theme, and the capability is retired.

## Impact

`openspec/specs/`, `README.md`, `docs/publication-acceptance.md`. Archived Changes keep their own references to
`publication-source`.
