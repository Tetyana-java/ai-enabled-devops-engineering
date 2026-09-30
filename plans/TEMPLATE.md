# Plan: <title>

Spec: [specs/<name>.md](../specs/<name>.md)
<!-- Write a plan only when the spec has Status: Approved and a human approver name and date. -->

## Approach

<!-- The simplest approach that meets the requirements, in 3–5 sentences. -->

## Files to change

| Path | Change | Protected? (approval reference) |
|------|--------|---------------------------------|
| `src/...` | create | No |

## Dependencies

<!-- Only dependencies that the approved spec names. Write "None" if there are none. -->

## Decisions not in the spec

<!-- Any choice the approved spec does not name, such as an exact version, name, layout, port, or tool setting.
     An agent never decides these. Ask a human, record the answer in docs/decisions.md, then fill in the row.
     Write "None" if the spec covers everything. -->
| Decision | Asked on | Human answer (name) | Recorded as |
|----------|----------|---------------------|-------------|
| <!-- e.g. exact framework version --> | <!-- YYYY-MM-DD --> | <!-- answer (name) --> | <!-- D-n --> |

## Test plan

<!-- Output of skills/test-plan-generator. Every AC needs at least one test. -->
| Test ID | AC | Type | Given / When / Then | Expected result |
|---------|----|------|---------------------|-----------------|

## Risks

- <!-- A risk and how the plan handles it -->

## Validation

```sh
./scripts/validate.sh
```

## Plan checks (Yes/No)

- Is the linked spec Approved by a human? <Yes/No>
- Does every acceptance criterion have at least one test? <Yes/No>
- Is every file in scope of the spec? <Yes/No>
- Does the plan avoid new dependencies and technologies that the spec does not name? <Yes/No>
- Did a named human answer every decision that the spec does not cover, with each one recorded in `docs/decisions.md`? <Yes/No>
