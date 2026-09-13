# Agent Powerhouse

A vendor-neutral collection of reusable engineering skills for coding agents.

Agent Powerhouse provides a structured, versioned, and testable skill ecosystem that can be consumed by:

- Claude Code
- Gemini CLI
- Cursor
- OpenClaw
- Roo Code
- Cline
- Aider
- Continue
- Custom LLM Agents
- Future AI coding assistants

The goal is to create a consistent engineering operating system that applies the same standards regardless of which model executes the skill.

---

## Vision

Most teams spend significant effort repeatedly teaching AI assistants:

- How to review code
- How to perform root cause analysis
- How to review system designs
- How to evaluate security
- How to prepare for interviews
- How to teach algorithms

Agent Powerhouse solves this by maintaining reusable, versioned, and composable skills.

Think of it as:

> Kubernetes Helm Charts for Engineering Intelligence

---

## Core Principles

### Vendor Neutral

Skills should work across multiple AI platforms.

### Reusable

A skill should be usable by any coding agent with minimal adaptation.

### Composable

Skills should build on shared frameworks rather than duplicate logic.

### Testable

Every skill should contain examples and expected outputs.

### Versioned

Skills evolve independently and maintain change history.

---

# Repository Structure

```text
agent-powerhouse/
├── .claude-plugin/
│   └── marketplace.json            # Claude Code marketplace catalog
├── plugins/
│   ├── core/                       # Core engineering process plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── skills/                 # 10 general engineering skills
│   │   ├── agents/                 # 9 autonomous agents
│   │   └── README.md
│   ├── frontend/                   # Frontend & UI/UX engineering plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── skills/                 # 4 UI/UX & design skills
│   │   ├── agents/                 # 2 React review & build agents
│   │   └── README.md
│   └── java/                       # Java, Spring Boot & Quarkus plugin
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── skills/                 # 9 Java & enterprise skills
│       ├── agents/                 # 2 Java review & build agents
│       └── README.md
├── skills.json                     # Multi-path skill registration
├── AGENTS.md                       # Orchestration & hooks
├── PRO_STANDARDS.md                # Quality & prompt standards
├── CHANGELOG.md
├── LICENSE
└── README.md
```

---

# Plugins & Marketplace Architecture

Agent Powerhouse is packaged as a modular Claude Code marketplace (`.claude-plugin/marketplace.json`) hosting three specialized plugins:

1. **`agent-powerhouse-core`** (`plugins/core`): General engineering process skills (planning, architecture, TDD, debugging, research, adversarial design interrogation) and 9 autonomous agents (`planner`, `architect`, `tdd-guide`, `code-architect`, `code-explorer`, `code-simplifier`, `less-is-more`, `loop-operator`, `silent-failure-hunter`).
2. **`agent-powerhouse-frontend`** (`plugins/frontend`): UI/UX standards, design system governance, and React engineering skills with specialized review and build error resolution agents (`react-reviewer`, `react-build-resolver`).
3. **`agent-powerhouse-java`** (`plugins/java`): Enterprise Java, Spring Boot, Quarkus, JPA/Hibernate, and cloud-native backend skills with specialized review and build resolver agents (`java-reviewer`, `java-build-resolver`).

---

# Skills & Agents

### Skills (`SKILL.md`)

Each skill encapsulates a specific engineering capability and lives in its own directory within a plugin's `skills/` folder:

```text
plugins/<plugin>/skills/<skill-name>/
└── SKILL.md
```

Every `SKILL.md` uses native Claude Code / Antigravity skill format with YAML frontmatter specifying `name` and `description`, followed by unambiguous operational guidelines, step-by-step procedures, failure modes, and verification gates.

### Agents (`<agent-name>.md`)

Autonomous subagents live within a plugin's `agents/` folder:

```text
plugins/<plugin>/agents/<agent-name>.md
```

Each agent defines role-specific frontmatter (`name`, `description`, `model`, `tools`) and an exhaustive system prompt governing autonomous execution, code review, or build remediation.

---

# Standards & Skill Contract

All skills and agents in this repository adhere to the non-negotiable operational bar defined in [PRO_STANDARDS.md](PRO_STANDARDS.md):

- **Plan Before Action:** Formulate an explicit plan, decompose dependencies, and state assumptions before writing code.
- **Tool-First Grounding:** Never answer from memory when ground-truth files, tests, or configurations exist in the workspace.
- **Zero Placeholder Tolerance:** No `// TODO`, stub mocks, or truncated boilerplate. Deliver complete, runnable code.
- **Compulsory Verification:** Self-audit against requirements and verify builds/tests before reporting completion.
- **Defensive Design:** Explicit handling for timeouts, concurrency, nulls, and boundary failures; zero silent error swallowing.
- **80%+ Test Coverage:** Behavior-driven unit, integration, and flow tests for all non-trivial logic.

---

# Marketplace Catalog

The repository root defines `.claude-plugin/marketplace.json`, allowing teams and developers to install any or all plugins directly via Claude Code:

```json
{
  "name": "agent-powerhouse",
  "owner": {
    "name": "zeeroiq"
  },
  "plugins": [
    {
      "name": "agent-powerhouse-core",
      "source": "./plugins/core",
      "description": "General engineering process skills and autonomous agents for planning, architecture, TDD, and debugging.",
      "version": "1.0.0"
    },
    {
      "name": "agent-powerhouse-frontend",
      "source": "./plugins/frontend",
      "description": "Frontend, UI/UX, and design system skills with React review and build resolver agents.",
      "version": "1.0.0"
    },
    {
      "name": "agent-powerhouse-java",
      "source": "./plugins/java",
      "description": "Java, Spring Boot, and Quarkus engineering skills and review agents.",
      "version": "1.0.0"
    }
  ]
}
```

---

# Plugin Inventory

## Core Plugin (`agent-powerhouse-core`)

- **Skills:** `agentic-engineering`, `ai-first-engineering`, `api-design`, `architecture-decision-records`, `backend-patterns`, `deep-research`, `domain-modeling`, `grill-me`, `grill-with-docs`, `grilling`
- **Agents:** `architect`, `code-architect`, `code-explorer`, `code-simplifier`, `less-is-more`, `loop-operator`, `planner`, `silent-failure-hunter`, `tdd-guide`

## Frontend Plugin (`agent-powerhouse-frontend`)

- **Skills:** `frontend-champion`, `frontend-design-direction`, `frontend-patterns`, `design-system`
- **Agents:** `react-reviewer`, `react-build-resolver`

## Java Plugin (`agent-powerhouse-java`)

- **Skills:** `java-coding-standards`, `jpa-patterns`, `quarkus-patterns`, `quarkus-security`, `quarkus-tdd`, `springboot-patterns`, `springboot-security`, `springboot-tdd`, `springboot-verification`
- **Agents:** `java-reviewer`, `java-build-resolver`

---

# How This Repository Stays Provider-Agnostic

Agent Powerhouse delivers both **Claude Code Marketplace modularity** and **universal Agent Skills interoperability** without duplicating source files:

1. **Single Source of Truth (`plugins/`):** The authoritative skill definitions and autonomous agent prompts live under `plugins/<domain>/skills/` and `plugins/<domain>/agents/`.
2. **Universal Open Standard Surface (`.agents/skills/`):** All 23 skills are exposed as a flat, un-nested directory tree at `.agents/skills/` via relative symlinks, conforming strictly to the open [Agent Skills specification](https://agentskills.io) adopted across the industry.
3. **Compatibility Mirror (`.claude/skills/`):** Symlinks mirror `.agents/skills/` into `.claude/skills/`, providing out-of-the-box discovery for Cursor compatibility paths and direct repository vendoring in Claude Code without marketplace installation.
4. **Automated Drift Prevention (`scripts/sync-skills.sh`):** A verification script ensures bidirectional parity in CI (`./scripts/sync-skills.sh --check`), with `--copy` fallback support for file systems where symlinks are restricted.
5. **Unified Instructions & Bridge (`AGENTS.md` & `CLAUDE.md`):** Core engineering rules live in `AGENTS.md`. A root `CLAUDE.md` file imports `@AGENTS.md`, ensuring all agent environments execute identical behavioral standards.
6. **Agent Fallback Architecture (`docs/agents-by-tool.md`):** Autonomous agent definitions (`agents/*.md`) map seamlessly to primary model personas and companion skills in tools that lack discrete subagent execution engines.

---

# Installation

You can install Agent Powerhouse plugins and skills using Claude Code, Cursor, Codex, Antigravity, GitHub Copilot, or any tool supporting the open Agent Skills specification.

## 1. Claude Code Marketplace

Agent Powerhouse is distributed as a Claude Code marketplace catalog hosting three modular plugins:

```bash
# Add the marketplace catalog
claude plugin marketplace add zeeroiq/agent-powerhouse

# Install the plugins you need
/plugin install agent-powerhouse-core
/plugin install agent-powerhouse-frontend
/plugin install agent-powerhouse-java
```

For direct repository vendoring or offline workspace linking without marketplace installation, Claude Code automatically discovers `.claude/skills/` and instructions via `CLAUDE.md`.

## 2. Cursor

Cursor natively discovers all 23 skills from `.agents/skills/` (and `.claude/skills/`) and enforces guidelines from `AGENTS.md`:

1. Clone or submodule this repository into your workspace (e.g. `vendor/agent-powerhouse`).
2. Alternatively, symlink or copy `.agents/skills/` into your project's `.agents/skills/` or `.cursor/skills/`.
3. Cursor automatically loads skill metadata at session startup and activates skills progressively on demand.

## 3. OpenAI Codex

Codex natively discovers the open Agent Skills format:

1. Place or link `.agents/skills/` at the root of your repository.
2. Ensure `AGENTS.md` is at your project root to provide operational rules.

## 4. Google Antigravity

Antigravity natively discovers workspace customizations:

### Workspace Discovery
Opening this repository in Antigravity automatically detects:
- All 23 skills in `.agents/skills/`
- Workspace rules in `AGENTS.md` and `PRO_STANDARDS.md`
- Non-standard declared paths in `skills.json`

### Global Antigravity Installation
To make all skills available across all projects:
1. Clone the repository to `~/.agent-powerhouse`:
   ```bash
   git clone https://github.com/zeeroiq/agent-powerhouse.git ~/.agent-powerhouse
   ```
2. In `~/.gemini/config/skills.json` (create if missing), inherit the catalog:
   ```json
   {
     "inherits": [
       { "path": "~/.agent-powerhouse/skills.json" }
     ]
   }
   ```

## 5. GitHub Copilot

GitHub Copilot supports workspace instructions and Agent Skills:

1. **Instructions:** Copy `.github/copilot-instructions.md` to your repository's `.github/` folder.
2. **Skills:** Include or link `.agents/skills/` in your repository. Copilot Chat and Copilot coding agents consult `.agents/skills/` for domain-specific tasks.

## 6. Open Agent Skills CLI (`npx skills`)

The open `skills` CLI (by `skills.sh` / Vercel Labs) discovers skills directly from this repository:

```bash
# List all available skills in this repository
npx skills add zeeroiq/agent-powerhouse --list

# Install all skills into your active agent
npx skills add zeeroiq/agent-powerhouse --skill '*'

# Install a specific skill
npx skills add zeeroiq/agent-powerhouse --skill frontend-champion
```

> **Windows Note on Symlinks:** On Windows, Git requires developer mode or `git config core.symlinks true` to materialize symlinks. If symlinks are unavailable on your filesystem, run `./scripts/sync-skills.sh --copy` to replace symlinks with direct directory copies.

---

# Integration Support

| Platform / Client | Status | Discovery & Operational Mechanism |
|-------------------|--------|-----------------------------------|
| **Claude Code** | Supported | Marketplace catalog (`zeeroiq/agent-powerhouse`) or `.claude/skills/` + `CLAUDE.md` bridge |
| **Cursor** | Supported | Native `.agents/skills/` & `.claude/skills/` discovery; rules via `AGENTS.md` |
| **OpenAI Codex** | Supported | Native `.agents/skills/` discovery & root `AGENTS.md` instructions |
| **Google Antigravity** | Supported | Native `.agents/skills/` discovery, root `AGENTS.md`, and `skills.json` manifest |
| **GitHub Copilot** | Supported (Verified Surfaces) | Copilot Chat & Coding Agent via `.github/copilot-instructions.md`; VS Code Agent mode via `.agents/skills/` |
| **Gemini CLI** | Supported | Native `.agents/skills/` discovery & declared `skills.json` |
| **OpenClaw** | Supported | Native `.agents/skills/` discovery (per Agent Skills standard) |
| **Roo Code** | Supported | Native `.agents/skills/` discovery |
| **Cline** | Supported | Native `.agents/skills/` discovery |

---

# Roadmap

Phase 1

- Senior Code Review
- Root Cause Analysis
- Security Review
- Production Readiness Review

Phase 2

- Spring Boot Review
- Java Performance Review
- Kafka Review
- Database Review

Phase 3

- Google L5 Interviewer
- DSA Tutor
- System Design Coach

---

# Contributing

Contributions are welcome.

When creating skills:

1. Reuse existing frameworks.
2. Avoid duplicating logic.
3. Provide examples.
4. Provide tests.
5. Maintain backward compatibility when possible.

---

# License

MIT License

See LICENSE for details.
