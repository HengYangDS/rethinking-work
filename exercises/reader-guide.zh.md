# 重新理解工作：从一次数据核对开始

衡阳 · 2026 年 11 月 10 日

这份练习配合《重新理解工作》使用，面向量化对冲基金的数据部门。你会核对一份研究快照，修正一个容易漏掉零值的导出函数，再检查一次接口变更。数据全部是合成的，不含业务资料；练习不需要账号、模型请求或运行服务。

先自己判断，再让 Agent 帮忙。你要练的是：把问题说清楚，选对证据，用可以复核的结果决定下一步。

## 开始前

解压后，进入 `重新理解工作-实战练习` 目录。下文把它称为“练习根目录”。先打开 `exercises/reader-guide.zh.md`，也就是这份说明。

完整检查需要已安装的 Python 3.12、DuckDB、ast-grep 和 oasdiff，且命令能在终端中找到。练习包不包含这些工具，也不会安装软件。缺少工具时，完整检查会报错；这不等于示例已经通过。也可以先阅读数据，或只做 Python 导出练习。

在练习根目录运行：

```sh
python3.12 -B -m unittest discover -s tests -p test_exercises.py -v
```

预期是 `Ran 8 tests` 和 `OK`。其中两项专门检查“应该失败”的情况：旧导出函数漏掉零值，删除接口会破坏原契约。总检查通过，表示这些错误被准确识别，不能理解成旧函数或接口变更没有问题。

下面的单项命令均在 `exercises` 目录运行。示例使用 macOS／Linux 终端语法；不要把路径或环境变量语法原样套到其他终端。

## 练习一：这个时间点，我们究竟能用哪些数据？

研究快照和原始记录不一致。先别让 Agent“把数字对齐”。你需要回答：这次要还原的是当时公开的信息，还是当时系统实际取得的信息？两者可能不同。

本题还原系统实际可用的数据：事件日期为 2026-10-30，截点为 **2026-11-02 09:00:00 UTC**。记录必须在截点前已经发布、也已经入库。先筛选这两个时间，再从合格记录中选版本，不能先选今天的最新版本再回推历史。

| 文件                                               | 你需要看什么                             |
| -------------------------------------------------- | ---------------------------------------- |
| [source-observations.csv](source-observations.csv) | 发布、入库、修订号和收益值               |
| [universe.csv](universe.csv)                       | 应覆盖的 S01–S06，不因数据缺失而缩小分母 |
| [research-snapshot.csv](research-snapshot.csv)     | 等待核对的研究快照                       |
| [reconcile.sql](reconcile.sql)                     | 如何筛选、选版和比较                     |
| [quality.sql](quality.sql)                         | 如何单独报告来源质量问题                 |

收益单位为基点（bps），1 bps = 0.01 个百分点。零收益是真实值，不能当成缺失；负收益也要保留。

先不看答案，检查 S01、S02 和 S06。写下你认为应采用的值，以及对应的来源行。然后运行：

```sh
duckdb -no-agent -csv < reconcile.sql
duckdb -no-agent -csv < quality.sql
```

完整输出应分别与 [expected-differences.csv](expected-differences.csv) 和 [expected-quality.csv](expected-quality.csv) 一致。

| 证券 | 截点可用值 | 快照值 | 应如何解释                                     |
| ---- | ---------- | ------ | ---------------------------------------------- |
| S01  | 0          | 5      | 快照采用了截点之后的修订；差值为 -5 bps        |
| S02  | -100       | -80    | 第二版虽已公开，但截点后才入库；差值为 -20 bps |
| S05  | 不可采用   | 20     | 截点时尚不可用，不计算收益差值                 |
| S06  | 40         | 缺失   | 可用数据没有出现在快照里，不计算收益差值       |

可采用的记录是 S01=0、S02=-100、S03=60、S06=40，覆盖率为 **4/6**。S04 缺少收益，S05 在截点时不可用，S99 不在覆盖范围内。数据缺失应单列，不能补成零，也不能把六个证券的收益相加当成组合收益。

S03 的两次交付具有相同版本和数值，因此本题的排序规则能选出等价结果。如果同版本的数值冲突，按行号选一个并不能解决业务争议。

### 怎么让 Agent 帮上忙

可以这样交代任务：

> 请只读这组合成文件，解释截至指定 UTC 时间系统实际可用的数据。先写清筛选与选版顺序，再逐项列出快照差异和质量问题。保留零值、负值和原覆盖分母；不要修改输入、补造缺失值或推断投资结论。每个判断指出来源行和复核命令。

拿到回答后，重点追问 S02：如果任务改成“当时市场已经公开了什么”，答案为什么变成 -80 bps？这种问题只筛选发布时间；原题还要筛选入库时间，所以是 -100 bps。变的是问题定义，不是为了通过检查而调整答案。原有 SQL 保持原题口径。

## 练习二：一行看似合理的代码，为什么会漏数据？

`export_bug.py` 用 `if row["return_bps"]` 筛选记录。在 Python 中，数值零会被当成假值，因此被过滤掉。业务要求却是保留零、正数和负数，只排除 `None`。

先读 [test_export.py](test_export.py)，再比较 [export_bug.py](export_bug.py) 与 [export_fixed.py](export_fixed.py)：

```sh
EXPORT_MODULE=export_bug python3.12 -B -m unittest -v test_export.py
EXPORT_MODULE=export_fixed python3.12 -B -m unittest -v test_export.py
```

旧代码预期退出码为 1：保留非缺失收益的测试失败，空输入测试通过。修正版改为 `is not None`，两项测试都通过，退出码为 0。

也可以用结构化搜索找到目标表达式：

```sh
ast-grep run --lang python --pattern 'row["return_bps"]' \
  --json=compact export_bug.py
```

预期只有一处匹配。搜索负责找到位置，业务契约与测试负责判断对错。让 Agent 改代码时，要求它先用测试重现问题，再证明修正没有破坏空输入这个对照。

多想一步：缺少键、空字符串和 `None` 是否应同样处理？现有两项测试没有回答这个问题。先确定输入契约，再决定新增测试；不要悄悄把异常输入变成零。

## 练习三：版本号变了，调用方就能承受吗？

合成接口的新版本删除了 `GET /research-snapshot`。先比较 [openapi-before.yaml](openapi-before.yaml) 与 [openapi-after.yaml](openapi-after.yaml)，再运行：

```sh
oasdiff breaking openapi-before.yaml openapi-after.yaml \
  --format json --allow-external-refs=false --fail-on ERR
oasdiff breaking openapi-before.yaml openapi-before.yaml \
  --format json --allow-external-refs=false --fail-on ERR
```

第一项预期返回 `api-path-removed-without-deprecation`，退出码为 1；不变的对照返回 `[]`，退出码为 0。命令只比较本地规范，禁用外部引用，不启动接口服务。

请 Agent 列出受影响的调用方、迁移方案和需要谁批准，再由人决定发布安排。规范差异检查可以指出删除行为，但不能证明实现符合规范，也不能替代真实调用方的兼容验收。

## 从做对例题，到做好工作

找一位同事，不让他先看预期结果。请他说明数据口径，解释 S02，指出零值缺陷，再区分接口规范检查和运行验收。讨论分歧时回到来源和业务目的，不以谁的措辞更自信决定对错。

包内还有几份可填写的工作材料：

| 材料                                               | 适合用在什么时候                            |
| -------------------------------------------------- | ------------------------------------------- |
| [task-brief.md](task-brief.md)                     | 交代交付物、使用者、范围和验收方式          |
| [source-table.csv](source-table.csv)               | 记录一个判断由什么原始材料支持              |
| [work-chain-design.md](work-chain-design.md)       | 找出从输入到交付之间的步骤、工具和决策人    |
| [evaluation-card.md](evaluation-card.md)           | 比较 Agent 方案与原做法，计入复核和返工成本 |
| [team-asset-review.md](team-asset-review.md)       | 判断某个方法能否沉淀为团队共同资产          |
| [long-task-checkpoint.md](long-task-checkpoint.md) | 长任务停滞时，确定下一项能改变判断的动作    |
| [transfer-cases.json](transfer-cases.json)         | 更换条件，检验是否理解了原问题              |

模板保留英文，便于填入技术任务；不必全部使用，也不必另建一套管理台账。把适用字段放进已有任务记录即可。

这些都是已知的教学案例，不是独立冻结的盲测。通过八项检查，只证明这组示例符合既定要求；能否迁移到真实业务、是否提高团队质量与效率，还需要在获得授权的新任务中观察。练习不构成生产上线、数据外传或投资交易的批准。

只清理自己创建的练习副本。保留需要交接的结果，不动原始业务数据、其他人的文件或现有恢复材料。
