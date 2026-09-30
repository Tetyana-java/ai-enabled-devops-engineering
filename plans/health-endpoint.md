# Plan: Health endpoint

Spec: [specs/health-endpoint.md](../specs/health-endpoint.md) (Approved by Tetyana Petrenko, 2026-09-30)

## Approach

Create a minimal Spring Boot 2.7.18 application on Java 17, built with Maven 3.9.8 in the standard Maven layout.
One `@RestController` maps `GET /api/health` and returns `{"status":"OK"}` as `application/json` (REQ-1).
Spring Security is not added, so the endpoint is public (REQ-2). The port is 8080 in `application.properties` (Q-3).
`tests/run.sh` runs `mvn -o -q test`, so `./scripts/validate.sh` runs every test offline (REQ-3, D-5).
`AGENTS.md`, `CONTRIBUTING.md`, and `README.md` stay stack-neutral; the Maven layout is a project exception (D-6).

## Files to change

| Path | Change | Protected? (approval reference) |
|------|--------|---------------------------------|
| `pom.xml` | create | No |
| `src/main/java/com/example/health/HealthServiceApplication.java` | create | No |
| `src/main/java/com/example/health/HealthController.java` | create | No |
| `src/main/resources/application.properties` | create | No |
| `src/test/java/com/example/health/HealthControllerTest.java` | create | No |
| `src/test/java/com/example/health/HealthControllerWebMvcTest.java` | create | No |
| `src/test/java/com/example/health/HealthEndpointIntegrationTest.java` | create | No |
| `tests/run.sh` | create | No |
| `plans/health-endpoint.md`, `tasks/health-endpoint.md` | create | No |
| `review/health-endpoint.md` | create (completed checklist) | No |
| `docs/decisions.md` | create with D-1 to D-7 | No |
| `.gitignore` | add `target/` | Yes (human message, 2026-09-30, D-7) |

## Dependencies

All are named in the spec. The parent `spring-boot-starter-parent` 2.7.18 pins every version (D-4).

- `spring-boot-starter-web`: the HTTP server and MVC (Q-7).
- `spring-boot-starter-test` (test scope): JUnit 5, Spring Test, MockMvc, AssertJ, json-path, and Mockito (spec Dependencies).

## Decisions not in the spec

| Decision | Asked on | Human answer (name) | Recorded as |
|----------|----------|---------------------|-------------|
| Use `spring-boot-starter-parent` to pin versions | 2026-09-30 | Yes (Tetyana Petrenko) | D-4 |
| Offline test runner `mvn -o -q test` | 2026-09-30 | Yes (Tetyana Petrenko) | D-5 |
| Tests in `src/test/java`; `tests/` holds only `run.sh` | 2026-09-30 | Yes (Tetyana Petrenko) | D-6 |
| Maven project version | 2026-09-30 | `0.1.0-SNAPSHOT` (Tetyana Petrenko) | D-7 |
| Add `target/` to protected `.gitignore` | 2026-09-30 | Approved (Tetyana Petrenko) | D-7 |

## Test plan

Output of [test-plan-generator](../skills/test-plan-generator/SKILL.md):

```text
Test plan for specs/health-endpoint.md (spec status: Approved)
Tool: named in spec: JUnit 5, MockMvc (@WebMvcTest), @SpringBootTest, AssertJ, json-path
```

| Test ID | AC | Type | Given / When / Then | Expected result | Blocked by |
|---------|----|------|---------------------|-----------------|------------|
| TC-1 | AC-2 | unit | Given a `HealthController`, When `health()` is called, Then check the returned body | `{status=OK}` | - |
| TC-2 | AC-1 | integration (web slice) | Given MockMvc with `HealthController`, When `GET /api/health`, Then check the status | 200 | - |
| TC-3 | AC-2 | integration (web slice) | Given MockMvc, When `GET /api/health`, Then check content type and body | `application/json`, body exactly `{"status":"OK"}` | - |
| TC-4 | AC-3 | integration (web slice) | Given MockMvc, When `GET /api/health` with no credentials, Then check the status | 200, not 401 or 403 | - |
| TC-5 | AC-1, AC-2, AC-3 | integration (full) | Given the app on a random port, When `GET /api/health` over HTTP with no credentials, Then check status, content type, body | 200, `application/json`, `{"status":"OK"}` | - |
| TC-6 | AC-4 | validation | Given the source tree, When `tests/run.sh` (`mvn -o -q test`) runs, Then check the exit code | 0, no test failures | - |

```text
Covered ACs: 4 / 4
Open questions raised: None
```

## Risks

- The first build needs network access to download dependencies. Mitigation: the one-time setup command is in the `tests/run.sh` header and D-5.
- `target/` build output could get committed. Mitigation: `.gitignore` gets `target/` (approved, D-7).

## Validation

```sh
./scripts/validate.sh
```

## Plan checks (Yes/No)

- Is the linked spec Approved by a human? Yes
- Does every acceptance criterion have at least one test? Yes
- Is every file in scope of the spec? Yes
- Does the plan avoid new dependencies and technologies that the spec does not name? Yes
- Did a named human answer every decision that the spec does not cover, with each one recorded in `docs/decisions.md`? Yes
