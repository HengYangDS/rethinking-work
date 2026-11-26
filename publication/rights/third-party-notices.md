# Third-party notices

This publication imports Neat Book and, for its figures, fletcher, from Typst
Universe at the versions that [packages.typ](../layout/packages.typ) declares,
without copying or patching their source. The author of this manuscript is
separate from the package authors.
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

The [complete attributed publisher notice](neat-book-notice.md) is retained
verbatim in its own document.

## Figure packages

The figures are drawn with fletcher, imported by version from Typst Universe;
fletcher imports CeTZ, and CeTZ imports oxifmt. None of these packages' source
is copied into this repository, and each keeps its own license, which the
repository's MIT License does not replace. Each complete package tree, its
`LICENSE` files included, is bound by
[typst-packages.sha256](../supply/typst-packages.sha256).

| Package             | License           | Source                                         |
| ------------------- | ----------------- | ---------------------------------------------- |
| fletcher            | MIT               | <https://github.com/fletcher-package/fletcher> |
| CeTZ (via fletcher) | LGPL-3.0-or-later | <https://github.com/cetz-package/cetz>         |
| oxifmt (via CeTZ)   | MIT OR Apache-2.0 | <https://github.com/PgBiel/typst-oxifmt>       |

## Authored publication and local executors

The authored manuscript, diagrams and teaching fixtures are licensed under the
repository's [MIT License](../../LICENSE), copyright (c) 2026 衡阳. This grant does
not replace third-party licenses. The publisher notice above describes Neat
Book's own examples and font choices; this publication's font supply is
described below.

Typst, Just, Prettier and Python remain separately installed tools, not
vendored source. Preserve their licenses and any required notices if a later
authorized distribution includes their code.
Their dependency audit is not a claim that every produced PDF or input is safe.

## Authored publication fonts

No standalone font binaries are included in this repository's source. The
delivered PDF embeds its used font faces, which is distinct from distributing
the original font files. Source-code licenses do not relicense those fonts.

| Font supply           | Source and terms                                                                                                                                                                                                                                                                                                                                              |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Noto Sans CJK SC      | The official [Noto CJK Sans release](https://github.com/notofonts/noto-cjk/releases) whose archive [noto.url](../supply/noto.url) names, under [SIL OFL 1.1](https://github.com/notofonts/noto-cjk/blob/main/Sans/LICENSE).                                                                                                                                   |
| DejaVu Sans Mono      | Embedded in [typst-assets](https://github.com/typst/typst-assets), the fonts built into the Typst that [config.toml](../../.config/mise/config.toml) declares; the [font notices](https://dejavu-fonts.github.io/License.html) cover Bitstream Vera, public-domain DejaVu changes and imported Arev glyphs. Typst's Apache-2.0 license does not replace them. |
| Libertinus Serif      | Embedded in the same typst-assets; under [SIL OFL 1.1](https://github.com/alerque/libertinus/blob/master/OFL.txt). The delivered PDF uses it for one symbol in a printed output.                                                                                                                                                                              |
| Songti SC and Charter | Existing Apple system fonts, subject to the applicable Apple Software License Agreement and individual font restrictions.                                                                                                                                                                                                                                     |
| Apple Color Emoji     | Existing Apple system font; the delivered PDF uses it for the memory-attribution emoji. The same Apple and individual-font qualifications apply.                                                                                                                                                                                                              |

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
