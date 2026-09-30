# AI-Ready Project Foundation

This repository sets up the engineering rules and the AI collaboration rules before any feature code exists.
Humans and AI agents follow the same spec-driven workflow:

request → specification → human approval → plan → tasks → implementation → validation → review

## Start here

- Agents: read [AGENTS.md](AGENTS.md) first. It links every governance document.
- Humans: read [CONTRIBUTING.md](CONTRIBUTING.md) and [constitution.md](constitution.md).

## Quick start

```sh
./scripts/validate.sh    # must end with VALIDATION PASSED
```

To propose a change, copy `specs/TEMPLATE.md` to `specs/<name>.md`, or ask an agent to run the
[spec-generator](skills/spec-generator/SKILL.md) skill. A human must approve the spec before anyone writes code.

## Status

- Technology stack: not chosen yet ([docs/decisions.md](docs/decisions.md)).
- `src/` and `tests/`: empty until a spec is approved.
