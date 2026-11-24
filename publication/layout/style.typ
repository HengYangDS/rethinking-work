// Document-level style over the unchanged publisher package.
#import "@preview/neat-book:0.1.0": codly
#let ink = rgb("273B46")
#let teal = rgb("273B46")
#let muted = rgb("687B85")
#let rule = rgb("DCE3E8")
#let tint = rgb("F3F5F5")
#let rust = rgb("82979F")
#let body-size = 10.5pt
// The text block holds a whole number of characters, so that a line of Chinese fills it without squeezing its
// punctuation: W3C clreq takes a line length of whole characters as the ground for adjusting punctuation.
#let measure-chars = 43
#let text-width = measure-chars * body-size
#let body-line = 16pt
#let body-edges = body-size
#let space = 4pt
// The space between paragraphs, which also separates a list, a code block, a table or a practice card
// from the text around it; a sample box (`note`) keeps less.
#let par-space = 2 * body-line - body-edges
// Horizontal alignment, one rule per kind of element (W3C clreq 2.1.3; CY/T 170—2019 7.2):
// - body paragraphs are justified, their last line flush left, and a justified line opens its characters by at most
//   `open-most`;
// - text set in a narrow measure (sample boxes, cards, table cells) is flush left, not justified, so that no line is
//   spread;
// - headings, captions inside boxes, list items and code are flush left;
// - a table's first column and its text columns are flush left, a column of numbers flush right on its units digit,
//   each heading over its column; nothing in a table is centred (`column-align`);
// - a figure's caption is centred under it, as a book sets captions;
// - the contents set titles flush left and page numbers flush right; the running head sets the title left and the
//   chapter right; the folio is centred.
// What is read as one piece stays on one page while it is short: a block of at most this many
// body lines moves to the next page whole, and a taller one continues there.
#let whole-lines = 6
#let whole-height = whole-lines * body-line
// The most a page is left short when such a block moves whole: the block and the step from the
// paragraph above it. Layout checks read the bound from here.
#let whole-allowance = whole-height + par-space + body-edges
// A section heading stays on a page while this many body lines fit under it.
#let heading-lines = 3
// A table or sample box that continues on the next page leaves at least this much of itself on
// each page: a header with one row, or a box's last two lines, is less. Layout checks read it here.
#let split-least = 3 * body-line
// Justification opens the space between two Chinese characters of a line by at most this much;
// past it the line reads as letter-spaced. A Latin word or a command too long for the rest of a
// line leaves its room to be spread; the wording is changed there. Layout checks read it here.
#let open-most = 0.05em
// The most pages the edition holds, cover and back matter included (owner, 2026-11-22).
#let page-ceiling = 200
// The text a piece of content shows, as far as it can be read without layout: enough to see how a
// paragraph ends.
#let plain-text(c) = {
  if type(c) == str { c }
  else if c.has("text") { c.text }
  else if c.has("children") { c.children.map(plain-text).join("") + "" }
  else if c.has("body") { plain-text(c.body) }
  else if c.has("child") { plain-text(c.child) }
  else { "" }
}
// The face of commands and outputs; a paragraph set in it is a line of code.
#let code-face = ("DejaVu Sans Mono", "Noto Sans CJK SC", "Libertinus Serif")
// What the edition asks of the publisher: language, paper, margins, faces and size. The entrypoint
// passes it with the edition's identity.
#let publisher-design = (
  lang: "zh", paper: "a4", cover: false, toc: false,
  margin: (x: (210mm - text-width) / 2, top: 22mm, bottom: 22mm),
  fonts: (chinese: "Songti SC", english: "Charter", japanese: "Songti SC", sans: "Noto Sans CJK SC", mono: code-face.first()),
  accent: ink, cjk-oblique: none, font-size: body-size,
)
// Punctuation marks around a curly quotation mark, set in cells. The body face's own quotation marks are narrow, so
// each mark of a run takes a full cell, as the other Chinese marks do, and two marks side by side take one and a half
// (clreq, adjacent punctuation): the half between them is dropped where one of them leaves it blank. Closing marks
// sit at the left of their cell and opening marks at the right. A run is joined to its neighbours where a line may not
// break: before a closing mark, after an opening one, and nowhere inside it (GB/T 15834—2011 5.1.1, 5.1.3).
#let opening-marks = "“‘（"
#let quote-run(run) = {
  let marks = run.clusters()
  let opens(c) = opening-marks.contains(c)
  // Each adjacent pair drops one half cell, from the mark that leaves that half blank: the left mark if it is a
  // closing one, else the right mark if it is an opening one.
  let widths = marks.map(_ => 1em)
  for i in range(marks.len() - 1) {
    if not opens(marks.at(i)) { widths.at(i) -= 0.5em }
    else if opens(marks.at(i + 1)) { widths.at(i + 1) -= 0.5em }
  }
  // The marks of a run never part: a line may not break inside it.
  let body = marks.zip(widths).map(((c, w)) => box(width: w, align(if opens(c) { right } else { left }, c))).join(sym.wj)
  (if opens(marks.first()) { none } else { sym.wj }) + body + (if opens(marks.last()) { sym.wj } else { none })
}
// What was set last in the text: a paragraph, a lead-in (below), or another block, which every other
// block records after itself.
#let last-set = state("last-set", "block")
#let publication-design(body) = {
  set text(lang: "zh", region: "CN", top-edge: .8em, bottom-edge: -.2em)
  // Chinese inside commands and outputs takes the sans face, not the serif body face. A symbol that
  // neither face holds, such as ℹ, takes Typst's own Libertinus Serif, declared as a fallback here
  // rather than reached by accident.
  show raw: set text(font: code-face)
  show regex("[，。：；、？！（）]*[“”‘’][，。：；、？！（）“”‘’]*"): it => context {
    if text.font.first() == lower(code-face.first()) { it } else { quote-run(it.text) }
  }
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
  // a longer one may continue on the next page. Its frame has no space of its own: like a list, it
  // takes the paragraph step after a lead-in and counts as a paragraph for what follows it.
  show raw.where(block: true): it => {
    context if last-set.get() == "lead-in" { v(par.spacing) }
    show: codly.set_(breakable: it.lines.len() > whole-lines)
    it
    last-set.update("paragraph")
  }
  // A paragraph that ends with a colon introduces what follows it: a command, a box, a table or a
  // list. It stays with that block, so that it never ends a page whose next page holds what it
  // introduces. Set after a paragraph, it takes the paragraph step above it; after any other block it
  // takes none, so that block's own step below applies, as it does for any paragraph; below it, the
  // next block's own step applies. Its mark lets layout checks bound the room it leaves when it moves.
  // Codly sets each line of code as a paragraph of its own; such a paragraph is left as it is.
  show par: it => context {
    let before = last-set.get()
    if text.font.first() == lower(code-face.first()) {
      it
    } else if plain-text(it.body).trim().ends-with("：") {
      block(sticky: true, above: if before == "block" { 0pt } else { par.spacing }, below: 0pt,
        [#metadata(none)<lead-in>#it])
      last-set.update("lead-in")
    } else {
      // A paragraph after a lead-in takes the step a paragraph takes after a paragraph.
      if before == "lead-in" { v(par.spacing) }
      it
      last-set.update("paragraph")
    }
  }
  // A block records itself before what it holds as well as after, so that its own first paragraph
  // is not read as following a lead-in.
  show heading: it => { last-set.update("block"); it; last-set.update("block") }
  show figure: it => { last-set.update("block"); it; last-set.update("block") }
  // A list is spaced like a paragraph: it has no space of its own, takes the paragraph step after a
  // lead-in, and counts as a paragraph for what follows it.
  show list: it => context {
    if last-set.get() == "lead-in" { v(par.spacing) }
    last-set.update("block"); it; last-set.update("paragraph")
  }
  show enum: it => context {
    if last-set.get() == "lead-in" { v(par.spacing) }
    last-set.update("block"); it; last-set.update("paragraph")
  }
  show table.cell.where(y: 0): set text(font: "Noto Sans CJK SC", weight: "bold", size: 9pt)
  show figure.caption: set text(size: 8.5pt, fill: muted)
  body
}
#let small(body) = text(size: 8.5pt, fill: muted, body)
// Sets a block whole when it is short and lets it continue on the next page when it is tall. Its
// height is measured in the width it will take. Its spacing, unless given, is the paragraph spacing
// in force where it is called. `mark` labels the block for layout checks; `most` is the tallest it sets whole.
#let flow-block(body, above: auto, below: auto, mark: none, most: whole-height, ..args) = block(
  above: above, below: below, width: 100%,
  layout(size => {
    let whole = measure(width: size.width, block(..args, body)).height <= most
    // Zero-size marks at the start and end of the content let layout checks see where it splits.
    [#block(breakable: not whole, ..args, [#last-set.update("block")#metadata(none)<block-start>#body#metadata(none)<block-end>])#mark]
  }),
) + last-set.update("block")
// A page the manuscript ends on purpose, as when an exercise asks for an answer before the reader
// turns the page. The mark lets layout checks tell such a page from one left short.
#let page-turn() = [#metadata(none)<page-turn>#pagebreak(weak: true)]
#let pageref(loc) = context link(loc, text(fill: teal)[#counter(page).at(loc).first()])
#let case(identifier) = link(label("case-" + identifier), identifier)
// A reference to a chapter, a practice or an appendix is derived from the number its opening
// declares, so a renumbering changes every reference with it. `chapref` writes 第三章, 练一 or
// 附录 D, linked unless `link: false`; several targets give 第九、第十章. `chapnum` writes the
// declared number, linked, as the tables list it.
#let zh-number(n) = {
  let digits = ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  let (tens, ones) = (calc.div-euclid(n, 10), calc.rem(n, 10))
  let unit = if ones > 0 { digits.at(ones) } else { "" }
  if tens == 0 { digits.at(ones) } else if tens == 1 { "十" + unit } else { digits.at(tens) + "十" + unit }
}
#let chapter-number(target) = {
  let page = locate(target).page()
  let mark = query(<chapter-navigation>).find(it => it.location().page() == page)
  if mark == none { panic("chapref: " + repr(target) + " is not on a chapter's opening page") }
  mark.value.chapter
}
#let chapref(..targets, link: true) = context {
  let numbers = targets.pos().map(chapter-number)
  let digits = numbers.all(n => n.match(regex("^\d+$")) != none)
  let text = if digits { "第" + numbers.map(n => zh-number(int(n))).join("、第") + "章" }
    else if numbers.len() == 1 and numbers.first().starts-with("练") { numbers.first() }
    else if numbers.len() == 1 { "附录 " + numbers.first() }
    else { panic("chapref: several targets must all be numbered chapters") }
  if link and targets.pos().len() == 1 { std.link(targets.pos().first(), text) } else { text }
}
#let chapnum(target) = context std.link(target, chapter-number(target))
// A relative reference, 上一章 or 下一章, carries the chapter it stands for and prints as written:
// the words keep their colour, and a test can hold the target to the reading order.
// The words keep the body text's colour: they gain a target, not a look.
#let relref(target, body) = link(target, text(fill: ink, body))
// A range of chapters, 第十八至二十一章, and a list, 第十、十一、十二章; each prints as the book
// writes it, from the openings' declared numbers, and links to its first chapter.
#let chapspan(first, last, link: true) = context {
  let (a, b) = (chapter-number(first), chapter-number(last))
  let text = [第#zh-number(int(a))至#zh-number(int(b))章]
  if link { std.link(first, text) } else { text }
}
#let chaprun(..targets, link: true) = context {
  let numbers = targets.pos().map(chapter-number)
  let text = [第#numbers.map(n => zh-number(int(n))).join("、")章]
  if link { std.link(targets.pos().first(), text) } else { text }
}
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
  last-set.update("block")
}
// Keep a chapter's closing lines with the paragraph before them, so that one
// or two lines are not stranded on a page of their own.
// The label lets layout checks find a chapter's closing block, whose lone paragraph Typst does not
// report as a `par`.
#let closing(body) = [#block(breakable: false, [#last-set.update("block")#body]) <closing-block>#last-set.update("block")]
// A practice card is read as one piece, like a sample box: its title and items stay on one page while
// they are short, and a taller card continues on the next page with the declared least part on each.
// The step under its title is not a line of the card, so a card of `whole-lines` lines and a title
// still moves whole.
// The title's label lets layout checks treat it as a break, since its lone line is not reported as a
// `par`; the card's mark lets them see where it splits.
#let card(title, body) = flow-block(mark: <card>, above: par-space, below: par-space, most: whole-height + par-space)[
  #block(sticky: true, above: 0pt, below: par-space, strong(title)) <card-title>
  #body
]
#let note(title, body) = flow-block(width: 100%, fill: tint, mark: <sample-box>,
  stroke: (left: 1.5pt + rust), inset: (x: 3 * space, y: 2.5 * space), above: 3 * space, below: 3 * space)[
  #set par(first-line-indent: 0pt, justify: false, leading: 5.5pt, spacing: 13.5pt)
  #block(sticky: true, above: 0pt, below: 2 * space)[#text(font: "Noto Sans CJK SC", weight: "bold", size: 10pt, title)]
  #body
]
// Compact one-paragraph field reminders keep meaning without a framed callout.
#let takeaway(title, body) = block(above: 2 * space, below: 2 * space)[
  #last-set.update("block")
  #set par(first-line-indent: 0pt, justify: false, leading: body-line - body-edges, spacing: par-space)
  #text(weight: "bold", title) #h(.5em) #body
] + last-set.update("block")
// Whether a cell holds a number alone: digits with their separators, sign and percent, or a count of a total such as
// 5 / 6 (CY/T 170—2019 7.2.2.4
// aligns such a column on its units digit; the book's numbers have no decimals within a column, so the units digit is
// the right edge). A cell of words, a range, a unit or a mixed value is not a number.
#let number-cell(c) = plain-text(c).trim().match(regex("^[−+\\-]?\\d[\\d,]*(\\.\\d+)?%?( ?/ ?\\d+)?$")) != none
// How a table's columns are set, after CY/T 170—2019 7.2.2: the first column names its rows and is set flush left
// (7.2.2.2), whatever it holds, so a step or request number stays a label; any other column whose body cells all hold
// numbers is set flush right on the units digit (7.2.2.4), its header with it so that each heading stands over its
// column; every other column, its header included, is set flush left, as text is read (7.2.2.5). Nothing in a table is
// centred or justified.
#let column-align(cells, n) = {
  let body = cells.slice(n)
  range(n).map(i => if i == 0 { left } else {
    let column = body.enumerate().filter(((k, _)) => calc.rem(k, n) == i).map(((_, c)) => c)
    let filled = column.filter(c => plain-text(c).trim() != "")
    if filled.len() > 0 and filled.all(number-cell) { right } else { left }
  })
}
#let matrix(columns: (1.05fr, 1.4fr, 1.55fr), ..args) = {
  // A table that continues on the next page repeats its header and keeps each row whole. Like a
  // list, it has no space of its own: it takes the paragraph step after a lead-in and counts as a
  // paragraph for what follows it.
  context if last-set.get() == "lead-in" { v(par.spacing) }
  set par(justify: false, first-line-indent: 0pt, leading: 4.5pt, spacing: 2 * space)
  set text(size: 9.5pt)
  set table.cell(breakable: false)
  let cells = args.pos()
  let aligns = column-align(cells, columns.len())
  flow-block(width: 100%, table(columns: columns, align: (x, _) => aligns.at(x) + top, inset: (x: 2 * space, y: 1.5 * space),
    stroke: (x: none, y: .4pt + rule),
    table.header(..cells.slice(0, columns.len())), ..cells.slice(columns.len())))
  last-set.update("paragraph")
}
// A figure floats to the top or the foot of the page where it is called, or of the next, so that the
// text runs on around it instead of leaving the rest of a page empty.
#let reader-figure(name, caption, description, width: 100%) = figure(placement: auto,
  image("/build/artifacts/diagrams/" + name + ".png", width: width, alt: description.text),
  caption: caption, kind: image, supplement: [图],
)
