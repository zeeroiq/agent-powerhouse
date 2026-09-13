# Agent Powerhouse — Core Plugin (`agent-powerhouse-core`)

Production-ready general engineering process skills and autonomous agents for planning, system architecture, test-driven development, deep debugging, and adversarial design review.

## Standards Compliance

All skills and agents in this plugin adhere to the operational guidelines defined in [PRO_STANDARDS.md](../../PRO_STANDARDS.md). This ensures grounded execution, zero placeholder tolerance, compulsory verification, and production-grade engineering output.

---

## Installation

### Via Claude Code Marketplace

```bash
# Add the marketplace catalog
claude plugin marketplace add zeeroiq/agent-powerhouse

# Install the core plugin
/plugin install agent-powerhouse-core
```

### Local Development / Direct Link

From your Claude Code session or project settings:
```json
{
  "plugins": [
    "./plugins/core"
  ]
}
```

---

## Included Skills

| Skill | Description | Location |
|-------|-------------|----------|
| `agentic-engineering` | Operate as an agentic engineer using eval-first execution, decomposition, and cost-aware model routing. | [skills/agentic-engineering](skills/agentic-engineering/SKILL.md) |
| `ai-first-engineering` | Engineering operating model for teams where AI agents generate a large share of implementation output. | [skills/ai-first-engineering](skills/ai-first-engineering/SKILL.md) |
| `api-design` | REST API design patterns including resource naming, status codes, pagination, filtering, and error handling. | [skills/api-design](skills/api-design/SKILL.md) |
| `architecture-decision-records` | Capture architectural decisions as structured, versioned ADRs. | [skills/architecture-decision-records](skills/architecture-decision-records/SKILL.md) |
| `backend-patterns` | Backend architecture patterns, API design, database optimization, and server-side best practices. | [skills/backend-patterns](skills/backend-patterns/SKILL.md) |
| `deep-research` | Multi-source deep research using web search and synthesis with source attribution. | [skills/deep-research](skills/deep-research/SKILL.md) |
| `domain-modeling` | Domain modeling patterns and context boundary design with ADR and Context formats. | [skills/domain-modeling](skills/domain-modeling/SKILL.md) |
| `grill-me` | Interactive technical interview and design interrogation to harden plans before implementation. | [skills/grill-me](skills/grill-me/SKILL.md) |
| `grill-with-docs` | Technical interrogation grounded against official documentation and project artifacts. | [skills/grill-with-docs](skills/grill-with-docs/SKILL.md) |
| `grilling` | Core adversarial interrogation framework for architectural and system designs. | [skills/grilling](skills/grilling/SKILL.md) |

---

## Included Agents

| Agent | Role & Capabilities | File |
|-------|---------------------|------|
| `architect` | System design, scalability, distributed patterns, and architectural trade-offs. | [agents/architect.md](agents/architect.md) |
| `code-architect` | Software module design, structural refactoring, and component boundaries. | [agents/code-architect.md](agents/code-architect.md) |
| `code-explorer` | Codebase discovery, navigation, dependency mapping, and architectural tracing. | [agents/code-explorer.md](agents/code-explorer.md) |
| `code-simplifier` | Code reduction, cognitive load minimization, and complexity elimination. | [agents/code-simplifier.md](agents/code-simplifier.md) |
| `less-is-more` | Aggressive minimalism enforcer, dead code stripper, and YAGNI auditor. | [agents/less-is-more.md](agents/less-is-more.md) |
| `loop-operator` | Autonomous loop execution, monitoring stall detection, and proactive intervention. | [agents/loop-operator.md](agents/loop-operator.md) |
| `planner` | Detailed implementation planning, dependency graph decomposition, and phased rollout. | [agents/planner.md](agents/planner.md) |
| `silent-failure-hunter` | Detects swallowed exceptions, unhandled rejections, false-success fallbacks, and leaky boundaries. | [agents/silent-failure-hunter.md](agents/silent-failure-hunter.md) |
| `tdd-guide` | Test-driven development lifecycle (Red-Green-Refactor) targeting 80%+ behavior coverage. | [agents/tdd-guide.md](agents/tdd-guide.md) |
