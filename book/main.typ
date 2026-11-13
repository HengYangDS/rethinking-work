#import "@preview/neat-book:0.1.0": neat-book
#import "/publication/layout/style.typ": *
#import "metadata.typ": *
#show: neat-book.with(
  title: book-title, author: book-author,
  lang: "zh", paper: "a4", cover: false, toc: false,
  margin: (x: 25mm, top: 22mm, bottom: 22mm),
  fonts: (chinese: "Songti SC", english: "Charter", japanese: "Songti SC", sans: "Noto Sans CJK SC", mono: "DejaVu Sans Mono"),
  accent: ink, cjk-oblique: none, font-size: 10.5pt,
)
#set document(title: book-title, author: book-author, description: book-subtitle, keywords: book-keywords, date: book-date)
#show: publication-design
#context [#metadata((
  title: document.title,
  author: document.author,
  description: document.description,
  date: document.date.display("[year]-[month]-[day]"),
  keywords: document.keywords,
))<edition-identity>]
#include "manuscript.typ"
