#import "@preview/neat-book:0.1.0": neat-book, codly
#import "/publication/layout/style.typ": *
#import "metadata.typ": *
#show: neat-book.with(title: book-title, author: book-author, ..publisher-design)
#set document(title: book-title, author: book-author, description: book-subtitle, keywords: book-keywords, date: book-date)
#show: publication-design
// Commands are meant to be copied: no line-number gutter in the text layer,
// and a short inline command never breaks across lines. A box may break on either side, so the word
// joiner keeps a closing mark that follows the command on its line: no line opens with one.
// Short is measured in display width: a Chinese character is set about twice as wide as a code letter.
#show: codly.set_(gutters: ())
#let display-width(text) = text.clusters().map(c => if c.match(regex("[\\p{Han}\\p{Hiragana}\\p{Katakana}\\p{Hangul}\u{3000}-\u{303F}\u{FF00}-\u{FFEF}]")) != none { 2 } else { 1 }).sum(default: 0)
#show raw.where(block: false): it => if display-width(it.text) <= 44 { box(it) + sym.wj } else { it }
#context [#metadata((
  title: document.title,
  author: document.author,
  description: document.description,
  date: if document.date != none { document.date.display("[year]-[month]-[day]") },
  version: book-version,
  release: book-release,
  edition: book-edition,
  keywords: document.keywords,
))<edition-identity>]
#include "manuscript.typ"
