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

├── registry.yaml
│
├── frameworks/
│
├── skills/
│
├── integrations/
│
├── examples/
│
├── docs/
│
├── CHANGELOG.md
├── LICENSE
└── README.md
```

---

# Frameworks

Frameworks provide reusable standards shared across multiple skills.

Examples:

- Engineering Principles
- Severity Model
- Architecture Principles
- Review Output Format
- Security Standards
- Reliability Standards

Frameworks should remain generic and reusable.

---

# Skills

A skill encapsulates a specific engineering capability.

Examples:

- Senior Code Review
- Security Review
- Production Readiness Review
- Root Cause Analysis
- System Design Review
- Java Performance Review
- Spring Boot Review
- Kafka Review
- Google L5 Interviewer
- DSA Tutor

Each skill contains:

```text
skill-name/

├── skill.yaml
├── prompt.md
├── examples/
└── tests/
```

---

# Skill Contract

Every skill must provide:

## skill.yaml

Metadata and registration information.

## prompt.md

Primary instructions used by the agent.

## examples/

Representative examples.

## tests/

Expected outputs for validation.

---

# Registry

The registry acts as the source of truth.

Example:

```yaml
skills:
  - senior-code-review
  - security-review
  - debugging
```

---

# Creating a New Skill

Create a new folder:

```bash
skills/my-new-skill
```

Add:

```text
skill.yaml
prompt.md
examples/
tests/
```

Register the skill:

```yaml
skills:
  - my-new-skill
```

---

# Example Skill

```yaml
name: senior-code-review

version: 1.0.0

description: >
  Performs senior-level engineering code reviews.

inherits:
  - engineering-principles
  - severity-model

entrypoint: prompt.md
```

---

# Skill Categories

## Engineering Reviews

- Senior Code Review
- Security Review
- Database Review
- API Review

## Architecture

- System Design Review
- Microservices Review
- Cloud Architecture Review

## Operations

- Production Readiness Review
- Incident Analysis
- Root Cause Analysis

## Learning

- DSA Tutor
- Low Level Design Tutor
- High Level Design Tutor

## Interviewing

- Google L5 Interviewer
- Staff Engineer Interviewer

---

# Installation (Skills)

You can install Agent Powerhouse skills using CLI tools or configure them manually.

## 1. Using GitHub CLI (gh)

If you have the `gh skill` extension installed, you can add this repository easily:

**Global Installation:**
```bash
gh skill install zeeroiq/agent-powerhouse --global
```

**Workspace-Level Installation:**
```bash
gh skill install zeeroiq/agent-powerhouse
```

## 2. Using NPM / NPX

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

## 3. Manual Antigravity Installation

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

## 4. GitHub Copilot Installation

GitHub Copilot relies on custom instructions placed within the target repository.

1. **Copy the Copilot Instructions:**
   Copy `.github/copilot-instructions.md` from this repository to your target repository's `.github/` folder.
2. **Include the Skills Directory:**
   Copy the `skills/` directory from this repository into your target project. 
3. **Usage:**
   Copilot will automatically read the `.github/copilot-instructions.md` file. This file contains baseline rules and explicitly instructs Copilot to consult the `skills/` directory when performing tasks.

---

# Integration Support

Current target platforms:

| Platform | Status |
|-----------|----------|
| Claude Code | Planned |
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
