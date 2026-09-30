# Skill run: test-plan-generator

- Skill: [skills/test-plan-generator/SKILL.md](../skills/test-plan-generator/SKILL.md)
- Date: 2026-09-28
- Agent: Claude Code (Claude Opus 5.5)

## Input

```text
Spec: specs/sample-health-endpoint.md
Test tool named in spec: none (Q-6 open)
```

Data read from the spec (`grep -E '^Status:|^- AC-' specs/sample-health-endpoint.md`):

```text
Status: Draft
- AC-1 (REQ-1, REQ-2): Given the service is running, When a client sends a request to the health endpoint, Then the response status is 200.
- AC-2 (REQ-3): Given the service is running, When a client sends a request to the health endpoint, Then the response body reports status `OK` in the agreed format (Q-4).
```

## Output

```text
Test plan for specs/sample-health-endpoint.md (spec status: Draft) [not for implementation]
Tool: per approved spec
```

| Test ID | AC | Type | Given / When / Then | Expected result | Blocked by |
|---------|----|------|---------------------|-----------------|------------|
| TC-1 | AC-1 | integration | Given the service is running, When a client sends a request to the health endpoint, Then read the status code | `200` | Q-1, Q-2, Q-3 (the route, method, and port are needed to send the request) |
| TC-2 | AC-2 | integration | Given the service is running, When a client sends a request to the health endpoint, Then read the response body | Body reports status `OK` in the Q-4 format | Q-1, Q-2, Q-3, Q-4 |

```text
Covered ACs: 2 / 2
Open questions raised:
- Q-7 (new): What should the endpoint return when the service is unhealthy? The spec defines no failure
  behavior, so the plan has no negative test (step 4).
```

Quality checks:

| Check | Answer |
|-------|--------|
| Does every AC map to at least one test case? | Yes (2 / 2) |
| Is every test case written as Given/When/Then? | Yes |
| Is the plan free of any tool or framework the spec does not name? | Yes ("Tool: per approved spec") |
| Does every blocked test case name the open question that blocks it? | Yes |
| Does the coverage line equal y / y? | Yes |
