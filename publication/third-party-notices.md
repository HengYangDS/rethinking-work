# Third-party notices

This publication imports `@preview/neat-book:0.1.0` without copying or patching
its source. The author of this manuscript is separate from the package authors.
Neither package use nor a reference implies an endorsement.

## Neat Book

Source: <https://github.com/xiong-ZH-zq/neat-book>.
The complete publisher license follows:

MIT License

Copyright (c) 2026 xzqbear

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Publisher dependency and asset notices

The following is the complete notice supplied with Neat Book 0.1.0, retained
as attributed publisher material. Statements about its example book describe
the publisher's examples, not an assertion that this manuscript uses every
listed icon or asset.

# Neat Book publisher notice

Checked on 2026-10-20 for Neat Book 0.1.0.

## Original project material

The Neat Book source, example prose, example pseudocode and implementations, and
`template/assets/logo.svg` were prepared for this project. The cover logo is an
original geometric drawing of an open book, not an institution's logo.
`thumbnail.png` is rendered from this project's own cover. These project files
are covered by the root MIT license.

ElegantBook is a visual reference, not a source-code dependency. No ElegantBook
source files, cover artwork, example pages, or book excerpts are distributed.
The mathematical statements are standard facts; example exposition was written
for this project. `template/references.bib` contains bibliographic metadata,
not excerpts from the referenced books.

## Imported Typst dependencies

Dependencies are imported by version from Typst Universe. Their source files and
icon collections are not vendored into this repository or its release archive.
Each dependency keeps its own license; Neat Book's MIT license does not relicense
third-party code, artwork, or trademarks.

| Dependency                    | License                                              | Source                                                                 |
| ----------------------------- | ---------------------------------------------------- | ---------------------------------------------------------------------- |
| theorion 0.6.0                | MIT                                                  | <https://github.com/OrangeX4/typst-theorion>                           |
| algorithmic 1.0.7             | MIT                                                  | <https://github.com/typst-community/typst-algorithmic>                 |
| codly 2.0.0                   | MIT                                                  | <https://github.com/Dherse/codly>                                      |
| codly-languages 0.1.10        | MIT code; individual artwork may have separate terms | <https://github.com/swaits/typst-collection/tree/main/codly-languages> |
| elembic 1.1.1 (via Codly)     | MIT OR Apache-2.0                                    | <https://github.com/PgBiel/elembic>                                    |
| showybox 2.0.4 (via Theorion) | MIT                                                  | <https://github.com/Pablo-Gonzalez-Calderon/showybox-package>          |
| octique 0.1.1 (via Theorion)  | MIT                                                  | <https://github.com/0x6b/typst-octique>                                |

## Language icons in the example book

The example book uses only Python and Rust language icons. They identify the
language of the code; they do not brand or endorse Neat Book.

- **Python:** supplied by codly-languages from Devicon. Devicon is MIT licensed,
  copyright (c) 2015 konpa. Source: <https://github.com/devicons/devicon>.
  License: <https://github.com/devicons/devicon/blob/master/LICENSE>.
  Python and its two-snakes logo are trademarks of the Python Software Foundation.
  See <https://www.python.org/community/logos/> and
  <https://www.python.org/psf/trademarks/>. Neat Book does not alter the supplied
  vector artwork, apart from uniform scaling for the code badge.
- **Rust:** supplied by codly-languages from vscode-icons. vscode-icons is MIT
  licensed, copyright The vscode-icons Contributors. Source:
  <https://github.com/vscode-icons/vscode-icons>.
  License: <https://github.com/vscode-icons/vscode-icons/blob/master/LICENSE>.
  The Rust logo is owned by the Rust Foundation; its artwork is also available
  under CC BY 4.0, <https://creativecommons.org/licenses/by/4.0/>.
  Source and trademark policy: <https://rustfoundation.org/policy/rust-trademark-policy/>.
  The upstream vscode-icons version uses colored gradient styling; Neat Book
  makes no further artwork changes, apart from uniform scaling for the badge.

Neat Book is not affiliated with or endorsed by the Python Software Foundation,
the Rust Foundation, or the Rust Project.

Other language icons selected by a user retain their own upstream terms.
The codly-languages README records additional exceptions, including jq, Lean,
strace, BibTeX, and Typst. The MIT license for its configuration code must not be
read as a blanket license for every depicted brand or icon. If distributing a
standalone PDF with third-party icons, retain the relevant credits with the
distribution. Icons can be disabled with a scoped
`#show: codly.lang-set_(display-icon: false)` rule.

## Fonts

No font binaries are included in the repository or submission archive.
The web editor provides the default families; local users install the CJK
families themselves. Font licenses remain independent of the source license.

- Libertinus: SIL Open Font License 1.1,
  <https://github.com/alerque/libertinus/blob/master/OFL.txt>.
- Noto CJK: SIL Open Font License 1.1,
  <https://github.com/notofonts/noto-cjk/blob/main/Serif/LICENSE> and
  <https://github.com/notofonts/noto-cjk/blob/main/Sans/LICENSE>.
- DejaVu Sans Mono: Bitstream Vera font license, with DejaVu changes in the public
  domain, <https://dejavu-fonts.github.io/License.html>.
- New Computer Modern Math: GUST Font License,
  <https://ctan.org/pkg/newcomputermodern>.

## MIT dependency acknowledgments

These acknowledgments supplement the notices shipped by the dependencies:

- Copyright (c) 2025 OrangeX4 (Theorion).
- Copyright (c) 2023 Jade Lovelace; 2025 Pascal Quach; 2025 Typst Community;
  2025 Contributors to the typst-algorithmic project.
- Copyright (c) 2023 Sébastien d'Herbais de Thun, et al. (Codly).
- Copyright (c) 2025 Stephen Waits (codly-languages).
- Copyright (c) 2024 PgBiel (Elembic, MIT option).
- Copyright (c) 2023–2024 Pablo González Calderón and Showybox Contributors.
- Copyright (c) 2023 0x6b (Octique).
- Copyright (c) 2015 konpa (Devicon).
- Copyright The vscode-icons Contributors.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Authored publication and local executors

No public license has been granted for the authored manuscript, diagrams or
teaching fixtures by this notice. The publisher notice above describes Neat
Book's own examples and font choices; the authored publication's font supply
is described below.

Typst, Mermaid CLI, Just, Prettier, Python and the selected browser remain
separately installed tools, not vendored source. Preserve their licenses and
any required notices if a later authorized distribution includes their code.
Their dependency audit is not a claim that every produced PDF or input is safe.

## Authored publication fonts

No standalone font binaries are included in this repository's source. The
delivered PDF embeds its used font faces, which is distinct from distributing
the original font files. Source-code licenses do not relicense those fonts.

| Font supply            | Source and terms                                                                                                                                                                                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Noto Sans CJK SC 2.004 | Official [Noto CJK Sans release](https://github.com/notofonts/noto-cjk/releases/tag/Sans2.004), under [SIL OFL 1.1](https://github.com/notofonts/noto-cjk/blob/main/Sans/LICENSE).                                                                                                                                             |
| DejaVu Sans Mono 2.37  | Embedded in Typst 0.15.1's [typst-assets](https://github.com/typst/typst-assets/tree/ab9eed7b046c6a29f6cdb8566f4b44fb46a2f57f); the [font notices](https://dejavu-fonts.github.io/License.html) cover Bitstream Vera, public-domain DejaVu changes and imported Arev glyphs. Typst's Apache-2.0 license does not replace them. |
| Songti SC and Charter  | Existing Apple system fonts, subject to the applicable Apple Software License Agreement and individual font restrictions.                                                                                                                                                                                                      |
| Apple Color Emoji      | Existing Apple system font; the delivered PDF uses it for the memory-attribution emoji. The same Apple and individual-font qualifications apply.                                                                                                                                                                               |

The inspected macOS license is available through the system's License document
under `/Library/Documentation/License.lpdf`. Section E, Fonts, permits display
and printing while running Apple Software and makes document embedding subject
to the individual font's restrictions. Section J does not grant blanket
standalone redistribution rights.

The inspected Songti SC Regular and Bold faces carry editable-embedding flags;
the inspected Charter and Apple Color Emoji faces carry preview-and-print
embedding flags. Songti SC Black carries a restricted-embedding flag and is not
used in the delivered PDF. These are technical observations of the selected
font faces, not legal advice or permission to redistribute Apple font files.
The [OpenType embedding flags reference](https://learn.microsoft.com/en-us/typography/opentype/spec/os2#fstype)
explains the flags; it does not replace the applicable license. A different font
file, use or distribution needs its own review.
