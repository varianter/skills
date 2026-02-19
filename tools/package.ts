#!/usr/bin/env bun
/**
 * Skill Packager - Creates a distributable .skill file from a skill folder
 *
 * Usage:
 *   bun run tools/package.ts <path/to/skill-folder> [output-directory]
 *
 * Example:
 *   bun run tools/package.ts skills/my-skill
 *   bun run tools/package.ts skills/my-skill ./dist
 */

import { existsSync, readdirSync, statSync } from "node:fs";
import { join, relative, resolve, basename } from "node:path";
import { validateSkill } from "./validate";

function collectFiles(dir: string): string[] {
  const files: string[] = [];
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    if (statSync(full).isDirectory()) {
      files.push(...collectFiles(full));
    } else {
      files.push(full);
    }
  }
  return files;
}

async function packageSkill(
  skillPath: string,
  outputDir?: string,
): Promise<string | null> {
  const absSkillPath = resolve(skillPath);

  if (!existsSync(absSkillPath)) {
    console.error(`❌ Error: Skill folder not found: ${absSkillPath}`);
    return null;
  }

  if (!statSync(absSkillPath).isDirectory()) {
    console.error(`❌ Error: Path is not a directory: ${absSkillPath}`);
    return null;
  }

  if (!existsSync(join(absSkillPath, "SKILL.md"))) {
    console.error(`❌ Error: SKILL.md not found in ${absSkillPath}`);
    return null;
  }

  console.log("🔍 Validating skill...");
  const result = validateSkill(absSkillPath);
  if (!result.valid) {
    console.error(`❌ Validation failed: ${result.message}`);
    console.error("   Please fix the validation errors before packaging.");
    return null;
  }
  console.log(`✅ ${result.message}\n`);

  const skillName = basename(absSkillPath);
  const absOutputDir = outputDir ? resolve(outputDir) : resolve(".");

  await Bun.$`mkdir -p ${absOutputDir}`;

  const skillFile = join(absOutputDir, `${skillName}.skill`);
  const files = collectFiles(absSkillPath);
  const skillParent = resolve(absSkillPath, "..");

  // Bun doesn't have a built-in zip API, so we shell out to the system zip tool
  const relFiles = files.map((f) => relative(skillParent, f));

  const { exitCode, stderr } = await Bun.$`zip -r ${skillFile} ${skillName}`
    .cwd(skillParent)
    .quiet();

  if (exitCode !== 0) {
    console.error(`❌ Error creating .skill file: ${stderr.toString()}`);
    return null;
  }

  for (const f of relFiles) {
    console.log(`  Added: ${f}`);
  }

  console.log(`\n✅ Successfully packaged skill to: ${skillFile}`);
  return skillFile;
}

const args = process.argv.slice(2);
if (args.length < 1 || args.length > 2) {
  console.error(
    "Usage: bun run tools/package.ts <path/to/skill-folder> [output-directory]",
  );
  console.error("\nExample:");
  console.error("  bun run tools/package.ts skills/my-skill");
  console.error("  bun run tools/package.ts skills/my-skill ./dist");
  process.exit(1);
}

const result = await packageSkill(args[0], args[1]);
process.exit(result ? 0 : 1);
