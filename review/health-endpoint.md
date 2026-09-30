# Change review

Change: `feat(health-endpoint): return 200 with status OK`
Spec: [specs/health-endpoint.md](../specs/health-endpoint.md)
Reviewer: agent + [pr-reviewer](../skills/pr-reviewer/SKILL.md) (a human reviews and merges)

Answer every question with **Yes**, **No**, or **Not applicable**.
Give evidence for every answer, including Not applicable: a link, command output, or file reference.
Any **No** blocks submission.

| # | Question | Answer | Evidence |
|---|----------|--------|----------|
| 1 | Is an approved specification linked? | Yes | [specs/health-endpoint.md](../specs/health-endpoint.md): `Status: Approved`, `Approved by: Tetyana Petrenko`, `Date: 2026-09-30`; approval committed separately as 4618b28 before any code |
| 2 | Is the change within scope? | Yes | `git status --porcelain` lists 12 files plus this review; each is in the "Files to change" table of [plans/health-endpoint.md](../plans/health-endpoint.md). Only `GET /api/health` is added; no other endpoint, auth, or metrics (spec Out of Scope) |
| 3 | Are acceptance criteria covered by tests? | Yes | AC-1: `ac1_getHealthReturns200`, `ac1_ac2_ac3_getHealthOverHttpWithoutCredentials`; AC-2: `ac2_healthReturnsStatusOk`, `ac2_getHealthReturnsJsonStatusOk`, and the full test; AC-3: `ac3_getHealthWithoutCredentialsIsNotRejected`, and the full test; AC-4: `tests/run.sh` → `Tests run: 5, Failures: 0, Errors: 0, Skipped: 0`, `BUILD SUCCESS`. Tests failed first (`cannot find symbol: class HealthController`) before T-6 |
| 4 | Did validation pass? | Yes | `./scripts/validate.sh` → exit 0, last line `VALIDATION PASSED` |
| 5 | Are secrets absent? | Yes | `==> Secret scan` section of `./scripts/validate.sh` reported no `FAIL`; `application.properties` has only `server.port=8080` |
| 6 | Are dependencies justified? | Yes | `pom.xml`: parent `spring-boot-starter-parent` 2.7.18, `spring-boot-starter-web`, `spring-boot-starter-test` (test). Named in spec Scope, Dependencies, Q-6, and Q-7; recorded in [D-4](../docs/decisions.md) |
| 7 | Are protected paths unchanged or approved? | Yes | Only protected path touched is `.gitignore` (added `target/`); approved by Tetyana Petrenko in chat on 2026-09-30, recorded in plan Files table and [D-7](../docs/decisions.md). `AGENTS.md`, templates, `skills/**`, `scripts/**` are unchanged (`git status`) |
| 8 | Are relevant documents updated? | Yes | [docs/decisions.md](../docs/decisions.md) D-1 to D-7 (restores the log that `AGENTS.md` links; validation failed without it), [plans/health-endpoint.md](../plans/health-endpoint.md), [tasks/health-endpoint.md](../tasks/health-endpoint.md). `AGENTS.md`, `README.md`, `CONTRIBUTING.md` stay stack-neutral by design ([D-6](../docs/decisions.md)) |
| 9 | Were decisions not in the spec answered by a human? | Yes | Plan table "Decisions not in the spec": 5 rows, each answered by Tetyana Petrenko and mapped to D-4, D-5, D-6, or D-7 in [docs/decisions.md](../docs/decisions.md). Class names follow the spec's package `com.example.health` |

Result: Ready to submit

## Quality checks (pr-reviewer)

- Are all nine questions answered? Yes
- Is every answer exactly Yes, No, or Not applicable? Yes
- Does every answer have evidence (a link, command output, or file reference)? Yes
- Is the Result `Blocked` whenever any answer is No? Yes (no answer is No)

## Additional manual check

`mvn -o -q spring-boot:run`, then `curl -si localhost:8080/api/health` →
`HTTP/1.1 200`, `Content-Type: application/json`, body `{"status":"OK"}`.
