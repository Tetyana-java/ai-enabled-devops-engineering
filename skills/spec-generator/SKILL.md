---
name: spec-generator
description: Turn a change request into a Draft specification that follows specs/TEMPLATE.md, then stop for human approval.
---

# spec-generator

## Purpose

Turn a request into a Draft spec that follows [specs/TEMPLATE.md](../../specs/TEMPLATE.md).
Every unknown in the request becomes an Open Question instead of a guess.

## When to use

- A human asks for a new feature or a change in behavior, and no Approved spec covers it.
- Do not use it for typo fixes or other documentation-only changes.

## Required inputs

- Request text, exactly as the human wrote it. Required.
- Existing specs in `specs/` that might overlap. Check for them.

## Steps

1. Search `specs/` for a spec that covers the same request. If an Approved one exists, stop and report its path.
2. Choose a kebab-case name and copy the template to `specs/<name>.md`. Never reuse `sample-*` files.
3. Set `Status: Draft`.
4. Problem: restate the request in one or two sentences. Add nothing.
5. Scope: include only what the request says. Out of Scope: list things someone might assume but the request does not ask for.
6. Requirements: write one testable `REQ-n` for each need the request states.
7. Acceptance criteria: write at least one `AC-n` for each REQ in the form Given/When/Then.
8. Security and Dependencies: write what the request states. If the request is silent, write "None requested" and add an Open Question.
9. Add every missing decision to Open Questions as `Q-n` with `Answer: <pending>`. Examples: language, framework, route, port, data format, errors, auth, and test tool.
10. Leave the Human approval placeholders as they are.
11. Run `./scripts/validate.sh`.
12. Report in the Output format below, then stop.

## Stop conditions

- Always stop after step 12. Do not plan, write code, or write tests until a human sets `Status: Approved`.
- Stop and ask if the request conflicts with [constitution.md](../../constitution.md) or needs a protected path.
- Stop and ask if the request is too vague to state even one requirement.

## Output format

```text
Draft spec: specs/<name>.md (Status: Draft)
Requirements: REQ-1..REQ-n | Acceptance criteria: AC-1..AC-n
Open questions (a human must answer):
- Q-1: ...
Validation: <last line of ./scripts/validate.sh>
Next: a human answers the questions, sets Status: Approved, and fills in the approver name and date.
I will not write a plan, code, or tests before that.
```

## Quality checks

- Is Status `Draft`? Yes/No
- Does every REQ have at least one Given/When/Then AC? Yes/No
- Is the spec free of any technology the request does not name? Yes/No
- Is every unknown recorded as an Open Question? Yes/No
- Is the Human approval section still placeholders? Yes/No
- Are `src/` and `tests/` unchanged? Yes/No

## Example

Input: `Add a version endpoint that returns the application version.`

Output (abridged):

```text
Draft spec: specs/version-endpoint.md (Status: Draft)
Requirements: REQ-1..REQ-2 | Acceptance criteria: AC-1..AC-2
Open questions (a human must answer):
- Q-1: Language/runtime?  - Q-2: Route and method?  - Q-3: Where does the version value come from?
Validation: VALIDATION PASSED
Next: a human answers the questions, sets Status: Approved, and fills in the approver name and date.
```

Full recorded run: [skill-runs/spec-generator.md](../../skill-runs/spec-generator.md)
