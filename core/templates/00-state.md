# 任务状态卡 · 00

---
task: "{{任务名}}"
slug: "{{NNN-slug}}"
stage: "{{clarify|plan|review|track|aar|done}}"   # constitution/new 为项目级，不写入任务卡
stages_done:
  - stage: "{{阶段}}"
    artifact: "{{相对路径}}"
next: "{{下一建议命令}}"
chain_grants: 0
suspended_reason: null
updated: "{{ISO 8601}}"
---

【任务名称】{{任务名}}
【任务目录】tasks/{{NNN-slug}}
【当前状态】{{一句话}}
【更新时间】{{ISO 8601}}

## 关键结论
- {{当前阶段关键结论，含闸门记录}}

## 下一步
- {{等待用户的动作}}

## 连跑授权余量
- {{chain_grants 数值}}（"接下来连着跑"=+1；"连跑 N 个阶段"=+N；闸门处"继续"=仅放行本闸门，不产生授权）

## 闸门记录
| 阶段 | 结论 | 日期 |
|------|------|------|
|      |      |      |
