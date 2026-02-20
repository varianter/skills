# Variant Skills

Collection of skills for Variant Team in Claude. Skills are developed and maintained here, then packaged for distribution to the team via Claude.ai Team.

## Structure

```
skills/          ← skill directories (auto-discovered by Claude)
tools/           ← CLI scripts for validating and packaging skills
```

Each skill lives in its own directory under `skills/` and must contain a `SKILL.md` file with YAML frontmatter.

## Creating a skill

Use the **skill-creator** plugin (installed in this repo). Ask Claude to create a new skill — the plugin will guide the process. Ensure the plugin is installed:

```
/plugin install skill-creator
```

After creating a skill, use the tools below to validate and package it.

Then edit `skills/<skill-name>/SKILL.md`. Conventions:

- Directory names use kebab-case
- Required frontmatter fields: `name`, `description`
- Keep `SKILL.md` under 500 lines — move detail into `references/`
- Scripts → `scripts/`, documentation → `references/`, templates/assets → `assets/`

## Tools

### Validate a skill

```bash
bun run tools/validate.ts skills/<skill-name>
```

Checks that `SKILL.md` exists, frontmatter is valid YAML, required fields are present, and naming conventions are followed.

### Package a skill for distribution

```bash
bun run tools/package.ts skills/<skill-name> [output-directory]
```

Validates the skill, then produces a `<skill-name>.skill` file ready to share with the team. Output defaults to the current directory.

See [`tools/README.md`](tools/README.md) for full details on both tools.
