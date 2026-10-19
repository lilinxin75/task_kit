#!/usr/bin/env bash
# task-new.sh — task-kit 任务脚手架
# 参照 spec-kit create-new-feature.sh：自动分配三位编号，建任务目录并初始化 00-STATE.md。
# 用法: ./task-new.sh <任务名>            # 自动编号
#       ./task-new.sh <任务名> --number 5 # 指定编号（冲突自动顺延）
# 零依赖：仅需 bash；在项目根目录（.task-kit/ 的上级）执行。
set -euo pipefail

TASK_KIT_DIR=".task-kit"
# v2.0.0：任务目录上移至项目根（对齐 Spec Kit 的 specs/ 模式）
TASKS_DIR="tasks"
SLUG_MAX_LEN=48

usage() { echo "用法: $0 [--number N] <任务名>"; exit 1; }

NUMBER=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --number) NUMBER="$2"; shift 2 ;;
    -h|--help) usage ;;
    -*) echo "错误: 未知参数 $1" >&2; usage ;;
    *)  if [[ -z "${TITLE:-}" ]]; then TITLE="$1"; else echo "错误: 只能有一个任务名" >&2; exit 1; fi; shift ;;
  esac
done
[[ -z "${TITLE:-}" ]] && usage
[[ -d "$TASKS_DIR" ]] || { echo "错误: 未找到 $TASKS_DIR，请先运行 task.init 建项目骨架（v2.0.0 起任务目录在项目根 tasks/，旧项目请见 README 迁移说明）" >&2; exit 1; }

# slug 化：小写英文 + CJK 保留，空格/分隔符转连字符，压缩重复连字符
# CJK 区间（一-鿿）在部分 locale/glibc 下 sed 会报 Invalid collation character——
# 失败时回退仅 ASCII（中文标题 slug 降级为 task），脚本不中断
_slug_in=$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[[:space:]/\\]+/-/g')
slug=$(printf '%s' "$_slug_in" | sed -E 's/[^a-z0-9一-鿿-]//g' 2>/dev/null) || true
if [[ -z "$slug" ]]; then
  slug=$(printf '%s' "$_slug_in" | sed -E 's/[^a-z0-9-]//g')
fi
slug=$(printf '%s' "$slug" | sed -E 's/-+/-/g; s/^-|-+$//g')
[[ -z "$slug" ]] && slug="task"
[[ ${#slug} -gt $SLUG_MAX_LEN ]] && slug="${slug:0:$SLUG_MAX_LEN}"

# 编号：指定 > 现有最大 + 1；目录已存在则自动顺延
next_num() {
  local n="$1"
  while [[ -d "$TASKS_DIR/$(printf '%03d' "$n")-$slug" ]]; do n=$((n+1)); done
  printf '%03d' "$n"
}
if [[ -n "$NUMBER" ]]; then NUM=$(next_num "$NUMBER"); else
  MAX=0
  for d in "$TASKS_DIR"/*/; do
    [[ -d "$d" ]] || continue
    b=$(basename "$d"); [[ "$b" =~ ^([0-9]{3})- ]] && (( ${BASH_REMATCH[1]} > MAX )) && MAX=${BASH_REMATCH[1]}
  done
  NUM=$(next_num $((MAX+1)))
fi

DIR="$TASKS_DIR/$NUM-$slug"
mkdir -p "$DIR/checklists" "$DIR/materials" "$DIR/outputs"

cat > "$DIR/00-STATE.md" <<EOF
# 任务状态卡 · 00

---
task: "$TITLE"
slug: "$NUM-$slug"
stage: "clarify"
stages_done:
  - stage: "new"
    artifact: "$DIR/00-STATE.md"
next: "task.clarify"
chain_grants: 0
suspended_reason: null
updated: "$(date '+%F %T')"
---

【任务名称】$TITLE
【任务目录】$DIR
【当前状态】阶段一入口 · 待澄清
【连跑授权余量】0

## 关键结论
- （待澄清）

## 下一步
- task.clarify：分析展示 + 澄清提问（最多 2 轮 × 每轮 ≤6 问）→ 复述确认 → 落盘 01-task.md

## 闸门记录
| 阶段 | 结论 | 日期 |
|------|------|------|
|      |      |      |
EOF

echo "已创建: $DIR"
echo "下一步: task.clarify"
