# Contributing

Every change follows these steps in order:
request → specification → human approval → plan → tasks → implementation → validation → review.
The rules are in [AGENTS.md](AGENTS.md) and the conventions are in [docs/standards.md](docs/standards.md).

## 1. Write and approve a specification

1. Copy [specs/TEMPLATE.md](specs/TEMPLATE.md) to `specs/<name>.md`, or run [spec-generator](skills/spec-generator/SKILL.md).
2. Set `Status: Draft`. Fill in every section. Write acceptance criteria as Given/When/Then.
3. Record every unknown under Open Questions. Do not fill gaps with assumptions.
4. Set `Status: In Review` and ask a human to review.
5. The human answers the Open Questions, then does one of two things:
   - Approves: sets `Status: Approved` and fills in `Approved by:` and `Date:`.
   - Rejects: sets `Status: Rejected`.
6. An agent never approves a spec, including its own.

## 2. Create a plan and tasks

Start only when the spec says `Status: Approved`.

1. Copy [plans/TEMPLATE.md](plans/TEMPLATE.md) to `plans/<name>.md`. List every file you will change.
2. Fill in the Test plan with [test-plan-generator](skills/test-plan-generator/SKILL.md). Every acceptance criterion needs at least one test.
3. Copy [tasks/TEMPLATE.md](tasks/TEMPLATE.md) to `tasks/<name>.md`. Keep tasks small and ordered, and link each one to acceptance criteria.

## 3. Implement and test approved scope

1. Do the tasks in order, and change only the files the plan lists.
2. Put code in `src/` and tests in `tests/`. Make sure `tests/run.sh` runs every test.
3. If a task needs something the spec does not cover, stop and ask a human. This includes a new dependency, a protected path, and any unclear behavior.
4. Mark each task `Done: Yes` only after its tests pass.

## 4. Validate and submit a change

1. Run `./scripts/validate.sh`. It must end with `VALIDATION PASSED`.
2. Copy [review/change-template.md](review/change-template.md) into the change description, or run
   [pr-reviewer](skills/pr-reviewer/SKILL.md). Answer every question with Yes, No, or Not applicable, and give evidence.
3. Any `No` blocks the change. Fix the problem, or ask a human.
4. Use a commit message in the form `<type>(<name>): <summary>` (see [docs/standards.md](docs/standards.md)).
5. A human reviews and merges.
