# Migration from Claude Code

If you already have a working Claude Code setup, here's how to port it.

## Concept map

| Claude Code | Bob Shell |
|---|---|
| `CLAUDE.md` | `AGENTS.md` (Bob's standard) |
| `~/.claude/skills/<name>/SKILL.md` | `.bob/rules/<name>.md` (auto-loaded) |
| `.claude/agents/<slug>.md` | `~/.bob/custom_modes.yaml` entry with matching `slug` |
| `.claude/commands/<name>.md` | `.bob/commands/<name>.md` (same markdown format!) |
| `.claude/settings.json` hooks | Bob extension (`bob extensions new`) or wrapper script |
| `--append-system-prompt-file` | `roleDefinition` field in custom mode |
| `--allowedTools` | `--allowed-tools` |
| `--dangerously-skip-permissions` | `-y` / `--yolo` / `--approval-mode yolo` |
| `--max-budget-usd` | `--max-coins` |
| `claude -p "task"` | `bob "task"` (positional defaults to one-shot) |
| `claude -c` (continue) | `bob --resume latest` |
| `claude -r <id>` | `bob --resume <index>` |
| `claude mcp add` | `bob mcp add <name> <cmdOrUrl>` |

## Mechanical migration

```bash
# 1. CLAUDE.md → AGENTS.md (keep Claude compat with a symlink)
mv CLAUDE.md AGENTS.md
ln -s AGENTS.md CLAUDE.md

# 2. Skills → .bob/rules/  (flatten one level)
mkdir -p .bob/rules
i=0
for f in ~/.claude/skills/*/SKILL.md; do
  name=$(basename "$(dirname "$f")")
  i=$((i+1))
  printf -v idx '%02d' "$i"
  cp "$f" ".bob/rules/${idx}-${name}.md"
done

# 3. Slash commands — same format, just move them
mkdir -p .bob/commands
cp .claude/commands/*.md .bob/commands/

# 4. List existing MCP servers, then re-add to bob
claude mcp list
# bob mcp add <name> <cmdOrUrl>   # for each
```

## Subagents — manual conversion

Claude Code subagents (`.claude/agents/<name>.md`) need to be converted to YAML entries.

**Claude format:**
```markdown
---
name: ml-researcher
description: ML research scientist
tools: Read, WebSearch
---
# ML Researcher
You are an ML research scientist...
```

**Bob equivalent** in `~/.bob/custom_modes.yaml`:
```yaml
- slug: ml-researcher
  name: 🔬 ML Researcher
  roleDefinition: You are an ML research scientist...
  whenToUse: Use for literature reviews and SOTA comparison.
  customInstructions: |-
    - Always cite arXiv IDs
    - ...
  groups:
    - read
    - browser    # equivalent of WebSearch
```

Field mapping:
- Claude `name` → Bob `slug`
- Claude system prompt body → split into `roleDefinition` (one line) + `customInstructions` (the rest)
- Claude `tools: Read` → Bob `groups: [read]`
- Claude `tools: Read, Edit, Bash` → Bob `groups: [read, edit, command]`
- Claude `tools: Read, WebSearch` → Bob `groups: [read, browser]`

## Hooks — no direct port

Claude Code hooks in `.claude/settings.json` don't have a Bob equivalent. Two paths:

1. **Wrapper script** (recommended for simple cases) — see `scripts/bob-ai.sh`
2. **Bob extension** (for anything complex) — `bob extensions new ./my-ext`

Common conversions:
- `pre-tool-use` hook to block `rm -rf` → `--allowed-tools` whitelist + `--pre-check-auto-approved`
- `post-tool-use` hook for auto-format → wrapper post-run section (ruff format on changed files)
- Audit log → wrapper `printf >> ~/.bob/audit.log`

## What you lose

- **Native skill system** — Bob loads everything in `.bob/rules/` every session. Keep each rule short.
- **Per-tool permissions UX** — Bob has `groups:` (coarse-grained), no per-tool toggle in the same way.
- **MCP `--strict-mcp-config`** — use `--allowed-mcp-server-names` instead.

## What you gain

- **`@` imports in AGENTS.md** — modular context Bob does natively, Claude doesn't.
- **`groups:` permission model** — read/edit/command/browser per mode is cleaner than per-tool flags.
- **`--approval-mode auto_edit`** — middle ground between full prompt and full YOLO that Claude doesn't have.
- **`--max-coins`** — IBM's spend cap is enforced server-side; harder to bypass than client-side budget tracking.
