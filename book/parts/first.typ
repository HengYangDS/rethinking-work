#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "10", "第一次会话", "在自己的机器上，把那六步走一遍：交一件小事，看它怎样做，对着记录收回来。")<first>
做完这一章，后面各章讲的记录、上下文和权限，你都已在自己的机器上亲手碰过。

需要准备的有：一个已经装好并登录的宿主，git，Python，jq，以及随册的练习包。宿主怎样安装和登录，照它的官方说明做；用哪个账号、接哪些模型，以部门当下的安排为准。本章的命令以 Claude Code 为准。用 Codex 的读者，交出任务、看差异、跑测试的步骤相同；它的会话记录存放的位置和格式都不一样，本章没有写。

== 备一个可以随便改的地方
把#link(<agent>)[上一章]那个导出函数和它的测试复制到一个新目录，提交一次。第一行等号后面的路径，换成你解压练习包的目录：

```sh
PACK=~/Downloads/重新理解工作-实战练习
mkdir ~/first-session && cd ~/first-session &&
  cp "$PACK/exercises/cases/export-regression/export_bug.py" export.py &&
  cp "$PACK/exercises/cases/export-regression/test_export.py" . &&
  git init -q -b main && git add -A &&
  git commit -q -m "base: export drops zero returns"
```

后五行连成一条命令，哪一步失败，后面的就不再执行。

如果提交时报错，说不知道你是谁，先配好名字和邮箱，再重做提交这一步：

```sh
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
git commit -q -m "base: export drops zero returns"
```

此时 `git log --oneline` 应该显示一行。然后自己跑一遍测试，看看它现在的样子：

```sh
EXPORT_MODULE=export python3 -B -m unittest -v test_export.py
```

这条命令照抄即可。测试默认测的是练习包里的 `export_bug.py`，前面的 `EXPORT_MODULE=export` 让它改测这个目录里的 `export.py`。输出中要紧的是这几行：

```
test_empty_input (…) ... ok
test_keeps_zero_and_negative_return (…) ... FAIL
Ran 2 tests in 0.000s
FAILED (failures=1)
```

两项测试，一项失败，零收益的那一行没有保留。这是交出去之前你亲眼看到的事实。

之所以不在练习包里直接改，是因为练习包自带的检查认的是原件：其中一项要看到 `export_bug.py` 照旧漏掉零收益的行，在原件上修好了，这一项反而通不过。先提交一次，是为了稍后看得清它改了什么，改坏了也退得回去。

== 交一件事
在这个目录里启动宿主：

```sh
claude --permission-mode manual
```

在哪个目录启动，它就在哪个目录里干活。`--permission-mode` 决定它什么时候停下来问你，可选的几种叫作档位。在 `manual` 这一档，它每次要改文件、运行命令，都会先停下来问你。默认是哪一档，因版本和个人设置而异，所以第一次就在命令里写明。在会话里输入上一章那份委托，只多写明了文件名和验证的命令：

#note("委托", [export.py 里的导出函数漏掉了零收益的行，请找出原因并修好。约定是：零、正数、负数都保留，只排除空值。用 `EXPORT_MODULE=export python3 -B -m unittest -v test_export.py` 验证。])

== 它停下来问的时候
它停下来问你，是宿主在问，不是模型在问。#link(<boundaries>)[第十三章]讲的边界，此刻就握在你手上。

先读它要做的那一条：是哪条命令，改哪个文件的哪一行。看懂了再答应。答应通常有两种选法：只这一次，或者这一类以后都不再问。这一章都选“只这一次”。看不懂的不答应，在对话里问它为什么要这样做。

它做完会交回一段报告。先别读，输入 `/exit` 退出会话；报告存在会话记录里，稍后再读。

== 对着记录收
先看事实，再看它的话。三样事实都在你自己手上。

一是它改了什么：

```sh
git diff
git status --short
```

第一条看改动，第二条看有没有多出来的文件。

#link(<case-records>)[附录 D]记有这份委托的一次运行：差异只有一行，筛选条件从按真假判断改成了只排除空值。你这一次如果多出别的改动或文件，每一处都要弄清它为什么在那里。

二是行为对不对。自己再跑一遍刚才那条测试，这一次两项应该都通过，末尾是 `Ran 2 tests` 和 `OK`。

三是它一路做了什么。Claude Code 把每次会话存成一个文件，放在 `~/.claude/projects/` 下，按启动目录分开。`jq` 是从 JSON 里取字段的命令，下面两段照抄即可，不必看懂每个符号。先列出它的每一次工具调用：

```sh
f=$(/bin/ls -t ~/.claude/projects/*first-session*/*.jsonl | head -1)
echo "$f"
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="tool_use")
  | [.name, (.input.command // .input.file_path // .input.pattern // ""
     | tostring | .[0:64])] | @tsv' "$f"
```

代码第一行取的是这个目录里最新的一次会话。把 `echo` 打印出的路径记下来，后面几章还会在这个目录里开新的会话，到时要靠它找回这一次。jq 打印的每一行是一次工具调用，包括工具的名字，以及它运行的命令、涉及的文件或搜索的词。工具带回了什么，在另一种块里：

```sh
jq -r 'select(.type=="user") | .message.content | arrays | .[]
  | select(.type=="tool_result") | .content
  | if type=="array" then map(.text? // "") | join(" ") else . end
  | .[0:90] | gsub("\n";" ")' "$f"
```

现在读它的报告。报告也在这个会话文件里，下面这条命令取出它写的每一段文字，最后一段就是报告：

```sh
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="text") | .text' "$f"
```

报告里每一句肯定的话，都要在上面两张单子里有据可查，找到对应的那一步。“测试两项通过”，找得到最后那一次运行和它的输出。如果报告里有一句“其他调用方不受影响”，单子上却没有一步去找过调用方，那一句就先当它没做。

收下之后提交。提交说明里写上理由，再给这次提交起个名字，后面几章还要回到它：

```sh
git add -A
git commit -q -m "fix: keep zero returns" \
  -m "Zero is a value (the price did not move); None means unknown.
Rejected: filling None with 0, which would hide missing data."
git tag fix
```

这个目录现在有两次提交，一次有错，一次修好。

== 接着做，不进交互
会话存在磁盘上，可以回头接上。`--continue` 接续这个目录里最近的一次，`--resume` 从列表里挑一次，Codex 用的是第三条。要接着做时，三条里挑一条用：

```sh
claude --continue
claude --resume
codex resume --last
```

不进交互、把结果交给下一条命令的用法，两个宿主都有，这是把智能体接进脚本和流水线的入口。下面两条各是一个宿主的写法，用你装的那一个。每运行一次，就是一次要花钱的调用：

```sh
claude -p "列出这个目录里每个文件的用途，一行一个" --output-format json
codex exec "列出这个目录里每个文件的用途，一行一个" --json -o last.txt
```

第一条交回的 JSON 里有一项 `total_cost_usd`，是宿主按标价估算的这次花费。Codex 的 `exec` 对应 `-p`，`--json` 把事件逐行打印出来，`-o` 把最后一条回复另存为一个文件。

#matrix(columns: (1.2fr, 2fr), [*选项（Claude Code）*], [*管什么*], [`-c`, `--continue` / `-r`, `--resume`], [接着哪一次会话], [`-p`, `--print`], [不进交互，答完就退出], [`--output-format text|json|stream-json`], [给人看还是给程序读；`stream-json` 是逐步的过程记录，要同时加 `--verbose`])

其余选项收在#link(<quickref>)[附录 B]。

== 刚才发生了什么
上一章的那几步，你在第一张单子上都看到了：它读文件，跑测试，改一行，再跑测试。三层也都露了面。模型决定下一步做什么，宿主负责执行，并在要紧处停下来问你，工具带回了测试的输出。

六个性质里，你用上了两个。一是它只知道上下文里的东西，所以约定和验证的命令由你写进委托。二是它的报告是续写，不是记录，所以你先看了差异和测试，再读它的话。

还有三件事是你做的，它替代不了：交出去之前，你先亲眼看到了那一项失败；它要动手时，你读懂了才答应；收的时候，你对着记录收。怎样管住它能碰什么，见#link(<boundaries>)[第十三章]；怎样交、怎样收，第四部各有一章。
