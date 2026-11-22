// Document-level style over the unchanged publisher package.
#import "@preview/neat-book:0.1.0": codly
#let ink = rgb("273B46")
#let teal = rgb("273B46")
#let muted = rgb("687B85")
#let rule = rgb("DCE3E8")
#let tint = rgb("F3F5F5")
#let rust = rgb("82979F")
#let body-size = 10.5pt
#let body-line = 16pt
#let body-edges = body-size
#let space = 4pt
// The space between paragraphs, which a block in the text also takes above and below it.
#let par-space = 2 * body-line - body-edges
// What is read as one piece stays on one page while it is short: a block of at most this many
// body lines moves to the next page whole, and a taller one continues there.
#let whole-lines = 6
#let whole-height = whole-lines * body-line
// The most a page is left short when such a block moves whole: the block and the step from the
// paragraph above it. Layout checks read the bound from here.
#let whole-allowance = whole-height + par-space + body-edges
// A section heading stays on a page while this many body lines fit under it.
#let heading-lines = 3
#let publication-design(body) = {
  set text(lang: "zh", region: "CN", top-edge: .8em, bottom-edge: -.2em)
  // Chinese inside commands and outputs takes the sans face, not the serif body face. A symbol that
  // neither face holds, such as ℹ, takes Typst's own Libertinus Serif, declared as a fallback here
  // rather than reached by accident.
  show raw: set text(font: ("DejaVu Sans Mono", "Noto Sans CJK SC", "Libertinus Serif"))
  // A paragraph does not end with a character alone on its last line: the line breaker weighs such
  // a runt heavily against the other breaks it can choose.
  set text(costs: (runt: 200%))
  set heading(numbering: none)
  show heading.where(level: 1): it => {
    block(above: 6 * space, below: 3 * space, sticky: true)[
      #text(font: "Noto Sans CJK SC", weight: "bold", size: 25pt, it.body)
      #v(2 * space)
      #line(length: 100%, stroke: .6pt + rule)
    ]
  }
  set figure(numbering: "1")
  set par(first-line-indent: 0pt, leading: body-line - body-edges, spacing: par-space)
  show heading.where(level: 2): set block(above: 6 * space, below: 2 * space)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 3): set block(above: 4 * space, below: 2 * space)
  show heading.where(level: 3): set text(size: 11pt)
  // A section heading starts the next page unless `heading-lines` body lines fit under it; the
  // reserved space is taken back afterwards, so spacing on the page is unchanged.
  show heading.where(level: 2).or(heading.where(level: 3)): it => {
    let reserve = heading-lines * body-line
    block(breakable: false, sticky: true, it + v(reserve))
    v(-reserve)
  }
  // A command is copied from one place, so a code block stays whole up to `whole-lines` lines;
  // a longer one may continue on the next page.
  show raw.where(block: true): it => {
    show: codly.set_(breakable: it.lines.len() > whole-lines)
    it
  }
  show table.cell.where(y: 0): set text(font: "Noto Sans CJK SC", weight: "bold", size: 9pt)
  show figure.caption: set text(size: 8.5pt, fill: muted)
  body
}
#let small(body) = text(size: 8.5pt, fill: muted, body)
// Sets a block whole when it is short and lets it continue on the next page when it is tall. Its
// height is measured in the width it will take. Its spacing, unless given, is the paragraph spacing
// in force where it is called. `mark` labels the block for layout checks.
#let flow-block(body, above: auto, below: auto, mark: none, ..args) = block(
  above: above, below: below, width: 100%,
  layout(size => {
    let whole = measure(width: size.width, block(..args, body)).height <= whole-height
    [#block(breakable: not whole, ..args, body)#mark]
  }),
)
// A page the manuscript ends on purpose, as when an exercise asks for an answer before the reader
// turns the page. The mark lets layout checks tell such a page from one left short.
#let page-turn() = [#metadata(none)<page-turn>#pagebreak(weak: true)]
#let pageref(loc) = context link(loc, text(fill: teal)[#counter(page).at(loc).first()])
#let case(identifier) = link(label("case-" + identifier), identifier)
#let contents-return() = link(<contents>, text(font: "Noto Sans CJK SC", size: 8pt, fill: muted)[返回目录 ↗])
#let chapter(part, n, title, lead) = {
  set heading(numbering: none)
  pagebreak(weak: true)
  heading(level: 1)[#title]
  block(above: 0pt, below: 2 * space, sticky: true)[
    #set par(first-line-indent: 0pt, leading: 5.5pt, spacing: 2 * space)
    #metadata((chapter: n))<chapter-navigation>
    #grid(columns: (1fr, auto),
      text(font: "Noto Sans CJK SC", size: 8pt, fill: muted)[#part / #n],
      contents-return(),
    )
    #parbreak()
    #text(size: 11pt, fill: teal)[#lead]
  ]
}
// Keep a chapter's closing lines with the paragraph before them, so that one
// or two lines are not stranded on a page of their own.
// The label lets layout checks find a chapter's closing block, whose lone paragraph Typst does not
// report as a `par`.
#let closing(body) = [#block(breakable: false, body) <closing-block>]
// A practice card's title keeps to the items under it, so that it never ends a page alone. The label lets
// layout checks treat it as a break, since its lone line is not reported as a `par`.
#let card(title) = [#block(sticky: true, spacing: par-space, strong(title)) <card-title>]
#let note(title, body) = flow-block(width: 100%, fill: tint, mark: <sample-box>,
  stroke: (left: 1.5pt + rust), inset: (x: 3 * space, y: 2.5 * space), above: 3 * space, below: 3 * space)[
  #set par(first-line-indent: 0pt, justify: false, leading: 5.5pt, spacing: 13.5pt)
  #block(sticky: true, above: 0pt, below: 2 * space)[#text(font: "Noto Sans CJK SC", weight: "bold", size: 10pt, title)]
  #body
]
// Compact one-paragraph field reminders keep meaning without a framed callout.
#let takeaway(title, body) = block(above: 2 * space, below: 2 * space)[
  #set par(first-line-indent: 0pt, justify: false, leading: body-line - body-edges, spacing: par-space)
  #text(weight: "bold", title) #h(.5em) #body
]
#let matrix(columns: (1.05fr, 1.4fr, 1.55fr), ..args) = {
  set par(justify: false, first-line-indent: 0pt, leading: 4.5pt, spacing: 2 * space)
  set text(size: 9.5pt)
  // A table that continues on the next page repeats its header and keeps each row whole.
  set table.cell(breakable: false)
  let cells = args.pos()
  flow-block(width: 100%, table(columns: columns, inset: (x: 2 * space, y: 1.5 * space),
    stroke: (x: none, y: .4pt + rule),
    table.header(..cells.slice(0, columns.len())), ..cells.slice(columns.len())))
}
#let reader-figure(name, caption, description, width: 100%) = figure(
  image("/build/artifacts/diagrams/" + name + ".png", width: width, alt: description.text),
  caption: caption, kind: image, supplement: [图],
)
