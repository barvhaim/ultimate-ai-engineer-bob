#!/usr/bin/env bash
# Safe wrapper for daily Bob usage.
#   source ./scripts/bob-ai.sh
# then use:
#   bob-ai "Implement DPO training loop"
#   bob-ai-yolo "Long autonomous task"   # only inside a sandbox/worktree!
#
# Adds:
#   - default to ai-engineer mode
#   - --max-coins cap
#   - --pre-check-auto-approved safety scan
#   - post-run auto-format of changed Python
#   - audit log at ~/.bob/audit.log

bob-ai() {
  local args=("$@")
  local mode_present=0
  for a in "${args[@]}"; do
    [[ "$a" == --chat-mode=* || "$a" == --chat-mode || "$a" == -m* ]] && mode_present=1
  done

  local default_mode_args=()
  [[ $mode_present -eq 0 ]] && default_mode_args=(--chat-mode=ai-engineer)

  if ! command -v bob >/dev/null 2>&1; then
    echo "ERROR: bob not in PATH" >&2
    return 1
  fi

  bob \
    "${default_mode_args[@]}" \
    --pre-check-auto-approved \
    --max-coins "${BOB_MAX_COINS:-200}" \
    "${args[@]}"
  local rc=$?

  # Post-run: format any python that changed
  if command -v ruff >/dev/null 2>&1; then
    git diff --name-only --diff-filter=AM 2>/dev/null \
      | grep -E '\.py$' \
      | xargs -r ruff check --fix 2>/dev/null || true
    git diff --name-only --diff-filter=AM 2>/dev/null \
      | grep -E '\.py$' \
      | xargs -r ruff format 2>/dev/null || true
  fi

  # Audit log
  mkdir -p "$HOME/.bob"
  printf "%s | bob-ai | rc=%d | %s\n" \
    "$(date -Iseconds)" "$rc" "$*" >> "$HOME/.bob/audit.log"

  return $rc
}

bob-ai-yolo() {
  echo "⚠️  YOLO mode — auto-approves everything. Make sure you're in a sandbox/worktree."
  read -r -p "Continue? (y/N) " ans
  [[ "$ans" == "y" || "$ans" == "Y" ]] || return 1
  BOB_MAX_COINS="${BOB_MAX_COINS:-500}" bob-ai -y "$@"
}

# Specialized one-liners
bob-research()  { bob-ai --chat-mode=ml-researcher    "$@"; }
bob-secaudit()  { bob-ai --chat-mode=security-auditor "$@"; }
bob-eval()      { bob-ai --chat-mode=eval-engineer    "$@"; }
bob-mlops()     { bob-ai --chat-mode=mlops-engineer   "$@"; }
bob-plan()      { bob-ai --chat-mode=plan             "$@"; }

echo "✅ bob-ai loaded. Commands: bob-ai, bob-ai-yolo, bob-research, bob-secaudit, bob-eval, bob-mlops, bob-plan"
echo "   Override max-coins per call: BOB_MAX_COINS=400 bob-ai \"...\""
