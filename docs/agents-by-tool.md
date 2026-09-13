# Agent Capabilities and Portability Across AI Tools

This document maps how the 13 specialized agents in Agent Powerhouse operate across different AI coding environments (Claude Code, Cursor, Codex, GitHub Copilot, and Google Antigravity).

---

## 1. The Cross-Tool Reality of "Agents"

Unlike the **Agent Skills standard** (`SKILL.md`), which has become an open, cross-vendor standard adopted by Claude Code, Cursor, Codex, Copilot, and Antigravity, **there is currently no universal cross-tool specification for autonomous subagents**.

Each tool implements agentic delegation differently:
- **Claude Code**: Supports discrete subagents defined via markdown files in `agents/*.md` with YAML frontmatter (`name`, `description`, `model`, `tools`). Claude Code can autonomously spin up subagents via its subagent execution mechanism.
- **Cursor**: Operates primarily via Cursor Composer / Agent mode. Cursor does not use Claude Code's `agents/*.md` format. While Cursor has introduced agent modes and experimental subagents, they use Cursor-specific configuration (`.cursor/rules/*.mdc` or Cursor Agent settings), and tool access is tied to Cursor's native editor capabilities.
- **OpenAI Codex**: Operates through repository instructions (`AGENTS.md`) and direct skill execution. Does not provide a file-driven `agents/*.md` subagent dispatcher.
- **GitHub Copilot**: Operates through Copilot Chat / Agent Mode in VS Code and GitHub.com workflows. Customization is driven by instructions (`.github/copilot-instructions.md`, `.github/instructions/*.instructions.md`) and Agent Skills, not independent subagent definitions.
- **Google Antigravity**: Provides native multi-agent orchestration (`invoke_subagent`, `define_subagent`) with parent-child conversation trees, but uses its own runtime harness rather than reading Claude Code's `plugin.json` agent registries directly.

---

## 2. Cross-Tool Capability Matrix

| Agent Name | Domain | Primary Subagent Role | Fallback When Tool Has No Subagents (Primary Model Mode) | Companion Skill |
|------------|--------|-----------------------|----------------------------------------------------------|-----------------|
| `planner` | Core | Multi-phase implementation planning & dependency graphs | Primary model creates phased plan before writing code ([PRO_STANDARDS §1](../../PRO_STANDARDS.md)) | `.agents/skills/agentic-engineering` |
| `architect` | Core | System design, distributed architecture & scalability | Primary model produces architectural trade-off matrix & ADR | `.agents/skills/architecture-decision-records` |
| `code-architect` | Core | Module boundaries & structural refactoring | Primary model enforces bounded contexts & file size limits | `.agents/skills/domain-modeling` |
| `code-explorer` | Core | Codebase discovery, call graph & navigation | Primary model performs tool-first inspection before proposing edits | `.agents/skills/deep-research` |
| `code-simplifier` | Core | Cognitive load reduction & dead code elimination | Primary model simplifies complex control flow (<50 lines/fn) | `.agents/skills/backend-patterns` |
| `less-is-more` | Core | Aggressive minimalism & YAGNI enforcement | Primary model strips speculative abstractions & dead code | `.agents/skills/ai-first-engineering` |
| `loop-operator` | Core | Autonomous loop monitoring & stall intervention | Primary model self-monitors iterative progress and breaks loops | `.agents/skills/agentic-engineering` |
| `silent-failure-hunter` | Core | Detects swallowed exceptions & false-success traps | Primary model defensively audits error handling ([PRO_STANDARDS §5](../../PRO_STANDARDS.md)) | `.agents/skills/backend-patterns` |
| `tdd-guide` | Core | Test-driven development (Red-Green-Refactor, 80%+ cov) | Primary model strictly writes failing test before implementation | `.agents/skills/agentic-engineering` |
| `react-reviewer` | Frontend | React, Next.js, hooks, accessibility code review | Primary model self-reviews frontend diffs against design gates | `.agents/skills/frontend-champion` |
| `react-build-resolver` | Frontend | Vite, Webpack, TypeScript bundling error remediation | Primary model isolates syntax/type errors from bundler configs | `.agents/skills/frontend-patterns` |
| `java-reviewer` | Java | Java, Spring Boot, Quarkus clean architecture review | Primary model enforces immutability, records, and security | `.agents/skills/java-coding-standards` |
| `java-build-resolver` | Java | Maven, Gradle compilation & dependency resolution | Primary model diagnoses classpath/dependency tree conflicts | `.agents/skills/springboot-verification` |

---

## 3. How to Use Agent Knowledge in Non-Claude Tools

If your tool does not support discrete subagent delegation:
1. **Persona / Mode Ingestion**: You can load an agent's prompt from `plugins/<domain>/agents/<agent-name>.md` directly into your conversation context or custom prompt rules.
2. **Companion Skill Activation**: Each agent's core procedural expertise is duplicated or mirrored in an open `SKILL.md` file under `.agents/skills/`. Activating the companion skill brings the agent's full domain expertise into the primary conversation.
3. **Engineering Standard Enforcement**: All agents derive their rigor from [PRO_STANDARDS.md](../../PRO_STANDARDS.md). Loading `PRO_STANDARDS.md` in any AI tool immediately enforces the agentic behavior (plan-then-act, tool grounding, zero placeholders, compulsory verification).
