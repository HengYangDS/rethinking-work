// Thinking together, doing together and handing over whole, switched back and forth as the work's state changes.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 26mm
#let body = figure-diagram(spacing: (12mm, 7mm),
  n((0, 0), <a>, [一起想], width: w), n((1, 0), <b>, [一起做], width: w),
  n((2, 0), <c>, [整件交出去], width: w),
  e(<a>, <b>, marks: "<|-|>"), e(<b>, <c>, marks: "<|-|>"),
)
