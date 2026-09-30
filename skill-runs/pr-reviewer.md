# Skill run: pr-reviewer

- Skill: [skills/pr-reviewer/SKILL.md](../skills/pr-reviewer/SKILL.md)
- Date: 2026-09-28
- Agent: Claude Code (Claude Opus 5.5). This is a self-review. A human still reviews and merges.

## Input

```text
Change: chore(foundation): add AI-ready project foundation
Spec: none (docs/config only). Source: the human's "AI-Ready Project Foundation" assignment brief.
```

`git status --porcelain` (initial repository, everything staged):

```text
A  .gitignore
A  AGENTS.md
A  CLAUDE.md
A  CONTRIBUTING.md
A  README.md
A  constitution.md
A  docs/decisions.md
A  docs/standards.md
A  plans/TEMPLATE.md
A  review/change-template.md
A  scripts/validate.sh
A  skill-runs/spec-generator.md
A  skill-runs/test-plan-generator.md
A  skills/pr-reviewer/SKILL.md
A  skills/spec-generator/SKILL.md
A  skills/test-plan-generator/SKILL.md
A  specs/TEMPLATE.md
A  specs/sample-health-endpoint.md
A  src/.gitkeep
A  tasks/TEMPLATE.md
A  tests/.gitkeep
```

`git diff --cached --stat`: `21 files changed, 962 insertions(+)`. This run adds a 22nd file, `skill-runs/pr-reviewer.md`.

## Output

# Change review

Change: chore(foundation): add AI-ready project foundation
Spec: none (docs/config only)
Reviewer: agent + pr-reviewer skill

| # | Question | Answer | Evidence |
|---|----------|--------|----------|
| 1 | Is an approved specification linked? | Not applicable | No feature code. `find src tests -type f` shows only `src/.gitkeep` and `tests/.gitkeep`. |
| 2 | Is the change within scope? | Yes | Every file is a deliverable in the assignment brief, or supports one: `CLAUDE.md` (pointer, D-3), `scripts/validate.sh` (D-2), `docs/decisions.md` (constitution principle 5), `.gitignore` (secret handling). `git diff --cached --name-only` shows only `.md`, `.sh`, `.gitkeep`, and `.gitignore` files. |
| 3 | Are acceptance criteria covered by tests? | Not applicable | No spec, so no acceptance criteria. The validator was checked against failing cases in a scratch copy: code without approval, Approved without a name, a secret, and a failing `tests/run.sh` each produced `VALIDATION FAILED`. |
| 4 | Did validation pass? | Yes | `./scripts/validate.sh` exited 0 with last line `VALIDATION PASSED` (full output below). |
| 5 | Are secrets absent? | Yes | The secret-scan section of `./scripts/validate.sh` reported no `FAIL`. No `.env` files exist (`ls .env*`: no matches). |
| 6 | Are dependencies justified? | Yes | No dependencies were added. The validator uses only Bash and coreutils (docs/decisions.md D-2). |
| 7 | Are protected paths unchanged or approved? | Yes | This change creates the protected paths listed in AGENTS.md. The human's assignment brief requested each one by name. |
| 8 | Are relevant documents updated? | Yes | AGENTS.md links every governance document. The validator's "AGENTS.md links all governance documents" check passed. README.md "Status" matches D-1. |

Result: Ready to submit

Validation output (run after this file was written):

```text
$ ./scripts/validate.sh; echo "exit=$?"
==> Required paths
==> AGENTS.md links all governance documents
==> Skills and recorded runs
==> Spec template sections
==> Review checklist questions
==> Spec status and human approval
==> No code or tests without an approved spec
==> Secret scan
==> Markdown files are short (max 200 lines)
==> Tests
INFO  tests/run.sh not present; no tests to run
VALIDATION PASSED
exit=0
```

Quality checks:

| Check | Answer |
|-------|--------|
| Are all eight questions answered? | Yes |
| Is every answer exactly Yes, No, or Not applicable? | Yes |
| Does every answer have evidence (a link, command output, or file reference)? | Yes |
| Is the Result `Blocked` whenever any answer is No? | Yes (there are no No answers) |
