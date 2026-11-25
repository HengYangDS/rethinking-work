// The book in reading order, each part declared once with its number, its name and its chapter files. A chapter takes
// its head from the part it is in, and the contents group the chapters by part. The back group has no number.
#import "/publication/layout/style.typ": book-part
#let parts = (
  (number: "一", name: "根", files: ("parts/work", "parts/change", "parts/invariants")),
  (number: "二", name: "一个人", files: ("parts/question", "parts/knowing", "parts/model", "parts/bounds", "parts/choice",
    "parts/practice-thinking")),
  (number: "三", name: "智能体", files: ("parts/agent", "parts/first", "parts/context", "parts/tools", "parts/boundaries",
    "parts/memory", "parts/practice-agent")),
  (number: "四", name: "交出去以后", files: ("parts/delegate", "parts/verify", "parts/walkthrough", "parts/run",
    "parts/diagnose", "parts/orchestrate", "parts/evaluate", "parts/practice-doing")),
  (number: "五", name: "一群人", files: ("parts/team", "parts/roles", "parts/writing", "parts/review", "parts/standing",
    "parts/shared", "parts/improve", "parts/talent", "parts/leading", "parts/practice-collaborating")),
  (number: "六", name: "人", files: ("parts/growth",)),
  (number: none, name: "结语、后记与附录", files: ("parts/closing", "back-matter")),
)
#include "front-matter.typ"
#for part in parts {
  book-part.update(part)
  for file in part.files { include file + ".typ" }
}
