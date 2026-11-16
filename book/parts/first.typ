#import "/publication/layout/style.typ": *
#import "/book/metadata.typ": *
#chapter("三 / 智能体", "10", "第一次会话", "在自己的机器上，把那六步走一遍：交一件小事，看它怎样做，对着记录收回来。")<first>
做完这一章，后面各章说的记录、上下文、权限，你手上都有一份自己的。

需要的东西：一个装好并登录了的宿主，git，Python，jq，和随册的练习包。宿主怎样装、怎样登录，照它官方的说明做；用哪个账号、接哪些模型，以部门当下的安排为准。这一章的命令以 Claude Code 为准。用 Codex 的，交出去、看差异、跑测试的步骤一样；它的会话记录放在别处、格式也不同，这一章没有写。

== 备一个可以随便改的地方
把#link(<agent>)[上一章]那个导出函数和它的测试，复制到一个新目录里，提交一次。第一行换成你解压练习包的那个目录：

```sh
PACK=~/Downloads/重新理解工作-实战练习
mkdir ~/first-session && cd ~/first-session &&
  cp "$PACK/exercises/cases/export-regression/export_bug.py" export.py &&
  cp "$PACK/exercises/cases/export-regression/test_export.py" . &&
  git init -q -b main && git add -A &&
  git commit -q -m "base: export drops zero returns"
```

后五行是连着的一条：哪一步不成，后面的就不做。

提交报错说不知道你是谁的，先配上名字和邮箱，再把提交那一步重做一遍：

```sh
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
git commit -q -m "base: export drops zero returns"
```

`git log --oneline` 应该有一行。然后自己跑一遍测试，看它现在是什么样：

```sh
EXPORT_MODULE=export python3 -B -m unittest -v test_export.py
```

输出里要紧的几行：

```
test_empty_input (…) ... ok
test_keeps_zero_and_negative_return (…) ... FAIL
Ran 2 tests in 0.000s
FAILED (failures=1)
```

两项测试，一项失败：零收益的那一行没有保留。这是交出去之前，你自己亲眼看到的事实。

不在练习包里直接改，是因为练习包自带的检查认的是原件。先提交一次，是为了后面看得清它改了什么，改坏了也退得回去。

== 交一件事
在这个目录里启动宿主：

```sh
claude --permission-mode manual
```

它读到的就是这个目录。`manual` 是逐条问的那一档：默认是哪一档，各版本、各人的设置不一样，所以头一回在命令里写明。把上一章那句话交给它：

#note("交给它的话", [export.py 里的导出函数漏掉了零收益的行，请找出原因并修好。约定是：零、正数、负数都保留，只排除空值。用 `EXPORT_MODULE=export python3 -B -m unittest -v test_export.py` 验证。])

== 它停下来问的时候
这一档下，它要运行命令、要改文件的时候，会停下来问你。这是宿主在问，不是模型在问：#link(<boundaries>)[第十三章]讲的边界，此刻就在你手上。

读它要做的那一条：是哪条命令，改的是哪个文件、哪一行。看懂了再答应。答应的办法通常有两种：只这一次，或者这一类以后都不问。头一回，选只这一次；看不懂的，不答应，问它为什么要这样做。

它做完会交一段报告。先别读报告。输入 `/exit` 退出会话。

== 对着记录收
先看事实，再看它的话。三样事实，都在你自己手上。

它改了什么：

```sh
git diff
git status --short
```

第一条看改动，第二条看有没有多出来的文件；多出来的文件，也逐个问一句为什么。

这句话我交出去过一次（怎样跑的见#link(<case-records>)[附录 D]），差异只有一行：筛选的条件从按真假判断，改成了只排除空值。你这一次要是多出别的改动，每一处问一句为什么。

行为对不对，自己再跑一遍刚才那条测试。这一次应该是两项都通过。

它一路做了什么。Claude Code 把每次会话存成一个文件，在 `~/.claude/projects/` 下按启动的目录分开放。`jq` 是从 JSON 里取字段的命令；下面两条照抄就行，不必看懂每个符号。先列出它的每一次工具调用：

```sh
f=$(/bin/ls -t ~/.claude/projects/*first-session*/*.jsonl | head -1)
echo "$f"
jq -r 'select(.type=="assistant") | .message.content[]?
  | select(.type=="tool_use")
  | [.name, (.input.command // .input.file_path // .input.pattern // ""
     | tostring | .[0:64])] | @tsv' "$f"
```

第一行取的是这个目录里最新的一次会话。把 `echo` 打印出来的路径记下来：后面几章还会在这个目录里开新的会话，到时候要靠它找回这一次。往下每一行是一次工具调用：工具的名字，和它运行的命令、动的文件或者搜的词。工具带回了什么，在另一种块里：

```sh
jq -r 'select(.type=="user") | .message.content | arrays | .[]
  | select(.type=="tool_result") | .content
  | if type=="array" then map(.text? // "") | join(" ") else . end
  | .[0:90] | gsub("\n";" ")' "$f"
```

现在读它的报告。每一句肯定的话，在上面两张单子里找它对应的那一步。“测试两项通过”，找得到最后那一次运行和它的输出。要是报告里有一句“其他调用方不受影响”，而单子上没有一步去找过调用方，那一句就先当它没做。

收下了，提交。提交说明里写上理由，再给这次提交起个名字，后面几章还要回到它：

```sh
git add -A
git commit -q -m "fix: keep zero returns" \
  -m "Zero is a value (the price did not move); None means unknown.
Rejected: filling None with 0, which would hide missing data."
git tag fix
```

这个目录现在有两次提交：一次有错的，一次修好的。

== 接着做，另起，不进交互
会话存在磁盘上，可以回来。`--continue` 接着这个目录里最近的一次，`--resume` 从列表里挑一次；Codex 是第三条。三条各是一种接法，一次只用一条：

```sh
claude --continue
claude --resume
codex resume --last
```

不进交互、把结果交给下一条命令的用法，两边都有。这是把智能体接进脚本和流水线的入口。下面两条各是一个宿主的写法，用你的那一个；每运行一次，是一次要花钱的调用：

```sh
claude -p "列出这个目录里每个文件的用途，一行一个" --output-format json
codex exec "列出这个目录里每个文件的用途，一行一个" --json -o last.txt
```

第一条交回的 JSON 里有一项 `total_cost_usd`，是这一次花的钱。

#matrix(columns: (1.2fr, 2fr), [*选项（Claude Code）*], [*管什么*], [`-c`, `--continue` / `-r`, `--resume`], [接着哪一次会话], [`-p`, `--print`], [不进交互，答完就退出], [`--output-format text|json|stream-json`], [给人看还是给程序读；`stream-json` 是逐步的过程记录，要同时加 `--verbose`])

别的选项收在#link(<quickref>)[附录 B]。

Codex 的 `exec` 对应 `-p`：`--json` 把事件按行打印出来，`-o` 把最后一条回复另存一个文件。

== 刚才发生了什么
上一章的那几步，你在第一张单子上看到了：它读文件，跑测试，改一行，再跑测试。三层也都露了面：模型决定下一步做什么，宿主执行并且在要紧的地方停下来问你，工具带回了测试的输出。

六个性质里，你用上了两个。它只知道上下文里的：约定和验证的命令，是你写进那句话里的。它的报告是续写，不是记录：所以你先看了差异和测试，再读它的话。

还有三件事是你做的，它替不了：交出去之前，自己先看到了那一项失败；它要动手的时候，读懂了才答应；收的时候，对着记录收。怎样管住它能碰什么，是#link(<boundaries>)[第十三章]；怎样交，怎样收，第四部各有一章。
