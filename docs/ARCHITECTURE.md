# Architecture

## How Bob assembles context

On every session, Bob loads in this order:
1. **Mode** (`--chat-mode=X` or `/mode X`) — `roleDefinition` + `customInstructions` from `~/.bob/custom_modes.yaml`
2. **Workspace rules** — every `.md` in `.bob/rules/` (alphabetical)
3. **Mode-specific rules** — every `.md` in `.bob/rules-<mode>/` (alphabetical, takes precedence)
4. **AGENTS.md** + everything it `@`-imports (recursively, max depth 5)
5. **Slash command body** — when you type `/cmd args`, the markdown file is rendered with `$1..$N` substitution

Single-file alternative: `.bobrules` at the repo root replaces `.bob/rules/`.

## Why this layout

| Layer | Why |
|---|---|
| `custom_modes.yaml` (user-level) | Identity persists across all projects |
| `.bob/rules/` (project-level) | Universal rules that apply regardless of mode |
| `.bob/rules-code/`, `.bob/rules-plan/` | Mode-specific behavior — keeps plan mode focused, code mode disciplined |
| `.bob/commands/` | Reusable workflows — same format as Claude Code commands |
| `.bob/context/` | Modular project state — imported by `AGENTS.md` so files can be edited without touching the entrypoint |
| Wrapper script | Caps cost, audits, auto-formats — the things Bob doesn't have native hooks for |

## Subagents pattern

Claude Code has subagents as their own files. Bob has **modes** that you switch between with `/mode <slug>`. The 5 modes here are:

- `ai-engineer` — the default; full read/edit/command/browser
- `ml-researcher` — read-only + browser; for literature reviews
- `security-auditor` — read-only + browser; can't accidentally edit during audit
- `eval-engineer` — read/edit/command; runs benchmarks
- `mlops-engineer` — read/edit/command; deploys

The `groups:` field in each mode is the actual permission boundary. Audit/research modes are read-only by design.

## Why no native hooks

Bob has extensions (`bob extensions new`) but no Claude-Code-style hooks. The wrapper (`bob-ai.sh`) covers 90% of what hooks normally do:
- Pre-run: `--pre-check-auto-approved` flag
- Cost cap: `--max-coins`
- Post-run: ruff format on changed files, audit log entry

For deeper integration (block `rm -rf`, scan secrets, custom slash command logic) build a real Bob extension — see `bob extensions new` scaffolding.

## MCP server choice

| Server | What it gives Bob |
|---|---|
| context7 | Live, version-correct library docs (kills API hallucination) |
| arxiv | Paper search by topic/author/category |
| brave-search / firecrawl | Web search + scraping |
| filesystem | Sandboxed file ops outside the workspace |
| git / github | Repo-aware commits, PRs, issues |
| huggingface | Model/dataset metadata, downloads |
| e2b | Sandboxed code execution (don't run risky code locally) |
| semgrep | Security scanning |
| postgres | Read-only DB introspection |
| sentry | Error context for debugging |
| linear | Ticketing |
| memory | Cross-session note storage |

Restrict per session with `--allowed-mcp-server-names a b c` when you don't need everything.

## Cost shape

| Activity | Suggested cap |
|---|---|
| One slash command (`/eval`) | `--max-coins 100` |
| Plan mode | `--max-coins 50` |
| Single feature implementation | `--max-coins 200` (default in wrapper) |
| Long autonomous run (AutoResearch) | `--max-coins 500` per iteration, restart between iterations |
| CI/automation | `--max-coins 100`, `-y`, `-o json` |
