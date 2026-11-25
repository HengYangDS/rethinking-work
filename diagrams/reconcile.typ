// A snapshot rebuilt by the two-step rule and compared security by security. What cannot be compared is reported:
// S05 and S99 leave at the first step, S04 (no value) at the second.
#import "/publication/layout/figures.typ": figure-diagram, figure-node as n, figure-edge as e, figure-label as l
#let w = 46mm
#let body = figure-diagram(spacing: (10mm, 4mm),
  n((0, 0), <a>, [原始观测 11 行], width: w),
  n((0, 1), <b>, [公布、入库都不晚于冻结时刻], width: w),
  n((0, 2), <c>, [每只取最新版本], width: w),
  n((0, 3), <d>, [4 只有值], width: w),
  n((0, 4), <e>, [与快照逐只核对], width: w),
  n((1, 1.5), <q>, [另行报告 3 只], width: 30mm, quiet: true),
  e(<a>, <b>), e(<b>, <c>), e(<c>, <d>), e(<d>, <e>), e(<b>, <q>), e(<c>, <q>),
)
