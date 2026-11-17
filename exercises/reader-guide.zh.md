# 重新理解工作：从一次数据核对开始

衡阳 · 2026 年 11 月 17 日

这份练习配合《重新理解工作》使用，面向量化投资机构的数据部门。你会核对一份研究快照，修正一个容易漏掉零值的导出函数，再检查一次接口变更。另有来源选择、按主体核对和有效期映射三个练习。数据全部是合成的，不含业务资料；练习不需要账号、模型请求或运行服务。

先自己判断，再让智能体帮忙。你要练的是：把问题说清楚，选对证据，用可以复核的结果决定下一步。

## 开始前

解压后，进入 `重新理解工作-实战练习` 目录。下文把它称为“练习根目录”。先打开 `exercises/reader-guide.zh.md`，也就是这份说明。

完整检查需要已安装的 Python 3.12、DuckDB、ast-grep 和 oasdiff，且命令能在终端中找到。练习包不包含这些工具，也不会安装软件。缺少工具时，完整检查会报错；这不等于示例已经通过。也可以先阅读数据，或只做 Python 导出练习。

在练习根目录运行：

```sh
python3.12 -B -m unittest discover -s tests -p test_exercises.py -v
```

预期是 `Ran 17 tests` 和 `OK`。其中两项专门检查“应该失败”的情况：旧导出函数漏掉零值，接口变更删除了原有路径。总检查通过，表示这些错误被准确识别，不能理解成旧函数或接口变更没有问题。

下面六节各讲一个案例，书里的练习编号见下表。每一节里，题目后面紧跟着答案：先自己写下结果，再往下读。要改条件的时候，把那个案例目录复制一份，在副本里改；完整检查认的是原件。

| 本说明的一节 | 书里在哪里用                               |
| ------------ | ------------------------------------------ |
| 历史快照     | 练一·练习二，第十七章，练四·练习三、四   |
| 导出函数     | 第十章起各章的“上手”，练二·练习三，练三·练习二 |
| 接口变更     | 练二·练习三                                |
| 来源选择     | 练一·练习五                                |
| 按主体核对   | 练一·练习三                                |
| 有效期映射   | 练一·练习三                                |

每项练习的输入和代码放在同一个案例目录。下文会注明执行目录；切换练习时，先回到练习根目录，再进入对应目录。工作模板放在 `exercises/templates/`，迁移练习放在 `exercises/assessment/`。示例使用 macOS／Linux 终端语法；不要把路径或环境变量语法原样套到其他终端。

## 历史快照：这个时间点，我们究竟能用哪些数据？

研究快照和原始记录不一致。先别让智能体“把数字对齐”。你需要回答：这次要还原的是当时公开的信息，还是当时系统实际取得的信息？两者可能不同。

本题还原系统实际可用的数据：事件日期为 2026-10-30，冻结时刻为 **2026-11-02 09:00:00 UTC**。记录必须在冻结时刻前已经公布、也已经入库。先筛选这两个时间，再从合格记录中选版本，不能先选今天的最新版本再回推历史。

| 文件                                               | 你需要看什么                             |
| -------------------------------------------------- | ---------------------------------------- |
| [source-observations.csv](cases/historical-snapshot/source-observations.csv) | 公布、入库、版本号和收益值               |
| [universe.csv](cases/historical-snapshot/universe.csv)                       | 应覆盖的 S01–S06，不因数据缺失而缩小分母 |
| [research-snapshot.csv](cases/historical-snapshot/research-snapshot.csv)     | 等待核对的研究快照                       |
| [reconcile.sql](cases/historical-snapshot/reconcile.sql)                     | 如何筛选、选版和比较                     |
| [quality.sql](cases/historical-snapshot/quality.sql)                         | 如何单独报告来源质量问题                 |

收益单位为基点（bps），1 bps = 0.01 个百分点。零收益是真实值，不能当成缺失；负收益也要保留。

先不看下面的表，对 S01 到 S06 逐只写下你认为应采用的值和对应的来源行；没有值的，写明原因。然后在练习根目录下的 `exercises/cases/historical-snapshot/` 中运行：

```sh
duckdb -no-agent -csv < reconcile.sql
duckdb -no-agent -csv < quality.sql
```

完整输出应分别与 [expected-differences.csv](cases/historical-snapshot/expected-differences.csv) 和 [expected-quality.csv](cases/historical-snapshot/expected-quality.csv) 一致。

| 证券 | 冻结时刻可用值 | 快照值 | 应如何解释                                     |
| ---- | ---------- | ------ | ---------------------------------------------- |
| S01  | 0          | 5      | 快照采用了冻结时刻之后的更正；差值为 -5 bps        |
| S02  | -100       | -80    | 第二版虽已公开，但冻结时刻后才入库；差值为 -20 bps |
| S05  | 不可采用   | 20     | 冻结时刻时尚不可用，不计算收益差值                 |
| S06  | 40         | 缺失   | 可用数据没有出现在快照里，不计算收益差值       |

可采用的记录是 S01=0、S02=-100、S03=60、S06=40，覆盖率为 **4/6**。S04 缺少收益，S05 在冻结时刻时不可用，S99 不在覆盖范围内。数据缺失应单列，不能补成零，也不能把六个证券的收益相加当成组合收益。

S03 的两次交付具有相同版本和数值，因此本题的排序规则能选出等价结果。如果同版本的数值冲突，按行号选一个并不能解决业务争议。

### 怎么让智能体帮上忙

可以这样交代任务：

> 用途：核验一份研究快照能不能用于回测。
>
> 对象：这个目录里的 source-observations.csv、universe.csv、research-snapshot.csv，都是合成数据。
>
> 口径：公布时间和入库时间都不晚于 2026-11-02 09:00（UTC）的版本才算可用；从可用的版本里取最新的；零和负值照原样保留，空值不补；范围以 universe.csv 为准。
>
> 边界：只读，不修改输入，不推断投资结论。
>
> 交回：可以重跑的查询；逐只证券的值和来源行，没有值的写明原因；与快照的逐只差异。先做 S01、S02、S03 三只，停下等我看过。

这是书里第十五章的五项：用途，对象，口径，边界，交回什么。预期的答案没有写进去。

拿到回答后，重点追问 S02：如果任务改成“当时市场已经公开了什么”，答案为什么变成 -80 bps？这种问题只筛选公布时间；原题还要筛选入库时间，所以是 -100 bps。变的是问题定义，不是为了通过检查而调整答案。原有 SQL 保持原题口径。

## 导出函数：一行看似合理的代码，为什么会漏数据？

`export_bug.py` 用 `if row["return_bps"]` 筛选记录。在 Python 中，数值零会被当成假值，因此被过滤掉。业务要求却是保留零、正数和负数，只排除 `None`。

先读 [test_export.py](cases/export-regression/test_export.py)，再比较 [export_bug.py](cases/export-regression/export_bug.py) 与 [export_fixed.py](cases/export-regression/export_fixed.py)：

在练习根目录下的 `exercises/cases/export-regression/` 中运行：

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

预期只有一处匹配。搜索帮助定位代码；是否符合业务要求，还要对照规则和测试判断。让智能体改代码时，要求它先用测试重现问题，再确认修正后仍能正确处理空输入。

多想一步：现有测试已经要求排除 `None`，却没有规定缺少键或空字符串该如何处理。先说明哪些输入有效、异常输入应如何处理，再补充相应测试；不要悄悄把异常输入变成零。

## 接口变更：版本号变了，调用方就能承受吗？

合成接口的新版本删除了 `GET /research-snapshot`。先比较 [openapi-before.yaml](cases/api-evolution/openapi-before.yaml) 与 [openapi-after.yaml](cases/api-evolution/openapi-after.yaml)，再在练习根目录下的 `exercises/cases/api-evolution/` 中运行：

```sh
oasdiff breaking openapi-before.yaml openapi-after.yaml \
  --format json --allow-external-refs=false --fail-on ERR
oasdiff breaking openapi-before.yaml openapi-before.yaml \
  --format json --allow-external-refs=false --fail-on ERR
```

第一项预期返回 `api-path-removed-without-deprecation`，退出码为 1；不变的对照返回 `[]`，退出码为 0。命令只比较本地规范，禁用外部引用，不启动接口服务。

请智能体列出受影响的调用方、迁移方案和需要谁批准，再由人决定发布安排。规范差异检查可以指出删除行为，但不能证明实现符合规范，也不能替代真实调用方的兼容验收。

## 来源选择：更齐全的数据，就更适合这次研究吗？

这次要还原六个证券在 2024 年的历史决策信息。先读 [source-candidates.csv](cases/source-selection/source-candidates.csv)：现有来源只覆盖五个证券；公开来源虽然覆盖六个，却没有更正历史和可用时间；新来源材料齐全，但接入要五天。

在练习根目录下的 `exercises/cases/source-selection/` 中，用同一个 DuckDB 会话运行：

```sh
duckdb -no-agent -csv <<'SQL'
.read source-selection.sql
SELECT source_id, onboarding_days FROM selected;
SQL
```

预期选中 `new_vendor,5`。使用许可、完整覆盖、更正历史和可用时间是本题的必要条件；满足条件之后，才比较接入天数。天数只代表首次接入，不代表采购、维护和退出的总成本。

在自己创建的练习副本里，试着把现有来源的覆盖数从五改成六：答案应变成 `incumbent,1`。保留原来的覆盖情况，另做一次试验，撤销新来源的使用许可：应没有合格来源，而不是退而采用无法回答原问题的数据。完整检查会在各自独立的数据库中验证这三种情况，不修改 CSV。

## 按主体核对：总数都对，为什么分项还是错的？

[entity-expected.csv](cases/keyed-reconciliation/entity-expected.csv) 和 [entity-observed.csv](cases/keyed-reconciliation/entity-observed.csv) 都有两行，总量都是 10000。先看 E01 和 E02 各自的值，再在练习根目录下的 `exercises/cases/keyed-reconciliation/` 中运行：

```sh
duckdb -no-agent -csv < entity-reconciliation.sql
```

E01 应为 6000，实际是 4000；E02 应为 4000，实际是 6000。按主体核对后，差异分别是 -2000 和 +2000。这里的差值是“实际减预期”，与历史快照练习的方向相反；数值是合成计数，不是收益或风险敞口。

行数和总量可以用作初步检查，但不能代替按键逐项核对。真实数据还要先确认键是否唯一，否则连接查询可能把重复记录相乘。

## 有效期映射：主体归属，要按哪个时间判断？

PAT01 在 2024-07-01 00:00:00 UTC 前属于 OWNER_A，从这一刻起属于 OWNER_B。阅读 [entity-mappings.csv](cases/effective-date-mapping/entity-mappings.csv) 和 [entity-events.csv](cases/effective-date-mapping/entity-events.csv)，再在练习根目录下的 `exercises/cases/effective-date-mapping/` 中运行：

```sh
duckdb -no-agent -csv < entity-mapping.sql
```

EV01 应归 OWNER_A；EV02 恰好发生在切换时刻，应归 OWNER_B。区间包含起点、不包含终点，避免旧归属也把切换时刻算进去。EV03 使用没有映射的 PAT99，应返回 `NULL` 和 `unmapped`。

完整检查还会临时加入一段重叠映射，确认结果是 `NULL` 和 `ambiguous`，而不是任意挑一个归属。原文件保持不变。所有时间都显式声明时区；历史快照另有对照，说明不带时区的冻结时刻如何让不同会话得出不同答案。

再问自己：映射在某天有效，就能证明当时已经知道它吗？不能。有效期描述事件发生时的归属；要还原当时的知识，还需要公布时间或取得时间。修正映射，也不表示可以自行扩大研究范围。

## 从做对例题，到做好工作

找一位同事，不让他先看预期结果。请他说明数据口径，解释 S02，指出零值缺陷，再区分接口规范检查和运行验收。讨论分歧时回到来源和业务目的，不以谁的措辞更自信决定对错。

包内还有几份可填写的工作材料：

| 材料                                               | 适合用在什么时候                            |
| -------------------------------------------------- | ------------------------------------------- |
| [task-brief.zh.md](templates/task-brief.zh.md) | 照书里的五项写一份委托 |
| [long-task-checkpoint.zh.md](templates/long-task-checkpoint.zh.md) | 长任务的检查点、交接说明和三种结束 |
| [task-brief.md](templates/task-brief.md)                     | 交代交付物、使用者、范围和验收方式          |
| [source-table.csv](templates/source-table.csv)               | 记录一个判断由什么原始材料支持              |
| [work-chain-design.md](templates/work-chain-design.md)       | 找出从输入到交付之间的步骤、工具和决策人    |
| [evaluation-card.md](templates/evaluation-card.md)           | 比较智能体方案与原做法，计入复核和返工成本 |
| [team-asset-review.md](templates/team-asset-review.md)       | 判断某个方法能否沉淀为团队共同资产          |
| [long-task-checkpoint.md](templates/long-task-checkpoint.md) | 长任务停滞时，确定下一项能改变判断的动作    |
| [transfer-cases.json](assessment/transfer-cases.json)         | 更换条件，检验是否理解了原问题              |
| [cases/historical-snapshot/session/](cases/historical-snapshot/session/README.md) | 同一份快照的两份委托，智能体按第二份交回的查询，和两次会话的运行条件；`control/` 里是去掉规则的那组对照和强、轻两档各一次的原始回答 |
| [cases/export-regression/agent/](cases/export-regression/agent/SKILL.md) | 第十二章上手用的两个文件：一条钩子的设置，一份技能；钩子跑的检查脚本照书里印的建 |
| [templates/eval/](templates/eval/README.md)                   | 不调用模型就能跑通的两份评测：比提示，比任务 |

头两份中文模板照书里的写法做，可以直接改；其余几份是英文的，栏目更细。不必全部使用，也不必另建一套管理台账。把适用字段放进已有任务记录即可。

这些都是已知的合成案例，不是独立冻结的盲测。通过十七项检查，只证明这组示例符合既定要求；能否迁移到真实业务、是否提高团队质量与效率，还需要在获得授权的新任务中观察。练习不构成生产上线、数据外传或投资交易的批准。

只清理自己创建的练习副本。保留需要交接的结果，不动原始业务数据、其他人的文件或现有恢复材料。
