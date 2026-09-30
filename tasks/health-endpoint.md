# Tasks: Health endpoint

Spec: [specs/health-endpoint.md](../specs/health-endpoint.md) · Plan: [plans/health-endpoint.md](../plans/health-endpoint.md)

Rules:

- Do the tasks in order, one at a time.
- Change only the files the plan lists.
- If a task needs anything outside the plan, stop and ask a human.
- Set `Done` to `Yes` only after the task's tests pass.

| ID | Task | Files | Covers | Done |
|----|------|-------|--------|------|
| T-1 | Record decisions D-1 to D-7 | `docs/decisions.md` | none | Yes |
| T-2 | Add `target/` to the protected `.gitignore` (approved, D-7) | `.gitignore` | none | Yes |
| T-3 | Create the Maven build pinned to Spring Boot 2.7.18 and Java 17 | `pom.xml` | AC-4 | Yes |
| T-4 | Create the test entry point `mvn -o -q test` | `tests/run.sh` | AC-4 | Yes |
| T-5 | Write failing tests TC-1 to TC-5 and confirm they fail | `src/test/java/com/example/health/*.java` | AC-1, AC-2, AC-3 | Yes |
| T-6 | Implement the application class, controller, and port 8080 so that T-5 passes | `src/main/java/com/example/health/*.java`, `src/main/resources/application.properties` | AC-1, AC-2, AC-3 | Yes |
| T-7 | Run `./scripts/validate.sh` | none | all | Yes |
| T-8 | Complete `review/change-template.md` with pr-reviewer | `review/health-endpoint.md` | all | Yes |
