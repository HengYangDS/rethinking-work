// The cover and the contents, set from the layout's faces and sizes; the front matter gives their words.
#import "style.typ": *
// The cover: the English title in capitals above the title, the subtitle, a rule, the tagline, and at the foot the
// author and the edition line.
#let cover(title-en: none, title: none, subtitle: none, tagline: none, author: none, edition: none) = [
  #set page(header: none, footer: none, numbering: none)
  #set par(first-line-indent: 0pt, justify: false)
  #v(13mm)
  #text(size: type-size.cover.title-en, fill: ink, tracking: 1.6pt, upper(title-en))
  #v(17mm)
  #text(font: body-faces.chinese, size: type-size.cover.title, weight: "bold", title)
  #v(8mm)
  #text(size: type-size.cover.subtitle, fill: ink, subtitle)
  #v(14mm)
  #line(length: 32mm, stroke: 1.6pt + slate)
  #v(8mm)
  #text(size: type-size.cover.text, tagline)
  #v(1fr)
  #text(size: type-size.cover.text, author)
  #v(3mm)
  #small(edition)
]
// The row under the preface's heading: the link back to the contents, where a chapter's navigation line has it.
#let preface-row = block(above: 0pt, below: 2 * space)[#grid(columns: (1fr, auto), [], contents-return())]
// The contents: the first outlined opening, then one group a part, in reading order, from the parts the chapters
// declare (`book/manuscript.typ`). Each entry gives the chapter's number, its title and its page.
#let contents-entry(number, target) = context {
  let page = counter(page).at(target.location()).first()
  block(above: 0pt, below: 3 * space, link(target.location(), grid(columns: (11mm, 1fr, auto),
    text(font: sans-face, size: type-size.contents, fill: muted, number),
    target.body,
    text(fill: muted, str(page)),
  )))
}
#let contents-group(title, marks) = {
  block(above: 6 * space, below: 3 * space, text(font: sans-face, size: type-size.contents, fill: muted, title))
  for mark in marks { contents-entry(chapter-label(mark), query(heading.where(level: 1).before(mark.location())).last()) }
}
#let contents() = {
  v(2 * space)
  context contents-entry("", query(heading.where(level: 1, outlined: true)).first())
  context {
    let marks = query(<chapter-navigation>)
    let part-of(mark) = book-part.at(mark.location())
    for part in marks.map(part-of).dedup() {
      let title = if part.number == none { part.name } else { "第" + part.number + "部　" + part.name }
      contents-group(title, marks.filter(mark => part-of(mark) == part))
    }
  }
}
