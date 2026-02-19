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
