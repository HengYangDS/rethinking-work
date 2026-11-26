#import "/publication/layout/packages.typ": neat-book
#import "/publication/layout/style.typ": *
#import "metadata.typ": *
#show: neat-book.with(title: book-title, author: book-author, ..publisher-design)
#set document(title: book-title, author: book-author, description: book-subtitle, keywords: book-keywords, date: book-date)
#show: publication-design
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
