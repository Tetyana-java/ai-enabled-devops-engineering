---
name: test-plan-generator
description: Map every Given/When/Then acceptance criterion in a spec to test cases for the plan's Test plan section, without choosing a test tool.
---

# test-plan-generator

## Purpose

Produce a test plan in which every acceptance criterion has at least one test case.
The output goes into the `## Test plan` section of `plans/<name>.md`.

## When to use

- A spec has been approved and the plan is being written. This is the normal case.
- A spec is Draft or In Review and a reviewer wants to see whether its criteria can be tested. The output is marked "not for implementation".

## Required inputs

- Path to the spec. Required.
- Test tool named in the spec, if any. Otherwise the plan names none.

## Steps

1. Read the `Status:` line. If it is `Rejected`, stop.
2. List every `AC-n`. If there are none, or any is not in Given/When/Then form, stop.
3. For each AC, write at least one test case `TC-n`: the AC it covers, the type (unit, integration, or manual), Given/When/Then, and the expected result.
4. Add a negative test only if the spec defines the failure behavior. Otherwise add an open question for it.
5. For each test case, list any open question that blocks its exact expected result.
6. Name a test tool only if the spec names one. Otherwise write "Tool: per approved spec".
7. Add a coverage line: `Covered ACs: x / y`.

## Stop conditions

- The spec is Rejected, has no acceptance criteria, or has criteria that are not in Given/When/Then form.
- A test would need a technology or dependency that the spec does not name. Record an open question, and stop if the test cannot be written without it.

## Output format

```text
Test plan for specs/<name>.md (spec status: <Status>) [not for implementation, if not Approved]
Tool: <named in spec | per approved spec>
| Test ID | AC | Type | Given / When / Then | Expected result | Blocked by |
Covered ACs: x / y
Open questions raised: <list or None>
```

## Quality checks

- Does every AC map to at least one test case? Yes/No
- Is every test case written as Given/When/Then? Yes/No
- Is the plan free of any tool or framework the spec does not name? Yes/No
- Does every blocked test case name the open question that blocks it? Yes/No
- Does the coverage line equal y / y? Yes/No

## Example

Input: an approved spec with `AC-1: Given the service is running, When GET /version is requested, Then the status is 200.`

Output:

```text
Test plan for specs/version-endpoint.md (spec status: Approved)
Tool: per approved spec
| TC-1 | AC-1 | integration | Given service running, When GET /version, Then check status | 200 | - |
Covered ACs: 1 / 1
Open questions raised: None
```

Full recorded run: [skill-runs/test-plan-generator.md](../../skill-runs/test-plan-generator.md)
