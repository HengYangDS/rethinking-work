// The five judgments from a problem to feedback; looking back changes the next judgment.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 22mm
#let body = figure-diagram(spacing: (8mm, 7mm),
  n((0, 0), <a>, [问题], width: w), n((1, 0), <b>, [判断], width: w),
  n((2, 0), <c>, [做出来], width: w), n((3, 0), <d>, [有人在用], width: w),
  n((4, 0), <e>, [回头看], width: w),
  e(<a>, <b>), e(<b>, <c>), e(<c>, <d>), e(<d>, <e>),
  e(<e>, (4, 1), (1, 1), <b>, l[改变下一轮判断], label-side: right),
)
