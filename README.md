<div align="center">

# Task Kit

**管理任务版 Spec Kit — 把契约化开发思想迁移到职场任务的结构化工作系统**

*任务澄清 → 方案编制 → 答疑确认 → 执行追踪 → 复盘沉淀*

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Format: Agent Skills](https://img.shields.io/badge/Format-Agent%20Skills-purple)](#-安装)
[![Platform](https://img.shields.io/badge/Platform-WorkBuddy%20%7C%20Claude%20%7C%20Any%20Agent-green)](#-安装)
[![Dependencies](https://img.shields.io/badge/Dependencies-Zero-success)](#)

</div>

---

## 📖 这是什么

Task Kit 把 [GitHub Spec Kit](https://github.com/github/spec-kit) 的四个核心机制——**markdown 契约、阶段化命令、产物落盘、状态跟踪**——从代码开发迁移到管理工作任务。系统状态全部落盘在文件里而不在对话里，跨会话可续接，跨 agent 可迁移。

Spec Kit 的核心理念：**先定义"做什么、为什么做"，再决定"怎么做"**，规格本身就是后续执行的可执行契约。放到管理任务上，就是在三个失败节点设置强制对齐闸门：

| 任务失败模式 | Task Kit 的闸门 |
|---|---|
| 任务理解偏差（做完才发现方向错） | 阶段一：五要素澄清 + 复述确认 |
| 方案未对齐就开干（两周工作被一句话推翻） | 阶段三：SCQA + 选择题评审 |
| 执行中前提变了没人叫停 | 契约校验 + 沉没成本停机规则 |

写方案阶段的修改成本约为执行阶段的 1/10、汇报失败后的 1/100——本系统的全部设计就是把返工成本前置到最便宜的阶段。

## 🗺️ 与 Spec Kit 的命令映射

| Task Kit | Spec Kit | 动作 |
|---|---|---|
| `task.constitution` | `/constitution` | 项目宪法：使命/价值优先级/决策原则/红线，约束所有任务 |
| `task.new` | `/specify` | 建任务目录，specify 新任务 |
| `task.clarify` | `/specify` + `/clarify` | 五要素澄清 → 复述确认 → 问题定义书 |
| `task.plan` | `/plan` + `/tasks` | MECE 议题树 + 优先级打分 + 可证伪假设 + 行动计划 |
| `task.review` | 规格评审 | SCQA 汇报稿 + 方案 A/B/C 选择题 + 拍板记录 |
| `task.check` | `/analyze` | 宪法合规 + 跨产物一致性 pass/fail 校验 |
| `task.track` | `/implement` | 五段式周志 + 契约校验（追溯/假设/预警） |
| `task.aar` | `/converge` | 四问复盘，项目级规则晋升进宪法 |
| `task.init` / `task.done` | — | 项目初始化 / 任务收尾（生命周期补充） |

## ✨ 核心特性

- **宪法先行** — 项目级 `CONSTITUTION.md` 约束所有任务，AAR 产出的项目级规则可晋升进宪法（带来源任务与修订记录）
- **任务循环** — 项目内多任务生命周期：`init → constitution → new → clarify → plan → review → track → aar → done → 下一个任务`
- **产物落盘** — 每个任务一个目录、六份 markdown 文件，`00-STATE.md` 是跨会话续接的锚点
- **轻量对齐** — 给决策人做选择题（A/B/C + 推荐 + 风险 + 预案），一页纸、≤15 分钟、结论前置 30 秒
- **按返工成本裁剪** — 日常事务型 30 秒过五要素即可，专项任务型才跑全五段，突发问题型事后补 AAR
- **零依赖** — 纯 markdown，无代码、无运行时，任何能读文件的 agent 都能执行

## 📦 安装

### WorkBuddy（原生技能）

```bash
cp -r core/ ~/.workbuddy/skills/task-kit/
```

重启会话后按语义自动触发，说「task.init 某项目」即可。

### Claude Code（Agent Skills，推荐）

```bash
cp -r core/ ~/.claude/skills/task-kit/
```

Claude Code 与 WorkBuddy 使用同一套 SKILL.md 规范，按需自动加载。

### Claude Code（斜杠命令，备用）

```bash
mkdir -p .claude/commands && cp adapters/claude-code-command.md .claude/commands/task-kit.md
```

之后用 `/task-kit 推进XX任务` 调用。

### claude.ai（网页版）

Settings → Capabilities → Skills 上传本仓库 zip（SKILL.md 须在顶层或一级目录内）。

### Cursor / ChatGPT / 其他 Agent

把 `adapters/portable-rules.md` 全文粘贴进规则文件（`.cursorrules`、Custom Instructions、system prompt 等）。该版本自包含，模板结构已内联。

## 🚀 快速开始

```
你：task.init 仓储系统选型
AI：建立 .task-kit/ 骨架。项目还没有宪法，建议先立：这个项目的价值优先级是什么？
你：task.constitution（…对话后生成 CONSTITUTION.md）
你：task.new Picking 方案调研
AI：建任务目录。先澄清五个要素——这件事为什么现在做？成功标准是什么？…
你：（回答后）
AI：复述确认："我理解这件事是……最终要交……" 确认后落盘问题定义书。
你：task.plan / task.review / task.track / task.aar …
```

任务产物落盘在当前项目的 `.task-kit/` 目录：

```
.task-kit/
├── CONSTITUTION.md        # 项目宪法
├── PROJECT.md             # 项目索引 + Backlog
└── tasks/<任务slug>/
    ├── 00-STATE.md        # 状态卡（跨会话续接锚点）
    ├── 01-problem.md      # 问题定义书
    ├── 02-plan.md         # 方案骨架
    ├── 03-review.md       # 评审卡
    ├── 04-log.md          # 执行周志（追加式）
    └── 05-aar.md          # 复盘卡
```

## 📁 仓库结构

```
task_kit/
├── README.md                          # 本文件
├── LICENSE                            # MIT
├── docs/
│   └── spec-driven.md                 # 方法论详解：底层逻辑、五段式拆解、裁剪规则
├── core/
│   ├── SKILL.md                       # 工作流定义（Agent Skills 标准格式）
│   └── templates/                     # 7 个阶段模板
│       ├── 00-constitution.md         # 项目宪法
│       ├── 00-project.md              # 项目索引
│       ├── 01-problem.md              # 问题定义书
│       ├── 02-plan.md                 # 方案骨架
│       ├── 03-review.md               # 评审卡
│       ├── 04-log.md                  # 执行周志
│       └── 05-aar.md                  # AAR 复盘卡
└── adapters/
    ├── claude-code-command.md         # Claude Code 斜杠命令适配
    └── portable-rules.md              # 任意 Agent 通用规则（自包含）
```

## 🧭 方法论源流

McKinsey 七步法 / MECE / 金字塔原理（SCQA）提供骨架；假设驱动（Day-1 answer）与收益闭环来自咨询业通行实践；PDCA 提供闭环；Spec Kit 提供契约化与阶段闸门的工程化形式。重型咨询交付件（steering committee、多工作组、QC 链）被有意裁剪——本系统定位是**个人与中小团队的工作法**，不是咨询公司交付方法论。详见 [docs/spec-driven.md](docs/spec-driven.md)。

## 🤝 贡献

欢迎提 Issue / PR：新增任务类型裁剪规则、新平台适配器、模板改进。

## 📄 License

[MIT](LICENSE)
