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
一份更换数据源的评估报告，是程序自动综合出来的。开头写着覆盖二十六个表的变体。总览把它们分成四档，四档加起来是二十一个；后面的决策矩阵分的是三档，加起来二十六个。

另一份是服务商交来的系统巡检报告。总结页上的风险统计，四个级别全是零；翻过一页，风险明细里列着九项。

两份报告格式规范，措辞稳妥。对不上的地方，要把前后两处摆在一起数一下才看得出来。

这两份报告放在一起，就是这本书想谈的事。像样而对不上，不是新毛病；新的是，这样的东西现在要多少有多少。做出来越来越容易，也越来越像样；它对不对，从样子上越来越看不出来。少掉的是亲手碰过数据才会起的疑心，是做的人对结果的把握，是出了错知道该找谁。这些东西从来没有写进哪一份岗位说明，因为用不着写：只要活是人干的，它们多半就在。现在活可以不由人干了。

过去，一个人把事情做出来的时候，多半也就顺带把它弄明白了。现在这两件事分开了：做出来可以很快，弄明白还是那么慢，而且动手不再逼着人去弄明白。我们这两年在工作里遇到的许多新麻烦，追下去都会追到这里。

这本书写给我的团队。它只做一件事。做出来不再费力了，弄明白就不能再靠顺带，得当成专门的事来做。我们怎样思考、怎样做事、怎样协作，都照这一条重新排一遍。书里的想法和做法，出自我这些年带这个部门、自己动手做事；做错过的地方也在里面，道理是在那些地方改出来的。

全书是一条线。第一部三章：工作是什么，这门技术改变了什么，什么没有变。第三章从工作的定义出发，加上几件事实，推出四样不随工具变的要求，书里叫四个条件。那一章还给出三条标准，后面反复拿来作判断，书里叫三条判据。后面各部讲的都是怎样弄明白。一个人怎样弄明白，是第二部。活交出去以后怎样仍然弄得明白，分两部：第三部讲接活的智能体，第四部讲怎样交、怎样收、怎样走到头。一群人怎样一起弄明白，是第五部。第六部回到人。第二到第五部各有一组练习。#link(<first>)[第十章]带你在自己的机器上跑第一次会话；此后讲智能体的各章，多数末尾有一节“上手”。数据在随册的练习包里，见#link(<companion>)[附录 A]。

刚加入的读者，先读第一部，三章，不长。然后可以直接到第三部，把第十章的第一次会话跑一遍，再回头读第二部。常用的命令和几张清单收在#link(<quickref>)[附录 B]；书里出现的工具各在哪一层、担什么事，见#link(<toolmap>)[附录 C]。

书里的例子多数来自数据工作：我们是一家量化投资机构的数据部门，每天把外面世界里零散的信号，变成研究和交易敢用的数据。案例取自真实的工作，隐去了对象的名字。有几处取自写这本书的过程和我自己的机器。

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
