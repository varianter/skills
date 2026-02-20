# Agents

## Validation

When modifying any skill (files under `skills/`), always run validation before committing:

```bash
bun run ./tools/validate.ts ./skills/<skill-name>
```

For example:

```bash
bun run ./tools/validate.ts ./skills/kompetansematrise-filler
```

Fix any validation errors before considering the change complete.

## Linting and formatting

When modifying any file under `tools/`, always run the linter/formatter afterwards:

```bash
bun run check
```

To auto-fix formatting issues:

```bash
bun run format
```

Fix any remaining lint errors manually. All checks must pass before considering the change complete.
