# Decisions

Add new decisions at the bottom. Do not edit a decision that is already recorded. To change one, add a new decision that replaces it.

| ID | Date | Decision | Reason | Decided by |
|----|------|----------|--------|------------|
| D-1 | 2026-09-28 | No technology stack is chosen. The first approved spec that needs a stack chooses it. | Choosing a stack now would be a guess ([constitution](../constitution.md) principle 6). | Assignment brief (human) |
| D-2 | 2026-09-28 | Validation is one dependency-free Bash script, `scripts/validate.sh`, that calls `tests/run.sh` when that file exists. | Validation works before any stack is chosen, and any future stack can plug in. | Foundation setup, to be confirmed in review |
| D-3 | 2026-09-28 | The canonical instructions live in `AGENTS.md`. Tool-specific files only point to it. | Instructions stay platform-neutral with a single source. | Assignment brief (human) |
| D-4 | 2026-09-30 | Replaces D-1. The stack is Java 17, Spring Boot 2.7.18 (`spring-boot-starter-parent`), and Maven 3.9.8. The dependencies are `spring-boot-starter-web` and `spring-boot-starter-test` (test scope), all pinned by the parent. The Maven layout is standard: `src/main/java` and `src/test/java`. The coordinates are `com.example:health-service`. | Named in [specs/health-endpoint.md](../specs/health-endpoint.md) Scope, Q-1, Q-6, and Q-7. The use of the parent POM was chosen by a human. | Tetyana Petrenko |
| D-5 | 2026-09-30 | `tests/run.sh` runs `mvn -o -q test` (offline). The one-time setup is `mvn -q dependency:go-offline test`. Responses for other methods and routes (Spring's default 405 and 404) are out of scope and not tested. | Meets the no-network testing standard. Other endpoints are Out of Scope in the spec. | Tetyana Petrenko |
| D-6 | 2026-09-30 | `AGENTS.md`, `CONTRIBUTING.md`, and `README.md` stay stack-neutral and reusable as templates. The health-endpoint project uses the standard Maven layout: tests are in `src/test/java`, and `tests/` holds only `tests/run.sh`. This is a project-specific exception to the generic "tests in `tests/`" wording. | The stack is decided per spec, not in the canonical instructions. | Tetyana Petrenko |
| D-7 | 2026-09-30 | The Maven project version is `0.1.0-SNAPSHOT`. `target/` is added to the protected `.gitignore`. | Not named in the spec; answered by a human in chat before the plan was written. | Tetyana Petrenko |
