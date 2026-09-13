# APH - The AgentPowerHouse — Agent Instructions

This repository provides a **vendor-neutral AI coding ecosystem** containing 23 open Agent Skills (standardized at `.agents/skills/`) and 13 specialized engineering agent definitions. It is natively compatible with Cursor, OpenAI Codex, GitHub Copilot, Google Antigravity, and Claude Code.

**Version:** 1.2.0

## Harness Compatibility & Discovery

- **Native `AGENTS.md` readers** (Antigravity, Cursor, Codex) automatically load this file at repository root.
- **Claude Code** natively reads `CLAUDE.md`; a root `CLAUDE.md` file is provided that imports `@AGENTS.md` so instructions stay unified across all tools without drift.
- **Agent Delegation Support**: For tools without discrete subagent mechanics, the primary model adopts the agent's role directly or loads its companion skill. See [docs/agents-by-tool.md](docs/agents-by-tool.md) for tool-by-tool mapping.

## Mandatory Project Instructions

> **CRITICAL INSTRUCTION:** For ANY frontend, UI, or UX work — however small — read `.agents/skills/frontend-champion/SKILL.md` in full before writing or discussing code. This is a mandatory, blocking rule before designing, editing, or discussing any UI component, screen, styling, layout, or interaction.

## Core Principles

1. **Agent-First** — Delegate to specialized agents (or adopt their persona) for domain tasks
2. **Test-Driven** — Write tests before implementation, 80%+ coverage required
3. **Security-First** — Never compromise on security; validate all inputs
4. **Immutability** — Always create new objects, never mutate existing ones
5. **Plan Before Execute** — Plan complex features before writing code

## Available Agents

| Agent | Domain | Purpose | When to Use | Companion Skill |
|-------|--------|---------|-------------|-----------------|
| planner | Core | Implementation planning | Complex features, refactoring | `.agents/skills/agentic-engineering` |
| architect | Core | System design and scalability | Architectural decisions | `.agents/skills/architecture-decision-records` |
| code-architect | Core | Module design and structural boundaries | Refactoring, modularization | `.agents/skills/domain-modeling` |
| code-explorer | Core | Codebase discovery and navigation | Unfamiliar code, dependency mapping | `.agents/skills/deep-research` |
| code-simplifier | Core | Cognitive load and code reduction | Simplifying complex logic, cleanup | `.agents/skills/backend-patterns` |
| less-is-more | Core | Aggressive minimalism enforcement | Removing dead code, reducing bloat | `.agents/skills/ai-first-engineering` |
| loop-operator | Core | Autonomous loop execution | Run loops safely, monitor stalls, intervene | `.agents/skills/agentic-engineering` |
| silent-failure-hunter | Core | Catch swallowed errors and false success | Debugging, auditing error handling | `.agents/skills/backend-patterns` |
| tdd-guide | Core | Test-driven development | New features, bug fixes | `.agents/skills/agentic-engineering` |
| react-reviewer | Frontend | React js/jsx/typescript code review | React/Vite/Next.js projects | `.agents/skills/frontend-champion` |
| react-build-resolver | Frontend | React/Vite/Webpack build errors | Frontend build and bundle failures | `.agents/skills/frontend-patterns` |
| java-reviewer | Java | Java and Spring Boot code review | Java/Spring Boot/Quarkus projects | `.agents/skills/java-coding-standards` |
| java-build-resolver | Java | Java/Maven/Gradle build errors | Java build and compilation failures | `.agents/skills/springboot-verification` |

*If your tool does not support discrete subagent delegation, consult [docs/agents-by-tool.md](docs/agents-by-tool.md) to apply the agent's role directly in the primary conversation.*

## Agent Orchestration

Use agents and skills proactively without user prompt:
- **Frontend / UI / UX work** → For ANY frontend, UI, or UX work — however small — read `.agents/skills/frontend-champion/SKILL.md` in full before writing or discussing code.
- Complex feature requests → **planner**
- Architectural decision → **architect**
- Bug fix or new feature → **tdd-guide**
- Code just written/modified (Java/Spring) → **java-reviewer**
- Code just written/modified (React/Frontend) → **react-reviewer**
- Build failures (Java) → **java-build-resolver**
- Build failures (React) → **react-build-resolver**
- Swallowed errors / suspicious silent bugs → **silent-failure-hunter**
- Autonomous loops / loop monitoring → **loop-operator**

Use parallel execution for independent operations — launch multiple agents simultaneously.

## Security Guidelines

**Before ANY commit:**
- No hardcoded secrets (API keys, passwords, tokens)
- All user inputs validated
- SQL injection prevention (parameterized queries)
- XSS prevention (sanitized HTML)
- CSRF protection enabled
- Authentication/authorization verified
- Rate limiting on all endpoints
- Error messages don't leak sensitive data

**Secret management:** NEVER hardcode secrets. Use environment variables or a secret manager. Validate required secrets at startup. Rotate any exposed secrets immediately.

**If security issue found:** STOP → use security-reviewer agent → fix CRITICAL issues → rotate exposed secrets → review codebase for similar issues.

## Coding Style

**Immutability (CRITICAL):** Always create new objects, never mutate. Return new copies with changes applied.

**File organization:** Many small files over few large ones. 200-400 lines typical, 800 max. Organize by feature/domain, not by type. High cohesion, low coupling.

**Error handling:** Handle errors at every level. Provide user-friendly messages in UI code. Log detailed context server-side. Never silently swallow errors.

**Input validation:** Validate all user input at system boundaries. Use schema-based validation. Fail fast with clear messages. Never trust external data.

**Code quality checklist:**
- Functions small (<50 lines), files focused (<800 lines)
- No deep nesting (>4 levels)
- Proper error handling, no hardcoded values
- Readable, well-named identifiers

## Testing Requirements

**Minimum coverage: 80%**

Test types (all required):
1. **Unit tests** — Individual functions, utilities, components
2. **Integration tests** — API endpoints, database operations
3. **E2E tests** — Critical user flows

**TDD workflow (mandatory):**
1. Write test first (RED) — test should FAIL
2. Write minimal implementation (GREEN) — test should PASS
3. Refactor (IMPROVE) — verify coverage 80%+

Troubleshoot failures: check test isolation → verify mocks → fix implementation (not tests, unless tests are wrong).

## Development Workflow

1. **Frontend / UI Gate** — For ANY frontend, UI, or UX work — however small — read `.agents/skills/frontend-champion/SKILL.md` in full before writing or discussing code.
2. **Plan** — Use planner agent, identify dependencies and risks, break into phases
3. **TDD** — Use tdd-guide agent, write tests first, implement, refactor
4. **Review** — Use code-reviewer agent immediately, address CRITICAL/HIGH issues
5. **Capture knowledge in the right place**
   - Personal debugging notes, preferences, and temporary context → auto memory
   - Team/project knowledge (architecture decisions, API changes, runbooks) → the project's existing docs structure
   - If the current task already produces the relevant docs or code comments, do not duplicate the same information elsewhere
   - If there is no obvious project doc location, ask before creating a new top-level file
6. **Commit** — Conventional commits format, comprehensive PR summaries

## Workflow Surface Policy

- `.agents/skills/` is the universal, vendor-neutral workflow surface (conforming to the open Agent Skills standard).
- `.claude/skills/` mirrors `.agents/skills/` for Cursor compatibility and direct Claude Code vendoring.
- `plugins/*/skills/` hosts the modular plugin packages for Claude Code's marketplace.
- `scripts/sync-skills.sh` ensures bidirectional parity between `plugins/*/skills/` and `.agents/skills/`.

## Git Workflow

**Commit format:** `<type>: <description>` — Types: feat, fix, refactor, docs, test, chore, perf, ci

**PR workflow:** Analyze full commit history → draft comprehensive summary → include test plan → push with `-u` flag.

## Architecture Patterns

**API response format:** Consistent envelope with success indicator, data payload, error message, and pagination metadata.

**Repository pattern:** Encapsulate data access behind standard interface (findAll, findById, create, update, delete). Business logic depends on abstract interface, not storage mechanism.

**Skeleton projects:** Search for battle-tested templates, evaluate with parallel agents (security, extensibility, relevance), clone best match, iterate within proven structure.

## Performance

**Context management:** Avoid last 20% of context window for large refactoring and multi-file features. Lower-sensitivity tasks (single edits, docs, simple fixes) tolerate higher utilization.

**Build troubleshooting:** Use build-error-resolver agent → analyze errors → fix incrementally → verify after each fix.

## Project Structure

```
.agents/skills/  — Universal Agent Skills surface (scanned by Cursor, Codex, Copilot, Antigravity)
.claude/skills/  — Compatibility skill mirror (scanned by Cursor and Claude Code)
plugins/
  core/          — 9 agents and 10 skills for general engineering, planning, and review
  frontend/      — 2 agents and 4 skills for UI/UX, React, and design systems
  java/          — 2 agents and 9 skills for Java, Spring Boot, and Quarkus
.claude-plugin/  — Claude Code marketplace catalog (marketplace.json)
scripts/         — Skill sync and CI verification utilities (sync-skills.sh)
docs/            — Cross-tool specifications (agents-by-tool.md)
skills.json      — Declared Antigravity / skills CLI path manifest
CLAUDE.md        — Claude Code instruction bridge (imports @AGENTS.md)
AGENTS.md        — Universal agent instructions and orchestration guidelines
PRO_STANDARDS.md — Non-negotiable engineering standards
```

## Success Metrics

- All tests pass with 80%+ coverage
- No security vulnerabilities
- Code is readable and maintainable
- Performance is acceptable
- User requirements are met