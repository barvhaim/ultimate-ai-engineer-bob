#!/usr/bin/env bash
# Post-install sanity check.
set -uo pipefail

ok=0; fail=0
check() {
  local label="$1"; shift
  if "$@" >/dev/null 2>&1; then
    echo "  ✅ $label"
    ok=$((ok+1))
  else
    echo "  ❌ $label"
    fail=$((fail+1))
  fi
}

echo "==> Verifying installation..."

check "bob in PATH"               command -v bob
check "BOBSHELL_API_KEY set"      bash -c '[[ -n "${BOBSHELL_API_KEY:-}" ]]'
check "~/.bob/custom_modes.yaml"  test -f "$HOME/.bob/custom_modes.yaml"
check ".bob/rules/ exists"        test -d ".bob/rules"
check ".bob/commands/ exists"     test -d ".bob/commands"
check "AGENTS.md present"         test -f "AGENTS.md"

echo
echo "==> Custom modes registered:"
if [[ -f "$HOME/.bob/custom_modes.yaml" ]]; then
  grep -E '^\s+- slug:' "$HOME/.bob/custom_modes.yaml" | sed 's/^/  /'
fi

echo
echo "==> Rules in .bob/rules/:"
ls .bob/rules/*.md 2>/dev/null | sed 's/^/  /' || echo "  (none)"

echo
echo "==> Slash commands in .bob/commands/:"
ls .bob/commands/*.md 2>/dev/null | sed 's/^/  /' || echo "  (none)"

echo
echo "==> MCP servers (bob mcp list):"
bob mcp list 2>&1 | sed 's/^/  /' | head -40 || echo "  (could not list)"

echo
echo "==> Result: $ok ok / $fail fail"
[[ $fail -eq 0 ]] || exit 1
