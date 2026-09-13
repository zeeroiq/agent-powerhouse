# Agent Powerhouse — Frontend Plugin (`agent-powerhouse-frontend`)

Production-grade UI/UX engineering skills and specialized review agents for React, TypeScript, design systems, and frontend architecture.

## Standards Compliance

All skills and agents in this plugin adhere to the operational guidelines defined in [PRO_STANDARDS.md](../../PRO_STANDARDS.md). This guarantees grounded execution, zero placeholder tolerance, compulsory verification, and production-grade engineering output.

---

## Installation

### Via Claude Code Marketplace

```bash
# Add the marketplace catalog
claude plugin marketplace add zeeroiq/agent-powerhouse

# Install the frontend plugin
/plugin install agent-powerhouse-frontend
```

### Local Development / Direct Link

From your Claude Code session or project settings:
```json
{
  "plugins": [
    "./plugins/frontend"
  ]
}
```

---

## Included Skills

| Skill | Description | Location |
|-------|-------------|----------|
| `frontend-champion` | Elite frontend engineering, mandatory design judgment gate, modern UX aesthetics, and zero-compromise design standards. | [skills/frontend-champion](skills/frontend-champion/SKILL.md) |
| `frontend-design-direction` | Establishes visual hierarchy, typographic scales, layout rhythm, and product-specific design direction. | [skills/frontend-design-direction](skills/frontend-design-direction/SKILL.md) |
| `frontend-patterns` | Modern React, Next.js, state management, and performance optimization patterns. | [skills/frontend-patterns](skills/frontend-patterns/SKILL.md) |
| `design-system` | Design token architecture, component primitive auditing, and visual consistency enforcement. | [skills/design-system](skills/design-system/SKILL.md) |

---

## Included Agents

| Agent | Role & Capabilities | File |
|-------|---------------------|------|
| `react-reviewer` | Code reviewer for React, Vite, Next.js, TypeScript, component contracts, hooks discipline, and accessibility. | [agents/react-reviewer.md](agents/react-reviewer.md) |
| `react-build-resolver` | Specialized agent to diagnose and resolve Vite, Webpack, TypeScript, and React compilation/bundling errors. | [agents/react-build-resolver.md](agents/react-build-resolver.md) |
