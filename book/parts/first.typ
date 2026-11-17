#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "10", "第一次会话", "在自己的机器上把那六步实际走一遍：交出一件小事，观察它怎样做，再对照记录把结果收回来。")<first>
完成这一章之后，后面各章讲到的记录、上下文和权限，你都已在自己的机器上亲手接触过。

需要准备的有：一个已经安装并登录的宿主，git，Python，jq，以及随册的练习包。宿主的安装和登录，按其官方说明进行；使用哪个账号、接入哪些模型，以部门当前的安排为准。本章的命令以 Claude Code 为准。使用 Codex 的读者，交出任务、查看差异、运行测试的步骤相同；但它的会话记录在存放位置和格式上都不一样，本章没有涉及。

== 准备一个可以随意修改的目录
把#link(<agent>)[上一章]那个导出函数及其测试复制到一个新目录，并提交一次。第一行等号后面的路径，请换成你解压练习包的目录：

```sh
PACK=~/Downloads/重新理解工作-实战练习
mkdir ~/first-session && cd ~/first-session &&
  cp "$PACK/exercises/cases/export-regression/export_bug.py" export.py &&
  cp "$PACK/exercises/cases/export-regression/test_export.py" . &&
  git init -q -b main && git add -A &&
  git commit -q -m "base: export drops zero returns"
```

后五行连成一条命令，任何一步失败，后续步骤都不再执行。

如果提交时报错，提示无法确定你的身份，先配置好用户名和邮箱，再重新执行提交这一步：

```sh
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
git commit -q -m "base: export drops zero returns"
```

此时 `git log --oneline` 应当显示一行。然后自己运行一遍测试，查看它当前的状态：

```sh
EXPORT_MODULE=export python3 -B -m unittest -v test_export.py
```

这条命令照原样输入即可。测试默认针对练习包里的 `export_bug.py`，前面的 `EXPORT_MODULE=export` 让它改为测试这个目录里的 `export.py`。输出中关键的是以下几行：

```
test_empty_input (…) ... ok
test_keeps_zero_and_negative_return (…) ... FAIL
Ran 2 tests in 0.000s
FAILED (failures=1)
```

两项测试中一项失败：零收益的那一行没有保留。这是交出任务之前你亲眼看到的事实。

之所以不直接在练习包里修改，是因为练习包自带的检查以原件为准：其中一项要求 `export_bug.py` 仍然漏掉零收益的行，若在原件上修好，这一项反而无法通过。先提交一次，是为了稍后能看清它改了什么，改坏了也能恢复。

== 交出一件事
在这个目录里启动宿主：

```sh
claude --permission-mode manual
```

在哪个目录启动，它就在哪个目录里工作。`--permission-mode` 决定它何时停下来征询你，可选的几种称为档位。在 `manual` 档下，它每次要修改文件、运行命令，都会先停下来询问。默认是哪一档，因版本和个人设置而异，所以第一次就在命令中写明。在会话里输入上一章那份委托，只是另外写明了文件名和验证命令：

#note("委托", [export.py 里的导出函数漏掉了零收益的行，请找出原因并修好。约定是：零、正数、负数都保留，只排除空值。用 `EXPORT_MODULE=export python3 -B -m unittest -v test_export.py` 验证。])

== 它停下来询问时
它停下来询问你，实际上是宿主在问，而不是模型在问。#link(<boundaries>)[第十三章]讲的边界，此刻就掌握在你手中。

先读它要执行的那一项：是哪条命令，修改哪个文件的哪一行。看懂了再同意。同意通常有两种选择：只这一次，或者这一类操作以后不再询问。本章一律选“只这一次”。看不懂的不要同意，可以在对话中问它为什么要这样做。

它完成后会交回一段报告。先不要读，输入 `/exit` 退出会话；报告保存在会话记录里，稍后再读。

== 对着记录收
先看事实，再看它的陈述。三项事实都可以由你自己查验。

一是它改了什么：

```sh
git diff
git status --short
```

第一条查看改动，第二条查看是否多出了文件。

#link(<case-records>)[附录 D]记录了这份委托的一次运行：差异只有一行，筛选条件从按真假判断改为只排除空值。如果你这一次的运行多出了别的改动或文件，每一处都要查明它为什么出现。

二是行为是否正确。自己再运行一遍刚才那条测试，这一次两项都应通过，末尾显示 `Ran 2 tests` 和 `OK`。

三是它在整个过程中做了什么。Claude Code 把每次会话保存为一个文件，放在 `~/.claude/projects/` 下，按启动目录分开存放。`jq` 是从 JSON 中提取字段的命令，下面两段照原样输入即可，不必弄懂每个符号。先列出它的每一次工具调用：

```sh
f=$(/bin/ls -t ~/.claude/projects/*first-session*/*.jsonl | head -1)
echo "$f"
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="tool_use")
  | [.name, (.input.command // .input.file_path // .input.pattern // ""
     | tostring | .[0:64])] | @tsv' "$f"
```

代码第一行取的是这个目录里最近的一次会话。请把 `echo` 打印出的路径记下来：后面几章还会在这个目录里开启新的会话，届时要靠它找回这一次。jq 打印的每一行是一次工具调用，包括工具的名称，以及它运行的命令、涉及的文件或搜索的词。工具带回了什么，记录在另一种块里：

```sh
jq -r 'select(.type=="user") | .message.content | arrays | .[]
  | select(.type=="tool_result") | .content
  | if type=="array" then map(.text? // "") | join(" ") else . end
  | .[0:90] | gsub("\n";" ")' "$f"
```

现在读它的报告。报告也在这个会话文件中，下面这条命令提取它写的每一段文字，最后一段就是报告：

```sh
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="text") | .text' "$f"
```

报告里每一句肯定的话，都要在上面两份列表中有据可查，即找到对应的那一步。“测试两项通过”，可以找到最后那一次运行及其输出。如果报告里有一句“其他调用方不受影响”，列表中却没有任何一步查找过调用方，这一句所说的事就先视为没有做。

确认可以接受之后提交。在提交说明中写明理由，再给这次提交起一个名字，后面几章还要用到它：

```sh
git add -A
git commit -q -m "fix: keep zero returns" \
  -m "Zero is a value (the price did not move); None means unknown.
Rejected: filling None with 0, which would hide missing data."
git tag fix
```

这个目录现在有两次提交：一次有错，一次已修复。

== 接续会话与非交互运行
会话保存在磁盘上，之后可以接续。`--continue` 接续这个目录里最近的一次会话，`--resume` 从列表中选择一次，Codex 用的是第三条。需要接着做时，从三条中选用一条：

```sh
claude --continue
claude --resume
codex resume --last
```

两个宿主都支持不进入交互、把结果交给下一条命令的用法，这是将智能体接入脚本和流水线的入口。下面两条分别是两个宿主的写法，使用你安装的那一个。每运行一次，就是一次付费的调用：

```sh
claude -p "列出这个目录里每个文件的用途，一行一个" --output-format json
codex exec "列出这个目录里每个文件的用途，一行一个" --json -o last.txt
```

第一条返回的 JSON 中有一项 `total_cost_usd`，是宿主按标价估算的本次花费。Codex 的 `exec` 对应 `-p`，`--json` 把事件逐行打印出来，`-o` 把最后一条回复另存为一个文件。

#matrix(columns: (1.2fr, 2fr), [*选项（Claude Code）*], [*作用*], [`-c`, `--continue` / `-r`, `--resume`], [继续哪一次会话], [`-p`, `--print`], [不进入交互，回答完毕即退出], [`--output-format text|json|stream-json`], [供人阅读还是供程序读取；`stream-json` 是逐步的过程记录，须同时加 `--verbose`])

其余选项列在#link(<quickref>)[附录 B]。

== 刚才发生了什么
上一章的那几步，你在第一份列表中都看到了：它读取文件，运行测试，修改一行，再运行测试。三层也都出现了：模型决定下一步做什么，宿主负责执行，并在关键处停下来询问你，工具带回了测试的输出。

六个性质中，你用到了两个。一是它只知道上下文中的内容，所以约定和验证命令由你写进委托。二是它的报告是续写，不是记录，所以你先看了差异和测试，再读它的陈述。

还有三件事由你完成，它无法替代：交出任务之前，你先亲眼看到了那一项失败；它要动手时，你读懂之后才同意；收回结果时，你对照记录逐项核对。怎样限定它能碰什么，见#link(<boundaries>)[第十三章]；怎样交、怎样收，第四部各有一章。
