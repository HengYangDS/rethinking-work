// A snapshot rebuilt on two time axes and compared security by security; what cannot be compared is reported.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 40mm
#let body = figure-diagram(spacing: (10mm, 5mm),
  n((0, 0), <a>, [原始来源 11 行], width: w),
  n((0, 1), <b>, [查标识与两个时间], width: w),
  n((0, 2), <c>, [取当时可用的最新版], width: w, emphasis: true),
  n((0, 3), <d>, [4 只可用值], width: w),
  n((0, 4), <e>, [与快照逐只核对], width: w),
  n((1, 1), <q>, [另行报告 3 只], width: 30mm, quiet: true),
  e(<a>, <b>), e(<b>, <c>), e(<c>, <d>), e(<d>, <e>), e(<b>, <q>),
)
