---
name: task-kit
description: 管理任务版 Spec Kit（Claude Code 斜杠命令适配）。把任务按五段式推进：任务澄清→方案编制→答疑确认→执行追踪→复盘沉淀，项目宪法约束所有任务，产物落盘为 markdown 契约文件。
---

按 task-kit 五段式工作系统推进任务：$ARGUMENTS

> v2.0.0：每条阶段命令完成后停止并输出阶段完成报告；阶段推进需用户指令或连跑授权（闸门处必停）。目录契约 v2 见 core/SKILL.md。

执行前先加载工作流定义（按顺序尝试）：
1. `~/.claude/skills/task-kit/SKILL.md`（已按 Agent Skills 安装时）
2. 本包 `core/SKILL.md`

严格遵循其中的：
- 目录契约：`.task-kit/CONSTITUTION.md` + `PROJECT.md` + `tasks/<任务slug>/` 六文件
- 命令语义：task.init / constitution / new / clarify / plan / review / check / track / aar / done / list
- 执行规则：宪法校验、澄清闸门（复述确认）、选择题评审、沉没成本停机、AAR 规则晋升
- 阶段模板：从 `templates/` 目录取用，不得自行改结构

若模板目录不存在，按 SKILL.md 中描述的结构内联生成模板。
