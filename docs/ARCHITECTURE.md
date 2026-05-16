# Architecture

## Design philosophy

**This is a project template, not an installer.** You clone the repo, work inside it, and Bob auto-discovers everything from the working directory. Nothing is copied to `~/.bob/`. Nothing is global. The repo IS the agent configuration.

Why: predictability + portability. Two devs cloning the same repo get bit-identical agent behavior. Removing the repo removes the agent. No drift between `~/.bob/` and the project.

## How Bob discovers the config

Bob searches the working directory (and parents) for these files at launch:

| Path | Purpose | When loaded |
|---|---|---|
| `AGENTS.md` | Entry-point project context (with `@imports`) | Always |
| `.bobrules` | Single-file rules fallback | Always (if no `.bob/rules/`) |
| `.bob/rules/*.md` | Always-on rules | Every turn |
| `.bob/rules-{mode}/*.md` | Mode-scoped rules | Only in that mode |
| `.bob/commands/*.md` | Slash commands | When invoked |
| `.bob/settings.json` | MCP servers + project settings | At launch |

`@imports` in `AGENTS.md` follow up to depth 5, with circular-import detection.

## Mode-scoped rules vs custom modes

Bob has two ways to specialize behavior:

1. **Custom modes** (`~/.bob/custom_modes.yaml`) — fully separate personas with their own role, tools, and instructions. Lives in `~/.bob/`, so it's user-level (not portable per-project).
2. **Mode-scoped rules** (`.bob/rules-{mode}/`) — additive instructions layered on top of Bob's 4 native modes (`plan`, `code`, `ask`, `advanced`). Lives in the project, so it's portable.

This template uses **option 2** because the repo is the source of truth. We map AI engineering personas onto the native modes:

| Native Bob mode | Persona we layer on | Rationale |
|---|---|---|
| `plan` | Planning checklist | Bob's built-in planning + our evidence-first amendments |
| `code` | Senior AI engineer + MLOps + eval engineer | Code mode is where you implement; all three personas share the "produce running code" intent |
| `ask` | ML researcher | Ask mode is read-only; perfect for literature review |
| `advanced` | ML security auditor | Advanced mode has cross-cutting tool access; needed for audits |

## Why the hierarchy

```
AGENTS.md                               ← project facts (replaceable per-project)
  └─ @ imports .bob/context/*.md        ← stack, conventions, pitfalls
.bob/rules/*.md                         ← engineering discipline (universal)
.bob/rules-{mode}/*.md                  ← role expertise (mode-gated)
.bob/commands/*.md                      ← reusable workflows
.bob/settings.json                      ← MCP servers (tools)
```

The split lets you:
- Replace `AGENTS.md` and `.bob/context/*.md` per project without touching engineering principles
- Keep `.bob/rules/` stable across projects (TDD doesn't change)
- Toggle persona depth by switching mode (plan/code/ask/advanced)
- Restrict tool blast radius per-session via `--allowed-mcp-server-names`

## MCP server safety model

`.bob/settings.json` declares servers with `${ENV_VAR}` references — keys never live in the repo. Servers fall into three risk tiers:

| Tier | Servers | Default trust |
|---|---|---|
| Read-only knowledge | context7, arxiv, brave-search, firecrawl | Safe |
| Read-write local | filesystem, git, memory | Scoped to cwd |
| Read-write remote | github, huggingface, e2b, sentry | Requires explicit env keys |
| Dynamic analysis | semgrep | Local sandbox |

For high-stakes sessions, restrict the set:

```bash
bob --allowed-mcp-server-names context7 arxiv --chat-mode ask "..."
```

## What's intentionally NOT here

- **No installer / wrapper script** — `bob` itself is the entry point
- **No `~/.bob/` writes** — the repo is fully self-contained
- **No custom modes** — uses Bob's 4 native modes + mode-scoped rules instead
- **No CI scaffolding** — that's project-specific, add per-repo

If you need cross-project AI engineering defaults, fork this template, push your version, and clone it as your starting point.
