#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *

#[
#set page(header: none, footer: none, numbering: none)
#set par(first-line-indent: 0pt, justify: false)
#v(13mm)
#text(size: 9pt, fill: ink, tracking: 1.6pt)[RETHINKING WORK]
#v(17mm)
#text(font: "Songti SC", size: 39pt, weight: "bold", book-title)
#v(8mm)
#text(size: 15pt, fill: ink, book-subtitle)
#v(14mm)
#line(length: 32mm, stroke: 1.6pt + slate)
#v(8mm)
#text(size: 12pt)[怎样思考，#linebreak()怎样做事，#linebreak()怎样协作。]
#v(1fr)
#text(size: 12pt)[#book-author]
#v(3mm)
#small[#book-edition]
]

#pagebreak()
#heading(level: 1, outlined: true)[序]<premise>
#block(above: 0pt, below: 2 * space)[#grid(columns: (1fr, auto), [], contents-return())]
量化投资机构的数据团队，日常工作是把散落在各个外部来源的原始数据，加工成研究和交易可以放心使用的数据。本书的例子大多以这类业务为背景。

有一份评估报告，要回答能否用新的数据源替换现用的一批表。报告由脚本汇总二十六项比对的结果自动生成。开头的总览称，替换风险较高的有三项；后文的决策矩阵列出的高风险项却有十二项。替换与否，要看高风险项有几项，而这个数，同一份报告给出了两个答案。

报告若由人撰写，这样的矛盾不易出现：执笔的人通常要先逐项读过明细，才写得出结论；写到总览时，哪几项风险较高，心中早已有数。由脚本生成则不同：整个过程不要求任何人读懂内容，报告照样章节齐全、结论分明，表面看不出问题。

过去，把一件事做出来，往往也就顺带把它弄明白了。例外也有：大模型出现以前，就已经有脚本生成、不要求有人读懂的报告，不过一个脚本只能生成编写时就定好的那一类。大模型和建立在它之上的智能体进入日常工作以后，查询、数据处理和报告，都可以这样做出来。做出来与弄明白由此分开：做出来可以很快，弄明白依旧费时，而且做出来不再迫使人去弄明白。如今的许多新问题，追根溯源，都出在这里。#chapref(<invariants>, link: false)列出了其中最明显的四个。

本书只讲一件事：做出来不再需要人亲身经历每一步，弄明白也就不能再指望在动手时顺带完成，而必须当作一件专门的工作来做。怎样思考、怎样做事、怎样协作，都据此重新梳理。

全书沿一条线索展开。第一部共三章，讲工作是什么，大模型和智能体改变了什么，又有什么没有改变：工作可以交给智能体，责任和弄明白却交不出去。其中#chapref(<invariants>, link: false)从工作的定义出发，结合四件事实，推出四个不随工具改变的条件，再由这些条件引出后面各章作判断时所用的三条判据。

此后各部讲的，都是怎样弄明白。第二部讲一个人怎样弄明白。工作交出去以后怎样仍能弄明白，分两部来讲：第三部讲承接工作的智能体；第四部讲怎样把事交出去、把结果收回来，怎样凭这一交一收把一件事从头做到尾，历时较长的事怎样做完，出了错怎样查。#chaprun(<orchestrate>, <evaluate>, link: false)还讲同时派出几个智能体时怎样做，换了说明或模型以后怎样判断效果有没有变好。第五部讲一群人怎样一起弄明白：一个人能弄明白的事有限，又有三处缺口无法自行弥补，即自己的错看不见，自己弄明白的留不下，自己的标准守不住；补上这三处，共同的前提是互相看得见。第六部回到人本身，讲一个人的能力从何而来。

第二至第五部各附一组练习。#chapref(<first>)带读者在自己的机器上与智能体完成第一次会话；第三部其余各章，以及#chapspan(<run>, <evaluate>, link: false)和#chapref(<shared>, link: false)，末尾都设有一节“上手”。练习和“上手”要用到的现成文件，收录在随书的练习包中，见#chapref(<companion>)。

刚加入团队的读者，可以先读篇幅不长的第一部，然后直接读第三部，亲手完成#chapref(<first>, link: false)的第一次会话，再回头读第二部。常用命令和几份清单集中在#chapref(<quickref>)。书中用到的工具及其职能，#chapref(<toolmap>)按#chapref(<agent>)所划分的层次列出，不属于这几层的排在后面。

#pagebreak()
#heading(level: 1, outlined: false)[目录]<contents>
#v(2 * space)
#let contents-entry(number, target) = context {
  let page = counter(page).at(target.location()).first()
  block(above: 0pt, below: 3 * space, link(target.location(), grid(columns: (11mm, 1fr, auto),
    text(font: "Noto Sans CJK SC", size: 9pt, fill: muted, number),
    target.body,
    text(fill: muted, str(page)),
  )))
}
#let contents-group(title, marks) = {
  block(above: 6 * space, below: 3 * space, text(font: "Noto Sans CJK SC", size: 9pt, fill: muted, title))
  for mark in marks { contents-entry(mark.value.chapter, query(heading.where(level: 1).before(mark.location())).last()) }
}
#context contents-entry("", query(heading.where(level: 1, outlined: true)).first())
// One group a part, in reading order, from the parts the chapters declare (`book/manuscript.typ`).
#context {
  let marks = query(<chapter-navigation>)
  let part-of(mark) = book-part.at(mark.location())
  for part in marks.map(part-of).dedup() {
    let title = if part.number == none { part.name } else { "第" + part.number + "部　" + part.name }
    contents-group(title, marks.filter(mark => part-of(mark) == part))
  }
}
