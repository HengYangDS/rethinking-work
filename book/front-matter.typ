#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *

#[
#set page(header: none, footer: none, numbering: none)
#set par(first-line-indent: 0pt, justify: false)
#v(13mm)
#text(size: 9pt, fill: teal, tracking: 1.6pt)[RETHINKING WORK]
#v(17mm)
#text(font: "Songti SC", size: 39pt, weight: "bold", book-title)
#v(8mm)
#text(size: 15pt, fill: teal, book-subtitle)
#v(14mm)
#line(length: 32mm, stroke: 1.6pt + rust)
#v(8mm)
#text(size: 12pt)[怎样思考，#linebreak()怎样做事，#linebreak()怎样协作。]
#v(1fr)
#text(size: 12pt)[#book-author]
#v(3mm)
#small[#book-date-text]
]

#pagebreak()
#heading(level: 1, outlined: true)[序]<premise>
#block(above: 0pt, below: 2 * space)[#align(right, contents-return())]
量化投资机构的数据团队，日常工作是把外部世界零散的信号，加工成研究和交易可以放心使用的数据。本书的例子，都以这类业务为背景。

以一份数据源替换评估为例。它要回答的问题是：能否改用新的数据源，替换现用的一批表。报告由脚本汇总二十六项比对的结果自动生成。开头的总览写着，替换风险大的有三项；后面的决策矩阵写着，有十二项。换与不换，取决于这个数，同一份报告却给出了两个答案。

报告若由人撰写，这样的矛盾不容易出现：要写出结论，先得逐项读过明细，写到总览时，哪几项风险大，已经心中有数。脚本生成则不同，生成的过程不要求任何人读懂内容，报告照样章节齐全、结论分明，从外表上看不出问题。

过去，把一件事做出来，多半也就顺带把它弄明白了。如今这两件事分开了：做出来可以很快，弄明白仍旧那么慢，而且做出来不再迫使人去弄明白。大模型和智能体进入日常工作以后，许多新的麻烦，追根溯源，都出在这里。

本书只讲一件事：做出来不再费力，弄明白就不能再靠顺带，必须当作一件专门的工作来做。怎样思考、怎样做事、怎样协作，都依这一条重新梳理。

全书沿一条线索展开。第一部三章，讲工作是什么，大模型和建在它之上的智能体改变了什么，又有什么没有改变。第三章从工作的定义出发，加上四件事实，推出四个不随工具改变的条件；这一章还给出三条判据，后面各章反复用它们作判断。此后各部讲的都是怎样弄明白。第二部讲一个人怎样弄明白。活交出去以后怎样仍然弄得明白，分作两部来讲：第三部讲接活的智能体，第四部讲怎样交、怎样收，事情历时一长又怎样让它走到头。第五部讲一群人怎样一起弄明白。第六部回到人本身，讲一个人的本事从哪里长出来。第二至第五部各附一组练习。#link(<first>)[第十章]带读者在自己的机器上，与智能体完成第一次会话；此后讲智能体的各章，多数在末尾设有一节“上手”。练习和“上手”所用的文件，收在随册的练习包里，见#link(<companion>)[附录 A]。

刚加入团队的读者，可以先读第一部，只有三章，篇幅不长；然后直接到第三部，把第十章的第一次会话亲手做一遍，再回头读第二部。常用的命令和几张清单收在#link(<quickref>)[附录 B]。书中出现的工具，各属于#link(<agent>)[第九章]所分的哪一层、各担什么事，见#link(<toolmap>)[附录 C]。

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
#let contents-group(title, numbers) = context {
  block(above: 6 * space, below: 3 * space, text(font: "Noto Sans CJK SC", size: 9pt, fill: muted, title))
  for mark in query(<chapter-navigation>).filter(mark => numbers.contains(mark.value.chapter)) {
    contents-entry(mark.value.chapter, query(heading.where(level: 1).before(mark.location())).last())
  }
}
#context contents-entry("", query(heading.where(level: 1, outlined: true)).first())
#contents-group("第一部　根", ("01", "02", "03"))
#contents-group("第二部　一个人", ("04", "05", "06", "07", "08", "练一"))
#contents-group("第三部　智能体", ("09", "10", "11", "12", "13", "14", "练二"))
#contents-group("第四部　交出去以后", ("15", "16", "17", "18", "19", "20", "21", "练三"))
#contents-group("第五部　一群人", ("22", "23", "24", "25", "26", "27", "28", "练四"))
#contents-group("第六部　人", ("29",))
#contents-group("结语、后记与附录", ("终", "记", "A", "B", "C", "D"))
