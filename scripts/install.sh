#!/usr/bin/env bash
# Install Ultimate AI Engineer (Bob Shell edition)
#
# Usage:
#   ./scripts/install.sh              # install into current directory + ~/.bob
#   ./scripts/install.sh /path/to/proj # install .bob/ into a different project
#
# Idempotent — safe to re-run. Skips files that already exist (warns).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_DIR="${1:-$(pwd)}"

echo "==> Repo:    $REPO_ROOT"
echo "==> Project: $PROJECT_DIR"
echo "==> Home:    $HOME/.bob"

# ---- Check bob is installed ----
if ! command -v bob >/dev/null 2>&1; then
  echo "ERROR: 'bob' not found in PATH."
  echo "       Install with: npm install -g bobshell"
  exit 1
fi
echo "==> bob version: $(bob --version 2>&1 | tail -1)"

# ---- Install user-level ----
mkdir -p "$HOME/.bob"

if [[ -f "$HOME/.bob/custom_modes.yaml" ]]; then
  ts="$(date +%Y%m%d-%H%M%S)"
  cp "$HOME/.bob/custom_modes.yaml" "$HOME/.bob/custom_modes.yaml.bak.$ts"
  echo "==> Backed up existing custom_modes.yaml → custom_modes.yaml.bak.$ts"
fi
cp "$REPO_ROOT/home/custom_modes.yaml" "$HOME/.bob/custom_modes.yaml"
echo "==> Installed ~/.bob/custom_modes.yaml (5 modes)"

[[ -f "$HOME/.bob/audit.log" ]] || cp "$REPO_ROOT/home/audit.log" "$HOME/.bob/audit.log"

# ---- Install project-level ----
mkdir -p "$PROJECT_DIR/.bob"

for sub in rules rules-code rules-plan commands context; do
  mkdir -p "$PROJECT_DIR/.bob/$sub"
  for f in "$REPO_ROOT/bob/$sub"/*.md; do
    [[ -e "$f" ]] || continue
    target="$PROJECT_DIR/.bob/$sub/$(basename "$f")"
    if [[ -e "$target" ]]; then
      echo "    SKIP (exists): $target"
    else
      cp "$f" "$target"
      echo "    +  $target"
    fi
  done
done

# AGENTS.md (don't overwrite if user already has one)
if [[ ! -e "$PROJECT_DIR/AGENTS.md" ]]; then
  cp "$REPO_ROOT/AGENTS.md" "$PROJECT_DIR/AGENTS.md"
  echo "==> Installed AGENTS.md (edit it for your project)"
else
  echo "==> AGENTS.md exists, leaving alone (review and add @imports manually)"
fi

# ---- Done ----
cat <<EOF

✅ Install complete.

Next steps:
  1. export BOBSHELL_API_KEY=<your-key>
  2. ./scripts/add-mcp-servers.sh        # configure MCP
  3. source ./scripts/bob-ai.sh          # load 'bob-ai' wrapper
  4. ./scripts/verify.sh                 # sanity check
  5. bob --chat-mode=ai-engineer "Hello, who are you?"

Docs: docs/SETUP.md
EOF
