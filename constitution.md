# Constitution

These seven principles govern every change. If another document conflicts with them, the principles win. Tell a human about the conflict.

## 1. Specification before implementation

No one writes code until a human has approved a specification for it.
In practice, this means… every change to `src/` or `tests/` links a spec with `Status: Approved` and a human approver name and date.

## 2. Simplicity

The simplest solution that meets the approved requirements is the right one.
In practice, this means… no speculative features, abstractions, or dependencies, and every file stays short and focused.

## 3. Verifiable quality

A change is done only when evidence shows that it works.
In practice, this means… every acceptance criterion has a test, and `./scripts/validate.sh` passes before submission.

## 4. Security by default

The safe option is the default option.
In practice, this means… no secrets in the repository, config from the environment, and tests and security checks that are never weakened to make a change pass.

## 5. Documented decisions

Decisions that affect other people are written down where those people will find them.
In practice, this means… every choice of technology, dependency, or process goes in `docs/decisions.md` with its reason and who approved it.

## 6. Human control of ambiguity

Humans resolve ambiguity. Agents bring it to their attention.
In practice, this means… an unclear requirement becomes an Open Question, and the agent stops and asks instead of guessing.

## 7. Focused changes

Each change does one approved thing.
In practice, this means… one spec per change, no unrelated edits, and protected paths stay unchanged unless a human approves.
