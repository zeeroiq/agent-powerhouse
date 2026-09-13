# Agent Powerhouse — Java Plugin (`agent-powerhouse-java`)

Production-ready Java, Spring Boot, and Quarkus engineering skills with specialized code review and build error resolution agents.

## Standards Compliance

All skills and agents in this plugin adhere to the operational guidelines defined in [PRO_STANDARDS.md](../../PRO_STANDARDS.md). This guarantees grounded execution, zero placeholder tolerance, compulsory verification, and production-grade engineering output.

---

## Installation

### Via Claude Code Marketplace

```bash
# Add the marketplace catalog
claude plugin marketplace add zeeroiq/agent-powerhouse

# Install the Java plugin
/plugin install agent-powerhouse-java
```

### Local Development / Direct Link

From your Claude Code session or project settings:
```json
{
  "plugins": [
    "./plugins/java"
  ]
}
```

---

## Included Skills

| Skill | Description | Location |
|-------|-------------|----------|
| `java-coding-standards` | Idiomatic Java standards for Spring Boot and Quarkus: immutability, records, Optionals, streams, and exceptions. | [skills/java-coding-standards](skills/java-coding-standards/SKILL.md) |
| `jpa-patterns` | JPA/Hibernate patterns for entity design, relationship mapping, query optimization (N+1 prevention), and transactions. | [skills/jpa-patterns](skills/jpa-patterns/SKILL.md) |
| `quarkus-patterns` | Quarkus 3.x LTS architecture patterns with Camel messaging, Panache data access, CDI, and async processing. | [skills/quarkus-patterns](skills/quarkus-patterns/SKILL.md) |
| `quarkus-security` | Quarkus Security best practices for JWT/OIDC authentication, RBAC, input validation, and secrets management. | [skills/quarkus-security](skills/quarkus-security/SKILL.md) |
| `quarkus-tdd` | Test-driven development for Quarkus using JUnit 5, Mockito, REST Assured, and JaCoCo. | [skills/quarkus-tdd](skills/quarkus-tdd/SKILL.md) |
| `springboot-patterns` | Spring Boot architecture patterns, REST API design, layered services, caching, and async execution. | [skills/springboot-patterns](skills/springboot-patterns/SKILL.md) |
| `springboot-security` | Spring Security best practices for authentication, authorization, CSRF, security headers, and rate limiting. | [skills/springboot-security](skills/springboot-security/SKILL.md) |
| `springboot-tdd` | Test-driven development for Spring Boot using JUnit 5, Mockito, MockMvc, and Testcontainers. | [skills/springboot-tdd](skills/springboot-tdd/SKILL.md) |
| `springboot-verification` | Pre-flight verification loop: compile, static analysis, unit/integration test execution, and coverage checks. | [skills/springboot-verification](skills/springboot-verification/SKILL.md) |

---

## Included Agents

| Agent | Role & Capabilities | File |
|-------|---------------------|------|
| `java-reviewer` | Deep code review for Java, Spring Boot, and Quarkus enforcing clean architecture, immutability, and security. | [agents/java-reviewer.md](agents/java-reviewer.md) |
| `java-build-resolver` | Specialized agent to diagnose and resolve Maven and Gradle build failures, compiler errors, and dependency conflicts. | [agents/java-build-resolver.md](agents/java-build-resolver.md) |
