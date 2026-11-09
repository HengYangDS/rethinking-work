// Document-level style over the unchanged publisher package.
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
#let publication-design(body) = {
  set text(lang: "zh", region: "CN", top-edge: .8em, bottom-edge: -.2em)
  set heading(numbering: none)
  show heading.where(level: 1): it => {
    block(above: 6 * space, below: 3 * space, sticky: true)[
      #text(font: "Noto Sans CJK SC", weight: "bold", size: 25pt, it.body)
      #v(2 * space)
      #line(length: 100%, stroke: .6pt + rule)
    ]
  }
  set figure(numbering: "1")
  set par(first-line-indent: 0pt, leading: body-line - body-edges, spacing: 2 * body-line - body-edges)
  show heading.where(level: 2): set block(above: 6 * space, below: 2 * space)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 3): set block(above: 4 * space, below: 2 * space)
  show heading.where(level: 3): set text(size: 11pt)
  show table.cell.where(y: 0): set text(font: "Noto Sans CJK SC", weight: "bold", size: 9pt)
  show figure.caption: set text(size: 8.5pt, fill: muted)
  body
}
#let small(body) = text(size: 8.5pt, fill: muted, body)
#let pageref(loc) = context link(loc, text(fill: teal)[#counter(page).at(loc).first()])
#let case(identifier) = link(label("case-" + identifier), identifier)
#let chapter(part, n, title, lead) = {
  set heading(numbering: none)
  pagebreak(weak: true)
  heading(level: 1)[#title]
  block(above: 0pt, below: 2 * space, sticky: true)[
    #set par(first-line-indent: 0pt, leading: 5.5pt, spacing: 2 * space)
    #text(font: "Noto Sans CJK SC", size: 8pt, fill: muted)[#part / #n]
    #parbreak()
    #text(size: 11pt, fill: teal)[#lead]
  ]
}
#let note(title, body) = block(width: 100%, breakable: false, fill: tint,
  stroke: (left: 1.5pt + rust), inset: (x: 3 * space, y: 2.5 * space), above: 3 * space, below: 3 * space)[
  #set par(first-line-indent: 0pt, justify: false, leading: 5.5pt, spacing: 13.5pt)
  #block(sticky: true, above: 0pt, below: 2 * space)[#text(font: "Noto Sans CJK SC", weight: "bold", size: 10pt, title)]
  #body
]
// Compact one-paragraph field reminders keep meaning without a framed callout.
#let takeaway(title, body) = block(above: 2 * space, below: 2 * space)[
  #set par(first-line-indent: 0pt, justify: false, leading: body-line - body-edges, spacing: 2 * body-line - body-edges)
  #text(weight: "bold", title) #h(.5em) #body
]
#let matrix(..args) = {
  set par(justify: false, first-line-indent: 0pt, leading: 4.5pt, spacing: 2 * space)
  set text(size: 9.5pt)
  let cells = args.pos()
  table(columns: (1.05fr, 1.4fr, 1.55fr), inset: (x: 2 * space, y: 1.5 * space),
    stroke: (x: none, y: .4pt + rule),
    table.header(..cells.slice(0, 3)), ..cells.slice(3))
}
#let reader-figure(name, caption, description, width: 100%) = figure(
  image("/build/artifacts/diagrams/" + name + ".png", width: width, alt: description.text),
  caption: caption, kind: image, supplement: [图],
)
