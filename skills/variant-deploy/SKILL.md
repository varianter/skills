---
name: variant-deploy
description: >
  Deploy static web apps and files to Variant's hosting infrastructure via GitHub.
  Use this skill whenever a user wants to: share a vibed project, deploy an artifact,
  publish a Claude-generated app, push files to GitHub for hosting, make something
  accessible via a URL, deploy to share.variant.dev or artifacts.variant.dev, or
  says things like "deploy this", "publish this", "share this app", "put this online",
  "host this", "make this accessible", "push to GitHub", or "deploy to Variant",
  "legg ut", "publiser", "del dette", "gjør tilgjengelig", "last opp til Variant".
  Also trigger for any mention of external-artifacts or vibe-artifacts repos.
  Works from Claude.ai, Claude Code, and CoWork.
compatibility: Requires the Variant Internal MCP server to be connected
---

# Variant Deploy

Deploy static files and projects to Variant's hosting infrastructure.

## Two deployment targets

| Target       | Repo                           | URL                                         | Access                                  |
| ------------ | ------------------------------ | ------------------------------------------- | --------------------------------------- |
| **Public**   | `varianter/external-artifacts` | `https://share.variant.dev/<app-name>/`     | Anyone on the internet                  |
| **Internal** | `varianter/vibe-artifacts`     | `https://artifacts.variant.dev/<app-name>/` | Variant employees only (auth-protected) |

Both repos use the folder structure `apps/<app-name>/`. Whatever is in that folder is served.

**Two hosting modes are supported:**

- **Static files**: A plain static file server — `index.html` as entry point, plus any CSS/JS/images. No build step needed.
- **Vite projects**: If the app uses a framework (React, Vue, Svelte, etc.), structure it as a Vite project. The platform detects `package.json` + `vite.config.*` and runs the build automatically.

## Deployment workflow

### Step 1: Understand what's being deployed

Identify the files and what kind of project they form:

- **Plain HTML/CSS/JS** → deploy directly as static files
- **React, Vue, Svelte, or other SPA framework** → set up as a Vite project (see below)
- **Claude.ai artifact**: Use the code from the conversation artifact
- **Claude Code**: Ask which folder to deploy (`dist/`, `build/`, or source). If there's a `package.json` with a build script, ask whether to run the build first.
- **CoWork**: Collect the files the user has created or references

If there's no `index.html` and it's not a Vite project, let the user know and offer to create one.

### Step 2: Determine visibility

Ask: _"Should this be **public** (accessible to anyone at share.variant.dev) or **internal** (only Variant employees at artifacts.variant.dev)?"_

Read context clues — tools using HubSpot, Salesforce, internal APIs, employee data, or anything described as "internal" or "for the team" should default toward **internal**. Proactively suggest it.

### Step 3: Secrets check (public deployments only)

Before deploying to `varianter/external-artifacts`, scan all files for anything that looks like a secret:

- API keys or tokens (`sk-`, `Bearer `, `api_key`, `apiKey`, `API_KEY`, `token`, `password`, `secret`, `ACCESS_KEY`)
- Hardcoded credentials or connection strings
- Internal-only URLs or employee/customer data
- Business-sensitive content

**If secrets are found — stop completely:**

> ⚠️ **This is a PUBLIC deployment.** The source code will be visible to anyone on the internet, permanently. I found what looks like [describe what was found] in [filename]. Please remove it before deploying publicly, or deploy to the internal repo instead (artifacts.variant.dev — employees only).

Do not proceed with public deployment if secrets are present. Not even if the user asks you to.

### Step 4: Choose an app name

Ask for an app name if not already provided. The name becomes the URL path:

- Use kebab-case (e.g., `budget-tracker`, `team-dashboard`, `q4-rapport`)
- Short and descriptive
- No spaces or special characters

### Step 5: Check if the app already exists

Call the `github-app-exists` MCP tool with `app_name` and `repo` ("public" or "internal"). If it returns `"exists"`, stop and ask explicitly:

> An app called `<app-name>` already exists and is live at `<URL>`. Should I replace it with this new version? The existing files will be overwritten.

Only proceed if the user confirms.

### Step 6: Framework apps → Vite project setup

If the app uses React, Vue, Svelte, Solid, Preact, or any other SPA framework — or if the user has a rich app that can't run as plain static HTML — scaffold or rewrite it as a Vite project.

> This looks like a [React/Vue/etc.] app. I'll structure it as a Vite project so the platform can build and run it automatically.

**Rewriting a rich app for Vite deployment**

If someone has an app that uses server-side logic, a framework dev server, environment injection, or anything else that won't run as static files: convert it to a fully client-side Vite app. This means:

- Inline or remove any server-side data fetching (use `fetch()` to external APIs instead, or hardcode demo data if appropriate)
- Move any backend logic to the client, or replace it with a static data file
- Reconstruct the UI using the same framework (React, Vue, etc.) but wired up client-side only
- If the app uses secrets (API keys), tell the user those belong in the internal repo and will be visible in the browser bundle — confirm before proceeding

The goal is a complete, working app that runs entirely in the browser after `vite build`.

**What a Vite project needs:**

```
apps/<app-name>/
├── package.json          ← vite + framework deps, "build" and "dev" scripts
├── vite.config.js        ← MUST include base: '/<app-name>/'
├── index.html            ← Vite entry point (references /src/main.jsx etc.)
└── src/
    ├── main.jsx          ← app entry
    └── App.jsx           ← (and other components/files)
```

**The `base` in `vite.config.js` is critical** — without it, all asset URLs will be absolute paths (`/assets/...`) and break when served under the `/app-name/` subpath. Always show the full `vite.config.js` content when creating the file.

**`vite.config.js`** (always write this file in full):

```js
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  base: "/<app-name>/",
});
```

Adjust the plugin import for the framework being used:

- React: `@vitejs/plugin-react`
- Vue: `@vitejs/plugin-vue`
- Svelte: `@sveltejs/vite-plugin-svelte`
- Vanilla JS (no framework): omit `plugins` entirely

**`package.json`:**

```json
{
  "name": "<app-name>",
  "scripts": {
    "build": "vite build",
    "dev": "vite"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.0.0",
    "vite": "^5.0.0"
  }
}
```

The platform runs `npm install && npm run build` automatically — no manual build step needed.

### Step 7: Deploy via MCP tool

Call the `github-deploy-app` MCP tool with:
- `app_name`: the chosen app name
- `repo`: `"public"` or `"internal"`
- `files`: a JSON array of `{"path": "apps/<app-name>/...", "content": "..."}` for every file being deployed — preserving relative paths under `apps/<app-name>/`
- `author_name` + `author_email`: populate from the user's Variant profile or earlier conversation context if known; omit if not available

The tool creates a single atomic commit and returns the live URL and commit link — use those directly in Step 8.

**Hard constraints — never break these:**

- Only ever write inside `apps/` — never touch anything else in the repo
- Only deploy one app per invocation
- Do not construct a commit message manually — the tool handles that automatically

**If the MCP tool call fails:**

> Deployment failed. Please ensure the **Variant Internal MCP server** is connected and try again.

### Step 8: Confirm

Once deployed, use the live URL and commit link returned by `github-deploy-app` to tell the user:

> ✅ Deployed! Your app is live at: `<live URL>`
> Commit: `<commit URL>`
>
> It may take a moment for the build to complete and changes to propagate.

For Vite projects, add: _"The platform will build it automatically — it'll be ready in a minute or two."_
For internal deployments, add: _"Access requires Variant employee login."_

---

## Edge cases

**App needs a real backend**: Only static files and Vite-built SPAs are supported — no Node/Python/etc. servers. Rewrite it as a client-side Vite app (see Step 6). Move data fetching to the browser, replace server logic with direct API calls or static data, and reconstruct the UI using the same framework. If the rewrite isn't feasible (e.g., the app relies on a database with no public API), tell the user clearly what the limitation is.

**Multiple HTML files**: Fine for static deployments — all are served. Ensure `index.html` is the main entry point.

**User wants to delete an app**: This skill only handles deployment. Direct them to create a PR in the repo or contact a repo admin.

**Claude Code project with existing build setup**: Run `npm run build` (or equivalent), then deploy the output directory only — don't upload source files unless it's a Vite project meant to be built by the platform.
