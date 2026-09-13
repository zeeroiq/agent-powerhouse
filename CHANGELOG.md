# Changelog

All notable changes to Agent Powerhouse will be documented in this file.

The format is inspired by Keep a Changelog and follows Semantic Versioning.

---

## [1.1.0] - 2026-09-13

### Added

#### Claude Code Marketplace & Modular Plugins
- Published repository as a Claude Code marketplace (`.claude-plugin/marketplace.json`) hosting three modular plugins:
  - `agent-powerhouse-core`: 10 general engineering skills (`agentic-engineering`, `ai-first-engineering`, `api-design`, `architecture-decision-records`, `backend-patterns`, `deep-research`, `domain-modeling`, `grill-me`, `grill-with-docs`, `grilling`) and 9 autonomous agents (`architect`, `code-architect`, `code-explorer`, `code-simplifier`, `less-is-more`, `loop-operator`, `planner`, `silent-failure-hunter`, `tdd-guide`).
  - `agent-powerhouse-frontend`: 4 frontend/UI skills (`frontend-champion`, `frontend-design-direction`, `frontend-patterns`, `design-system`) and 2 specialized agents (`react-reviewer`, `react-build-resolver`).
  - `agent-powerhouse-java`: 9 enterprise Java skills (`java-coding-standards`, `jpa-patterns`, `quarkus-patterns`, `quarkus-security`, `quarkus-tdd`, `springboot-patterns`, `springboot-security`, `springboot-tdd`, `springboot-verification`) and 2 specialized agents (`java-reviewer`, `java-build-resolver`).
- Added official Claude Code `.claude-plugin/plugin.json` manifests and dedicated documentation READMEs for each plugin.
- Added multi-path skill registration in `skills.json` for cross-platform compatibility with Antigravity and skills CLI.

### Changed
- Reorganized codebase into `plugins/<domain>/skills/` and `plugins/<domain>/agents/` without mutating skill instructions or agent frontmatter.
- Updated `AGENTS.md` mandatory hard hook path to `plugins/frontend/skills/frontend-champion/SKILL.md` and expanded agent registry to all 13 specialized agents.
- Reconciled `README.md` repository structure, skill contract, and integration support to match current implementation.

---

## [1.0.0] - 2026-06-16

### Added

#### Repository Foundation

- Initial repository structure
- Skill registry architecture
- Framework architecture
- Integration architecture
- Example and testing structure

#### Core Frameworks

- Engineering Principles framework
- Severity Model framework
- Architecture Principles framework
- Review Output Format framework

#### Skills

- Senior Engineering Code Review v1.0.0

#### Documentation

- README
- CHANGELOG
- LICENSE
- Contribution guidelines structure

#### Future Skill Roadmap

Planned skills:

- Security Review
- Root Cause Analysis
- Production Readiness Review
- System Design Review
- Spring Boot Review
- Java Performance Review
- Database Review
- Kafka Review
- Google L5 Interviewer
- DSA Tutor

---

## Upcoming

### 1.1.0

Planned:

- Root Cause Analysis Skill
- Security Review Skill
- Production Readiness Review Skill

### 1.2.0

Planned:

- Spring Boot Review Skill
- Java Performance Review Skill
- Database Review Skill

### 2.0.0

Planned:

- Skill dependency resolution
- Composite skill execution
- Skill version compatibility matrix
- Automated skill testing framework
