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

# Installation

You can install Agent Powerhouse plugins and skills using Claude Code or other compatible agent environments.

## 1. Claude Code Marketplace (Recommended)

Agent Powerhouse is distributed as a Claude Code marketplace catalog hosting three modular plugins:

```bash
# Add the marketplace catalog
claude plugin marketplace add zeeroiq/agent-powerhouse

# Install the plugins you need
/plugin install agent-powerhouse-core
/plugin install agent-powerhouse-frontend
/plugin install agent-powerhouse-java
```

For local repository development or offline workspace linking:
```json
{
  "plugins": [
    "./plugins/core",
    "./plugins/frontend",
    "./plugins/java"
  ]
}
```

## 2. Using GitHub CLI (gh)

If you have the `gh skill` extension installed, you can add this repository easily:

**Global Installation:**
```bash
gh skill install zeeroiq/agent-powerhouse --global
```

**Workspace-Level Installation:**
```bash
gh skill install zeeroiq/agent-powerhouse
```

## 3. Using NPM / NPX

You can use the `skills` CLI package to add these skills:

**Install all skills globally:**
```bash
npx skills add all zeeroiq/agent-powerhouse --global
```

**Install all skills to the current workspace:**
```bash
npx skills add all zeeroiq/agent-powerhouse
```

**Install individual skills:**
```bash
npx skills add api-design zeeroiq/agent-powerhouse
npx skills add backend-patterns zeeroiq/agent-powerhouse
```

## 4. Manual Antigravity Installation

Antigravity natively supports the structure of this repository. You can install these skills either globally or on a per-workspace basis manually.

### Global Installation (Recommended)
This makes the skills available to Antigravity across all your projects.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/agent-powerhouse/agent-powerhouse.git ~/.agent-powerhouse
   ```
2. **Open your global Antigravity config:**
   Navigate to `~/.gemini/config/`. If `skills.json` does not exist, create it.
3. **Add the inheritance path:**
   Update the `inherits` array to point to the repository's `skills.json` file.
   ```json
   {
     "inherits": [
       { "path": "~/.agent-powerhouse/skills.json" }
     ]
   }
   ```

### Workspace-Level Installation
This makes the skills available only in a specific project.

1. Clone or submodule the repository into your project (e.g., `vendor/agent-powerhouse`).
2. In your project's root, create `.agents/skills.json` (if it doesn't exist).
3. Add the inheritance path:
   ```json
   {
     "inherits": [
       { "path": "vendor/agent-powerhouse/skills.json" }
     ]
   }
   ```

## 5. GitHub Copilot Installation

GitHub Copilot relies on custom instructions placed within the target repository.

1. **Copy the Copilot Instructions:**
   Copy `.github/copilot-instructions.md` from this repository to your target repository's `.github/` folder.
2. **Include the Skills Directory:**
   Copy the relevant `plugins/<plugin>/skills/` directory from this repository into your target project. 
3. **Usage:**
   Copilot will automatically read the `.github/copilot-instructions.md` file. This file contains baseline rules and explicitly instructs Copilot to consult the skills directory when performing tasks.

---

# Integration Support

Current target platforms:

| Platform | Status |
|-----------|----------|
| Claude Code | Supported (Marketplace: `claude plugin marketplace add zeeroiq/agent-powerhouse`) |
| Cursor | Planned |
| Gemini CLI | Planned |
| OpenClaw | Planned |
| Roo Code | Planned |
| Cline | Planned |

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
