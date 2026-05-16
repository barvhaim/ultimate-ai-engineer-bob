# Setup Guide

## 1. Prerequisites

```bash
# Bob Shell
npm install -g bobshell
bob --version
bob --accept-license

# Auth — non-interactive requires API key (SSO hangs in scripts)
export BOBSHELL_API_KEY=<your-key>     # find in Slack from "Ask Bob" or proxy .env
echo 'export BOBSHELL_API_KEY=...' >> ~/.zshrc
```

Optional but recommended:
- `node` ≥ 18
- `uv` (for `uvx ...` MCP servers)
- `ruff` (for the wrapper's auto-format)

## 2. Install

```bash
git clone https://github.com/njs2017/ultimate-ai-engineer-bob ~/dev/uae-bob
cd ~/dev/uae-bob

# Install into the current project + ~/.bob
./scripts/install.sh

# Or into a different project
./scripts/install.sh /path/to/your/ml-project
```

The installer:
- Backs up your existing `~/.bob/custom_modes.yaml` (if any) and replaces it
- Drops `.bob/rules/`, `.bob/rules-code/`, `.bob/rules-plan/`, `.bob/commands/`, `.bob/context/` into the project
- Creates a starter `AGENTS.md` (only if missing)
- Skips files that already exist with a SKIP message

## 3. Add MCP servers

```bash
./scripts/add-mcp-servers.sh
bob mcp list
```

Set the env vars at the bottom of that script for any servers you actually plan to use.

## 4. Load the safe wrapper

```bash
echo 'source ~/dev/uae-bob/scripts/bob-ai.sh' >> ~/.zshrc
source ~/.zshrc
```

Now you have:
- `bob-ai "task"` — defaults to `ai-engineer` mode, max-coins cap, audit log, post-format
- `bob-ai-yolo "task"` — YOLO mode (interactive confirm + sandbox check)
- `bob-research`, `bob-secaudit`, `bob-eval`, `bob-mlops`, `bob-plan` — mode shortcuts

## 5. Verify

```bash
./scripts/verify.sh
```

Expected: all checks pass, 5 modes listed, 7 rules, 5 commands, MCP servers reachable.

## 6. First run

```bash
bob-ai "Show me the AI engineer workflow rules and explain what mode you're in"

# Or interactive
bob -i ""
> /mode ai-engineer
> what's my workflow for a new project?
> /mode plan
> draft a plan for DPO fine-tuning of llama-3.2-3b
```

## 7. Customize per project

Edit (no reinstall needed — Bob re-reads on each session):
- `AGENTS.md` — project goals, commands, "don't" list
- `.bob/context/active-experiments.md` — what's in flight right now
- `.bob/context/known-pitfalls.md` — gotchas you've already hit
- `.bob/rules/` — add project-specific rules with `08-`, `09-` prefixes

User-level (re-runs of `install.sh` will overwrite — keep your own copy):
- `~/.bob/custom_modes.yaml` — add modes for new personas
