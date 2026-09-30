# AGENTS.md

These are the instructions every AI coding agent and every human follows in this repository.
Tool-specific files, such as `CLAUDE.md`, only point here. This file wins if two files disagree.

## Purpose

This repository is an AI-ready project foundation. It holds governance docs, templates, validation,
and reusable AI skills for spec-driven development. It has no feature code yet.
No technology stack is chosen yet ([D-1](docs/decisions.md)). The first approved spec that needs a stack chooses it.

## Folder map

| Path | Contents |
|------|----------|
| `AGENTS.md` | Canonical agent instructions (this file) |
| `CLAUDE.md` | Pointer to this file for Claude Code only |
| `README.md` | Human overview and quick start |
| `CONTRIBUTING.md` | How to propose, build, validate, and submit a change |
| `constitution.md` | Seven principles that override everything else |
| `docs/` | Standards and decision log |
| `specs/` | Specifications, one file per request: `specs/<name>.md` |
| `plans/` | Implementation plans for approved specs: `plans/<name>.md` |
| `tasks/` | Task lists for approved plans: `tasks/<name>.md` |
| `review/` | Change review checklist |
| `skills/` | Reusable AI skills: `skills/<skill-name>/SKILL.md` |
| `skill-runs/` | One recorded run per skill |
| `scripts/` | Validation script |
| `src/` | Application code. Stays empty until a spec is approved. |
| `tests/` | Tests. Stays empty until a spec is approved. `tests/run.sh` is the test entry point. |

## Workflow

request → specification → human approval → plan → tasks → implementation → validation → review

Full steps are in [CONTRIBUTING.md](CONTRIBUTING.md).

## Validation commands

Run from the repository root:

```sh
./scripts/validate.sh
```

A pass means exit code 0 and a last line of `VALIDATION PASSED`.
If `tests/run.sh` exists, the script runs it as part of validation.

## Governance documents

- [README.md](README.md): overview
- [CONTRIBUTING.md](CONTRIBUTING.md): contribution workflow
- [constitution.md](constitution.md): principles
- [docs/standards.md](docs/standards.md): naming, submission, documentation, dependency, security, and testing conventions
- [docs/decisions.md](docs/decisions.md): decision log
- [specs/TEMPLATE.md](specs/TEMPLATE.md): specification template
- [specs/sample-health-endpoint.md](specs/sample-health-endpoint.md): example Draft spec. It is an example, not a work request.
- [plans/TEMPLATE.md](plans/TEMPLATE.md): plan template
- [tasks/TEMPLATE.md](tasks/TEMPLATE.md): tasks template
- [review/change-template.md](review/change-template.md): review checklist
- [scripts/validate.sh](scripts/validate.sh): validation
- Skills: [spec-generator](skills/spec-generator/SKILL.md), [test-plan-generator](skills/test-plan-generator/SKILL.md), [pr-reviewer](skills/pr-reviewer/SKILL.md)
- Recorded skill runs: [skill-runs/](skill-runs/)

## Rules

Each rule has a Yes/No answer. For every rule, "No" means the change is blocked.

- **R1.** No feature implementation without an approved specification. Was every file in `src/` and `tests/` created only after its spec reached `Status: Approved`?
- **R2.** An agent cannot approve its own specification. Did only a human set `Approved` or `Rejected`, and fill in the Human approval name and date?
- **R3.** Run applicable validation before submitting changes. Did `./scripts/validate.sh` pass on the final state of the change?
- **R4.** Never expose secrets. Is the change free of secrets in files, output, logs, and commit messages?
- **R5.** Never weaken security or tests. Were no tests, checks, or security settings removed, skipped, or loosened?
- **R6.** Never modify protected paths without explicit approval. Is every protected path unchanged, or does the approval name that path?
- **R7.** If requirements are unclear, stop and ask. Do not guess. Was every unclear point recorded as an Open Question and sent to a human?
- **R8.** Implement only the approved scope. Does every changed file appear in the plan for the linked approved spec?
- **R9.** Do not choose technology. Is every language, framework, dependency, port, and path named in the approved spec?
- **R10.** Do not make decisions the spec does not cover. Did a named human answer every such decision, such as an exact version, name, layout, or tool setting, with each one listed under "Decisions not in the spec" in the plan and recorded in [docs/decisions.md](docs/decisions.md)?

## Handling a feature request

1. Use [spec-generator](skills/spec-generator/SKILL.md) to write `specs/<name>.md` with `Status: Draft`.
   Write a new file for every request. Do not reuse the sample.
2. Record every unknown as an Open Question. Examples: stack, route, port, response format, auth, and test tool.
3. Stop. Ask a human to answer the questions and approve. Do not write a plan, code, or tests before approval.
4. After a human approves: write the plan (use [test-plan-generator](skills/test-plan-generator/SKILL.md)), write the tasks,
   implement only those tasks, add tests, run validation, and complete the review
   (use [pr-reviewer](skills/pr-reviewer/SKILL.md)).

## Protected paths

Change these only with explicit human approval that names the path:

- `AGENTS.md`, `CLAUDE.md`, `constitution.md`, `CONTRIBUTING.md`, `docs/standards.md`
- `specs/TEMPLATE.md`, `plans/TEMPLATE.md`, `tasks/TEMPLATE.md`, `review/change-template.md`
- `skills/**`, `scripts/**`, `.gitignore`, `.git/`
- The `## Human approval` section and the `Status:` line of any spec. Agents may write only `Draft` or `In Review`.

Approval is valid only in one of two forms: a human message that names the path, or an approved spec that lists the path.

## Secret handling

- Never commit secrets. Secrets include keys, tokens, passwords, private keys, and credentials in connection strings.
- Read secrets from environment variables. Commit only `.env.example` with placeholder values such as `<set-me>`.
- Never read `.env` files or secret stores, and never print their contents in output, logs, specs, reviews, or skill runs.
- If you find a secret, stop. Do not repeat it. Tell a human which file it is in.
- The secret scan in `./scripts/validate.sh` must pass.

## Stop and ask a human when

- A request needs code or tests and no approved spec exists.
- A requirement is missing, ambiguous, or conflicting.
- A change needs a protected path, a new dependency, or a technology the approved spec does not name.
- A plan or implementation needs a decision the approved spec does not cover.
- Validation fails and the only fix would weaken a test, check, or security setting.
- A secret is found or needed.
- A spec is ready for approval. This always needs a human.
- A request conflicts with [constitution.md](constitution.md).
