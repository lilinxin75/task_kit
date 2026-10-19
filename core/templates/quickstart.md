# Task Kit 快速上手

## 30 秒理解

Task Kit = 管理任务版 Spec Kit：**宪法约束项目，契约约束任务**。
一条生命周期：

```
task.init → task.constitution
    └→ 循环：task.new → clarify → plan → review → track ─┬→ aar → done
```

## 首次初始化

1. 对 agent 说「初始化 task-kit 项目」或 `task.init <项目名>` → 生成 `.task-kit/` 骨架、根目录 `quickstart.md`、`materials/` 与 `outputs/`
2. `task.constitution` → 立宪法（宪法先行，先于一切任务）

## 一个任务的完整节奏（每步停止等你指令）

`task.new` → `task.clarify` → `task.plan` → `task.review` → `task.track` → `task.aar` → `task.done`

- 每步结束会有「阶段完成报告」：本阶段产物 / 当前状态 / 下一步
- 说"继续"推进一步；说"接下来连着跑"自动推进一段（两个确认闸门处仍然会停）
- 方向变了？说"假设被推翻/方向变了"→ 自动回评审/澄清重走确认
- 澄清阶段最多 2 轮提问（每轮 ≤6 问）；方案阶段只做分析讨论，正式 A/B/C 选择题在评审阶段

## 文件放哪里

| 内容 | 位置 |
|---|---|
| 宪法 / 项目索引 | `.task-kit/`（CONSTITUTION.md、PROJECT.md、scripts/） |
| 任务产物 00–06 | `tasks/NNN-slug/` |
| 导入的共享素材 | `materials/`（整理归类后存放） |
| 任务默认输出 | `tasks/NNN-slug/outputs/` |
| 跨任务共享输出 | `outputs/` |
| 任务私有中间产物 | `tasks/NNN-slug/materials/` |

## 随时可用

- `task.check`（质量校验：宪法红线 + 跨产物一致性）
- `task.list`（任务列表）、`task.show <任务>`（状态卡）
