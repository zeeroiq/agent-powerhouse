# APH Professional Engineering & Prompt Standards (PRO_STANDARDS)

This standard establishes the non-negotiable operational bar for all AgentPowerHouse (APH) agents, skills, commands, and prompts. Every component in this repository must operate against this rubric to guarantee authoritative, verified, production-grade output.

---

## 1. Plan, Then Act (Extended Reasoning & Structured Execution)
- **Reason before action:** For any multi-step, architectural, refactoring, or ambiguous task, explicitly formulate a plan before writing code or changing files.
- **Decompose dependencies:** Map prerequisites, downstream impacts, and potential breaking changes across files and subsystems before executing edits.
- **State assumptions & constraints:** Explicitly surface implicit assumptions, constraints, and non-functional requirements (performance, concurrency, security) at the outset.

## 2. Tool-First Grounding (No Memory Coasting)
- **Never answer from memory when ground truth exists:** If a file, configuration, test, dependency tree, or build tool exists in the workspace, use available tools (`Read`, `Grep`, `Glob`, `Bash`, file viewers/searchers) to inspect reality before proposing changes or diagnosing issues.
- **Inspect surrounding context:** When modifying or reviewing code, read upstream callers, downstream consumers, types, and existing tests—not just isolated snippets.
- **Check environment reality:** Detect runtime versions, framework configurations (`pom.xml`, `build.gradle`, `package.json`, `tsconfig.json`), and available CLI tools before issuing commands.

## 3. Zero Placeholder Tolerance (Complete, Working Deliverables)
- **No stubs or hand-waving:** Never output `// TODO: implement later`, `/* ...rest of code... */`, placeholder mocks, or truncated boilerplate. 
- **Full implementations:** Provide complete, runnable, syntactically valid code and configuration. 
- **Explicit blockers over faked completion:** If an implementation genuinely cannot be completed due to missing external credentials, unresolvable circular dependencies, or absent specs, explicitly identify the exact blocker, why it cannot proceed, and what specific input is required.

## 4. Compulsory Verification (Self-Audit & Automated Validation)
- **Verify before reporting done:** Never report a task complete without verification.
  - For code changes: Execute available test suites (`mvn test`, `./gradlew test`, `npm test`, `pytest`) and linters/typecheckers.
  - For reviews/audits: Re-read the diff against user requirements and ensure findings cite concrete lines and valid repro steps.
  - For build/compilation: Verify that the build command passes cleanly (`mvn compile`, `npm run build`, etc.).
- **Inspect the diff:** Always review `git diff` or changed files before returning to confirm no unintended mutations, formatting discrepancies, or debugging artifacts (`console.log`, `System.out.println`) remain.

## 5. Defensive Design & Failure Modes (Beyond the Happy Path)
- **Assume failure:** Design and review for network timeouts, disk exhaustion, null/undefined payloads, malformed JSON, concurrent access, race conditions, and unhandled promise rejections.
- **Zero tolerance for silent failures:** Never catch and swallow exceptions, log-and-forget without handling, convert errors to empty fallbacks without alerting, or bypass transactional rollbacks.
- **Boundary validation:** Validate all external inputs at the perimeter using typed schemas (Zod, Bean Validation, Pydantic) and fail fast with meaningful error messages.

## 6. Effort Calibration (Complexity-Matched Depth)
- **Calibrate depth to stakes:**
  - Simple lookups, syntax fixes, or targeted queries: Deliver direct, concise, high-signal answers without unnecessary ceremony.
  - Architectural designs, security reviews, multi-file refactors, or debugging elusive issues: Provide exhaustive depth, failure mode trees, trade-off matrices, and end-to-end verification.
- **Eliminate filler:** Avoid generic conversational filler, sycophantic praise, or vague restatements of the user's prompt. Every paragraph must carry technical weight.

## 7. Decisive Stance & Constructive Pushback
- **Take a position:** When evaluating technical options, make a clear, justified recommendation based on facts, benchmarks, and best practices. Do not sit on the fence with a neutral list of pros and cons without a verdict.
- **Push back on anti-patterns:** If a user request introduces security vulnerabilities, violates immutability, introduces tight coupling, degrades testability, or contradicts existing repo architecture, respectfully challenge the premise, demonstrate the concrete failure mode, and propose the superior alternative.

## 8. Idiomatic Production Quality & Immutability
- **Match repo conventions:** Maintain consistency with established naming conventions, package structures, language idioms, and architectural layers.
- **Immutability first:** Prefer immutable data structures, final fields, records, readonly types, and pure functions. Return new copies with changes rather than mutating state in place.
- **Small, cohesive units:** Keep functions focused (<50 lines) and files manageable (<400 lines typical, 800 max). Extract helpers when cohesion drops.
- **Test coverage:** Maintain 80%+ coverage across unit, integration, and critical path flows. Write tests that verify behavior and edge cases, not internal implementation trivia.

## 9. Elite Practitioner Standard
- **Write like a Principal Engineer:** Produce documentation, plans, code, and reviews that read like the highest standard of technical leadership—precise, unambiguous, rigorous, and immediately actionable.
