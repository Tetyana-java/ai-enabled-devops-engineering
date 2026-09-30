---
name: pr-reviewer
description: Review a change by completing review/change-template.md with a Yes, No, or Not applicable answer and evidence for every question.
---

# pr-reviewer

## Purpose

Review a change using exactly the checklist in [review/change-template.md](../../review/change-template.md).
Every answer must be backed by evidence. The skill never changes the checklist.

## When to use

- Before a change is submitted. This includes an agent checking its own change.
- When a human asks for a review of a branch, a diff, or a set of files.

## Required inputs

- The changed files: `git status --porcelain` and `git diff --stat` (add `git diff --cached --stat` if files are staged). Required.
- The linked spec path, or "none" for a documentation or config change. Required.
- Output of `./scripts/validate.sh`. The skill runs it if it is missing.

## Steps

1. Copy the table from `review/change-template.md` without changing its eight questions.
2. List the changed files. Compare them with the protected paths in [AGENTS.md](../../AGENTS.md).
3. Q1: open the spec. Answer Yes only if it says `Status: Approved` and has an approver name and date. If the change does not touch `src/` or `tests/`, answer Not applicable.
4. Q2: compare the changed files with the plan's "Files to change" list, or with the request for a docs/config change.
5. Q3: check that each AC has a test that names it (`ac1`...), and that `tests/run.sh` runs that test.
6. Q4: run `./scripts/validate.sh` and quote its last line.
7. Q5: quote the secret-scan result from validation. Never repeat a secret you found.
8. Q6: check that every new dependency is named in the spec and in `docs/decisions.md`.
9. Q7: list the protected paths that were touched, and the approval for each.
10. Q8: check that the docs describing the changed behavior were updated in the same change.
11. Set Result: `Ready to submit` if there is no No, otherwise `Blocked` with the No answers listed.

## Stop conditions

- The changed-file list is missing and cannot be produced. Stop and ask for it.
- You cannot find evidence for an answer. Answer No and say what is missing. Never guess Yes.
- A secret is found. Answer Q5 No, name only the file, and stop for a human.

## Output format

The completed table from `review/change-template.md`, including the header lines and the `Result:` line.

## Quality checks

- Are all eight questions answered? Yes/No
- Is every answer exactly Yes, No, or Not applicable? Yes/No
- Does every answer have evidence (a link, command output, or file reference)? Yes/No
- Is the Result `Blocked` whenever any answer is No? Yes/No

## Example

Input: `docs(standards): fix typo`, changed file `docs/standards.md`, spec: none.

Output (abridged):

```text
| 1 | Is an approved specification linked? | Not applicable | docs-only; `git diff --stat`: docs/standards.md only |
| 4 | Did validation pass? | Yes | `./scripts/validate.sh` → VALIDATION PASSED |
| 7 | Are protected paths unchanged or approved? | Yes | docs/standards.md is protected; human approved it in the request |
Result: Ready to submit
```

Full recorded run: [skill-runs/pr-reviewer.md](../../skill-runs/pr-reviewer.md)
