<div align="center">

# Task Kit

**Spec Kit for Management Tasks — a structured work system that ports spec-driven development to workplace tasks**

*Clarify → Plan → Review → Track → Retrospective*

[简体中文](README.md) | **English**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Format: Agent Skills](https://img.shields.io/badge/Format-Agent%20Skills-purple)](#-installation)
[![Platform](https://img.shields.io/badge/Platform-WorkBuddy%20%7C%20Claude%20%7C%20Any%20Agent-green)](#-installation)
[![Dependencies](https://img.shields.io/badge/Dependencies-Zero-success)](#)

</div>

---

## 📖 What Is This

Task Kit ports the four core mechanisms of [GitHub Spec Kit](https://github.com/github/spec-kit) — **markdown contracts, staged commands, artifacts on disk, state tracking** — from code development to management work. All system state lives in files, not in the conversation, so work resumes across sessions and migrates across agents.

Spec Kit's core idea: **define "what and why" before deciding "how"** — the spec itself becomes the executable contract that all subsequent work validates against. Applied to management tasks, this means forcing alignment gates at the three points where tasks typically fail:

| Task Failure Mode | Task Kit Gate |
|---|---|
| Misunderstood assignment (direction wrong only after delivery) | Stage 1: five-element clarification + restatement confirmation |
| Executing without an aligned plan (two weeks of work overturned by one remark) | Stage 3: SCQA + multiple-choice review |
| Premises change mid-execution with nobody calling a stop | Contract verification + sunk-cost halt rule |

Revising during planning costs roughly 1/10 of revising during execution, and 1/100 of a failed delivery — this system's entire design pushes rework cost forward to the cheapest stage.

## 🗺️ Command Mapping to Spec Kit

| Task Kit | Spec Kit | Action |
|---|---|---|
| `task.constitution` | `/constitution` | Project constitution: mission, priority order, decision rules, red lines — binds all tasks |
| `task.new` | `/specify` | Create task directory, specify a new task |
| `task.clarify` | `/specify` + `/clarify` | Five-element clarification → restatement confirmation → problem definition |
| `task.plan` | `/plan` + `/tasks` | MECE issue tree + priority scoring + falsifiable hypotheses + action plan |
| `task.review` | Spec review | SCQA briefing + options A/B/C + decision log |
| `task.check` | `/analyze` | Constitution compliance + cross-artifact consistency pass/fail check |
| `task.track` | `/implement` | Five-section weekly log + contract verification (traceability / hypotheses / warnings) |
| `task.aar` | `/converge` | Four-question retrospective; project-level rules promoted into the constitution |
| `task.init` / `task.done` | — | Project initialization / task closure (lifecycle supplements) |

## ✨ Key Features

- **Constitution first** — a project-level `CONSTITUTION.md` binds every task; project-level rules surfaced by AARs are promoted into the constitution (with source task and amendment log)
- **Task loop** — multi-task lifecycle per project: `init → constitution → new → clarify → plan → review → track → aar → done → next task`
- **Artifacts on disk** — one directory and six markdown files per task; `00-STATE.md` is the anchor for cross-session resumption
- **Lightweight alignment** — give decision-makers multiple choice (A/B/C + recommendation + risk + contingency), one page, ≤15 minutes, conclusion in the first 30 seconds
- **Scaled by rework cost** — routine tasks need only a 30-second pass over the five elements; full five-stage runs are reserved for dedicated projects; incidents get an after-action AAR
- **Zero dependencies** — pure markdown, no code, no runtime; any agent that can read files can run it

## 📦 Installation

### WorkBuddy (native skill)

```bash
cp -r core/ ~/.workbuddy/skills/task-kit/
```

After restarting the session it triggers semantically — just say "task.init <project>".

### Claude Code (Agent Skills, recommended)

```bash
cp -r core/ ~/.claude/skills/task-kit/
```

Claude Code shares the same SKILL.md convention as WorkBuddy and loads it on demand.

### Claude Code (slash command, fallback)

```bash
mkdir -p .claude/commands && cp adapters/claude-code-command.md .claude/commands/task-kit.md
```

Then invoke with `/task-kit advance <task>`.

### claude.ai (web)

Settings → Capabilities → Skills: upload this repository as a zip (SKILL.md must be at the top level or one directory deep).

### Cursor / ChatGPT / Other Agents

Paste all of `adapters/portable-rules.md` into your rules file (`.cursorrules`, Custom Instructions, system prompt, etc.). That version is self-contained with template structures inlined.

## 🚀 Quick Start

```
You: task.init warehouse system selection
AI:  Created .task-kit/ skeleton. No constitution yet — recommend setting one first:
     what are this project's priorities?
You: task.constitution (…generates CONSTITUTION.md after a short dialogue)
You: task.new picking-system research
AI:  Task directory created. First, the five elements — why now? What does done
     look like? …
You: (answers)
AI:  Restating for confirmation: "I understand this as … the final deliverable
     is …" — after confirmation, the problem definition is written to disk.
You: task.plan / task.review / task.track / task.aar …
```

Task artifacts live in the project's `.task-kit/` directory:

```
.task-kit/
├── CONSTITUTION.md        # project constitution
├── PROJECT.md             # project index + backlog
└── tasks/NNN-slug/
    ├── 00-STATE.md        # state card (cross-session anchor)
    ├── 01-problem.md      # problem definition
    ├── 02-plan.md         # plan skeleton
    ├── 03-review.md       # review card
    ├── 04-log.md          # execution log (append-only)
    └── 05-aar.md          # retrospective card
```

## 📁 Repository Structure

```
task_kit/
├── README.md                          # this file (Chinese)
├── README.en.md                       # English version
├── LICENSE                            # MIT
├── docs/
│   └── spec-driven.md                 # methodology in depth: rationale, five stages, scaling rules
├── core/
│   ├── SKILL.md                       # workflow definition (Agent Skills format)
│   ├── scripts/
│   │   └── task-new.sh                # optional scaffold: auto-numbered task directories
│   └── templates/                     # 8 stage templates
│       ├── 00-constitution.md         # constitution (version + Sync Impact Report + governance)
│       ├── 00-project.md              # project index
│       ├── 01-problem.md              # problem definition
│       ├── 02-plan.md                 # plan skeleton
│       ├── 03-review.md               # review card
│       ├── 04-log.md                  # execution log
│       ├── 05-aar.md                  # AAR retrospective card
│       └── checklist.md               # quality-gate checklist (written by task.check)
└── adapters/
    ├── claude-code-command.md         # Claude Code slash-command adapter
    └── portable-rules.md              # universal rules for any agent (self-contained)
```

## 🆕 v1.1.0 — Aligned with Spec Kit's Engineering Form

- **Numbered task directories**: `tasks/NNN-slug/` (e.g. `tasks/001-rgbd-research`); three-digit ordering for sortability and cross-session location; legacy unnumbered directories remain compatible
- **Constitution amendment discipline**: semantic versioning (MAJOR/MINOR/PATCH) + a Sync Impact Report header + governance rules
- **Persisted quality gates**: `task.check` writes `checklists/<type>.md` with CHKxxx IDs and reviewer-owned semantics (`[x]` = reviewed and satisfied, ≠ work completed)
- **Task directory extension zones**: `00-05` reserved for core contracts; assets go in `materials/`, quality gates in `checklists/`, task-specific artifacts numbered from `06`
- **Explicit gate semantics**: clarify/review act as approve/reject gates; a failed gate blocks the next stage
- **Optional scaffold**: `core/scripts/task-new.sh` auto-numbers directories and initializes 00-STATE.md (zero-dependency bash; without it, follow the numbering rule manually)

## 🧭 Methodology Lineage

The McKinsey seven-step method / MECE / the Pyramid Principle (SCQA) provide the skeleton; hypothesis-driven work (Day-1 answer) and benefit closure come from standard consulting practice; PDCA supplies the loop; Spec Kit contributes the engineering form of contracts and stage gates. Heavy consulting deliverables (steering committees, multi-workgroup structures, QC chains) are deliberately omitted — this system is a **working method for individuals and small-to-mid teams**, not a consulting delivery methodology. See [docs/spec-driven.md](docs/spec-driven.md).

## 🤝 Contributing

Issues and PRs welcome: new task-type scaling rules, new platform adapters, template improvements.

## 📄 License

[MIT](LICENSE)
