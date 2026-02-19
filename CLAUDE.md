# Variant Skills

Skill development workspace for Variant's Claude Team. Skills developed here are distributed to the team for use in Claude.ai Team.

## Prerequisites

The `skill-creator` plugin must be installed to get skill creation guidance and tooling:

```
/plugin install skill-creator
```

## Structure

```
skills/          ← skills being developed for Variant (auto-discovered by Claude)
.claude-plugin/
  plugin.json    ← makes this a Claude Code plugin
```

## Creating a New Skill

1. Ask Claude to create a new skill — the `skill-creator` plugin will guide the process
2. Or scaffold manually:
   ```bash
   python ~/.claude/plugins/.../skill-creator/scripts/init_skill.py <skill-name> --path skills/
   ```
3. Edit `skills/<skill-name>/SKILL.md` with frontmatter and instructions
4. Add scripts, references, or assets as needed
5. Test by using the skill in this project (auto-loaded)

## Packaging for Distribution

```bash
python ~/.claude/plugins/.../skill-creator/scripts/package_skill.py skills/<skill-name>/
```

Produces a `.skill` file ready to distribute to the team.

## Conventions

- Skill directories use kebab-case
- Each skill must have `SKILL.md` with `name` and `description` frontmatter
- Keep `SKILL.md` under 500 lines — move detail into `references/` files
- Scripts → `scripts/`, documentation → `references/`, templates/assets → `assets/`
