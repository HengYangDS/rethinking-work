// The book in reading order, each part declared once with its name and its chapter files. A part's number is its place
// among the numbered parts; the back group has none. A chapter takes its head from the part it is in, and the contents
// group the chapters by part.
#import "/publication/layout/style.typ": book-part, zh-number
#let parts = (
  (name: "根", files: ("parts/work", "parts/change", "parts/invariants")),
  (name: "一个人", files: ("parts/question", "parts/knowing", "parts/model", "parts/bounds", "parts/choice",
    "parts/practice-thinking")),
  (name: "智能体", files: ("parts/agent", "parts/first", "parts/context", "parts/tools", "parts/boundaries",
    "parts/memory", "parts/practice-agent")),
  (name: "交出去以后", files: ("parts/delegate", "parts/verify", "parts/walkthrough", "parts/run",
    "parts/diagnose", "parts/orchestrate", "parts/evaluate", "parts/practice-doing")),
  (name: "一群人", files: ("parts/team", "parts/roles", "parts/writing", "parts/review", "parts/standing",
    "parts/shared", "parts/improve", "parts/talent", "parts/leading", "parts/practice-collaborating")),
  (name: "人", files: ("parts/growth",)),
  (name: "结语、后记与附录", numbered: false, files: ("parts/closing", "back-matter")),
)
#include "front-matter.typ"
#{
  let numbered = 0
  for part in parts {
    let number = none
    if part.at("numbered", default: true) { numbered += 1; number = zh-number(numbered) }
    book-part.update((number: number, name: part.name))
    for file in part.files { include file + ".typ" }
  }
}
