#!/usr/bin/env bash
# Validates repository structure, governance rules, secrets, and tests.
# Usage: ./scripts/validate.sh   (exit 0 and "VALIDATION PASSED" on success)
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

failures=0
fail() { echo "FAIL  $1"; failures=$((failures + 1)); }
section() { echo "==> $1"; }

section "Required paths"
for p in AGENTS.md README.md CONTRIBUTING.md constitution.md docs/standards.md docs/decisions.md \
  specs/TEMPLATE.md specs/sample-health-endpoint.md plans/TEMPLATE.md tasks/TEMPLATE.md \
  review/change-template.md src tests; do
  [ -e "$p" ] || fail "missing: $p"
done

section "AGENTS.md links all governance documents"
for doc in README.md CONTRIBUTING.md constitution.md docs/standards.md docs/decisions.md \
  specs/TEMPLATE.md specs/sample-health-endpoint.md plans/TEMPLATE.md tasks/TEMPLATE.md \
  review/change-template.md scripts/validate.sh; do
  grep -Fq "]($doc)" AGENTS.md || fail "AGENTS.md does not link $doc"
done

section "Skills and recorded runs"
for s in spec-generator pr-reviewer test-plan-generator; do
  [ -f "skills/$s/SKILL.md" ] || fail "missing required skill: $s"
done
for file in skills/*/SKILL.md; do
  name=$(basename "$(dirname "$file")")
  for h in "## Purpose" "## When to use" "## Required inputs" "## Steps" \
    "## Stop conditions" "## Output format" "## Quality checks" "## Example"; do
    grep -Fqx -- "$h" "$file" || fail "$file: missing heading '$h'"
  done
  grep -Fq "](skills/$name/SKILL.md)" AGENTS.md || fail "AGENTS.md does not link skills/$name/SKILL.md"
  run="skill-runs/$name.md"
  if [ -f "$run" ]; then
    grep -Fqx "## Input" "$run" && grep -Fqx "## Output" "$run" || fail "$run: needs '## Input' and '## Output'"
  else
    fail "missing recorded run: $run"
  fi
done
grep -Fq "review/change-template.md" skills/pr-reviewer/SKILL.md || fail "pr-reviewer does not use review/change-template.md"

section "Spec template sections"
for h in "## Status" "## Problem" "## Scope" "## Out of Scope" "## Requirements" "## Acceptance criteria" \
  "## Security" "## Dependencies" "## Open Questions" "## Human approval"; do
  grep -Fqx -- "$h" specs/TEMPLATE.md || fail "specs/TEMPLATE.md: missing '$h'"
done
grep -Eq 'Given .*When .*Then ' specs/TEMPLATE.md || fail "specs/TEMPLATE.md: no Given/When/Then example"

section "Review checklist questions"
for q in "Is an approved specification linked?" "Is the change within scope?" \
  "Are acceptance criteria covered by tests?" "Did validation pass?" "Are secrets absent?" \
  "Are dependencies justified?" "Are protected paths unchanged or approved?" "Are relevant documents updated?"; do
  grep -Fq -- "$q" review/change-template.md || fail "review/change-template.md: missing '$q'"
done

section "Spec status and human approval"
approved=0
for spec in specs/*.md; do
  [ "$spec" = "specs/TEMPLATE.md" ] && continue
  status=$(sed -n 's/^Status: //p' "$spec" | head -n 1)
  case "$status" in
    Draft | "In Review" | Rejected) ;;
    Approved)
      if grep -Eq '^Approved by: [^<[:space:]]' "$spec" && grep -Eq '^Date: [0-9]{4}-[0-9]{2}-[0-9]{2}$' "$spec"; then
        approved=$((approved + 1))
      else
        fail "$spec: Status Approved but Human approval name/date missing"
      fi ;;
    *) fail "$spec: missing or invalid 'Status:' line" ;;
  esac
done

section "No code or tests without an approved spec"
code_files=$(find src tests -type f ! -name .gitkeep | wc -l)
if [ "$code_files" -gt 0 ] && [ "$approved" -eq 0 ]; then
  fail "src/ or tests/ contain $code_files file(s) but no spec is Approved"
fi

section "Secret scan"
patterns=(
  'AKIA[0-9A-Z]{16}'
  '-----BEGIN [A-Z ]*PRIVATE KEY-----'
  'gh[pousr]_[A-Za-z0-9]{36}'
  'sk-[A-Za-z0-9_-]{20,}'
  "(password|passwd|secret|api[_-]?key|token)[\"']?[[:space:]]*[:=][[:space:]]*[\"'][^\"'<>[:space:]]{8,}[\"']"
)
for p in "${patterns[@]}"; do
  hits=$(grep -rIlE -i --exclude-dir=.git --exclude-dir=.idea -e "$p" . || true)
  [ -z "$hits" ] || fail "possible secret in: $(echo "$hits" | tr '\n' ' ')"
done

section "Markdown files are short (max 200 lines)"
while IFS= read -r f; do
  lines=$(wc -l <"$f")
  [ "$lines" -le 200 ] || fail "$f has $lines lines"
done < <(find . -name '*.md' -not -path './.git/*' -not -path './.idea/*')

section "Tests"
if [ -f tests/run.sh ]; then
  bash tests/run.sh || fail "tests/run.sh failed"
else
  echo "INFO  tests/run.sh not present; no tests to run"
fi

if [ "$failures" -eq 0 ]; then
  echo "VALIDATION PASSED"
else
  echo "VALIDATION FAILED ($failures problem(s))"
  exit 1
fi
