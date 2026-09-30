# Skill run: spec-generator

- Skill: [skills/spec-generator/SKILL.md](../skills/spec-generator/SKILL.md)
- Date: 2026-09-28
- Agent: Claude Code (Claude Opus 5.5)
- Note: this was a demonstration run. After the run, `specs/version-endpoint.md` was removed so that no one mistakes it for a real work request.
  Its complete content is kept below.

## Input

```text
Add a version endpoint that returns the application version.
```

## Output

Step 1 (search for an overlapping spec): `grep -il version specs/*.md` found no match (exit 1).

File written: `specs/version-endpoint.md`

````markdown
# Spec: Version endpoint

## Status

Status: Draft

## Problem

Users cannot find out which version of the application is running. The request asks for an endpoint that returns the application version.

## Scope

- One read-only HTTP endpoint that returns the application version.

## Out of Scope

- Build metadata such as commit hash, build date, or dependency versions.
- Authentication, caching, and version negotiation.

## Requirements

- REQ-1: The service must expose a version endpoint over HTTP.
- REQ-2: The version endpoint must return the application version.

## Acceptance criteria

- AC-1 (REQ-1): Given the service is running, When a client requests the version endpoint, Then the response status indicates success (exact code: Q-4).
- AC-2 (REQ-2): Given the service is running with a known version value, When a client requests the version endpoint, Then the response body contains that version in the agreed format (Q-4).

## Security

None requested. The endpoint exposes the version, which may help attackers find known vulnerabilities (Q-5).

## Dependencies

None requested. The language, framework, and test tool are not chosen (Q-1).

## Open Questions

- Q-1: What language, runtime, and test tool should we use? Answer: <pending>
- Q-2: What is the route and HTTP method, for example `GET /version`? Answer: <pending>
- Q-3: Where does the version value come from: build file, environment variable, or constant? Answer: <pending>
- Q-4: What are the success status code and the exact body format, for example plain text or JSON `{"version":"1.2.3"}`? Answer: <pending>
- Q-5: Is it acceptable for the endpoint to be public, or must it require authentication? Answer: <pending>

## Human approval

Approved by: <name>
Date: <YYYY-MM-DD>
````

Report to the human:

```text
Draft spec: specs/version-endpoint.md (Status: Draft)
Requirements: REQ-1..REQ-2 | Acceptance criteria: AC-1..AC-2
Open questions (a human must answer):
- Q-1: What language, runtime, and test tool should we use?
- Q-2: What is the route and HTTP method, for example `GET /version`?
- Q-3: Where does the version value come from: build file, environment variable, or constant?
- Q-4: What are the success status code and the exact body format?
- Q-5: Is it acceptable for the endpoint to be public, or must it require authentication?
Validation: VALIDATION FAILED (3 problem(s))
  The only failures were the missing skill-runs/*.md files, which this bootstrap step creates.
  After all runs were recorded, validation passed (see skill-runs/pr-reviewer.md).
Next: a human answers the questions, sets Status: Approved, and fills in the approver name and date.
I will not write a plan, code, or tests before that.
```

Quality checks:

| Check | Answer |
|-------|--------|
| Is Status `Draft`? | Yes |
| Does every REQ have at least one Given/When/Then AC? | Yes |
| Is the spec free of any technology the request does not name? | Yes |
| Is every unknown recorded as an Open Question? | Yes |
| Is the Human approval section still placeholders? | Yes |
| Are `src/` and `tests/` unchanged? | Yes (`find src tests -type f` shows only the `.gitkeep` files) |
