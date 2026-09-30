# Standards

Each rule has a Yes/No answer. Each section has one good example and one bad example.

## Naming

- Are new files and folders named in lowercase kebab-case? The fixed names in [AGENTS.md](../AGENTS.md) are the exception.
- Do the spec, plan, and tasks for one change share a name (`specs/x.md`, `plans/x.md`, `tasks/x.md`)?
- Are acceptance criteria, requirements, and tasks numbered `AC-n`, `REQ-n`, and `T-n`?

Good: `specs/health-endpoint.md`, `plans/health-endpoint.md`, `tasks/health-endpoint.md`
Bad: `specs/HealthEndpoint_v2 FINAL.md`, `plans/plan1.md`

## Change submission

- Does the change implement exactly one spec, or is it one documentation or config change?
- Does the commit message use `<type>(<name>): <summary>`, where type is `feat`, `fix`, `docs`, `test`, or `chore`?
- Does the change description include a completed [review/change-template.md](../review/change-template.md)?

Good: `feat(health-endpoint): return 200 with status OK`, plus a review checklist with every answer backed by evidence
Bad: `updates`, a commit that mixes a feature, a refactor, and a dependency upgrade, with no checklist

## Documentation

- Does each file have one purpose and 200 lines or fewer?
- Does every rule have a Yes/No answer?
- Were the affected documents updated in the same change that changed the behavior?
- Does the file link to the source instead of copying content that already exists?

Good: "Run `./scripts/validate.sh` before submitting. It must end with `VALIDATION PASSED`."
Bad: "Try to test things properly where possible."

## Dependencies

- Does the approved spec name each new dependency and give the reason for it?
- Is each dependency pinned to an exact version and recorded in [docs/decisions.md](decisions.md)?
- Was the standard library considered first?

Good: The spec says "Dependencies: none. Use the standard library HTTP server." The code imports nothing else.
Bad: Someone adds a popular web framework and five plugins "for later" that no spec mentions.

## Security

- Is the change free of secrets, with every secret read from an environment variable?
- Does `.env.example` contain only placeholders?
- Is all external input validated before use?
- Are auth, validation, TLS, and security checks all left enabled?

Good: The code reads `DB_PASSWORD` from the environment, and `.env.example` contains `DB_PASSWORD=<set-me>`.
Bad: `password = "<real password>"` is committed in a source file "just for local testing".

## Testing

- Does every acceptance criterion have at least one test that names its ID, such as `ac1`?
- Does `tests/run.sh` run all tests without network access or manual steps?
- Were failing tests fixed instead of deleted, skipped, or loosened?

Good: `test_ac1_get_health_returns_200` fails before the change and passes after it.
Bad: A failing test is marked `skip` so that validation passes.
