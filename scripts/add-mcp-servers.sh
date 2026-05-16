#!/usr/bin/env bash
# Add MCP servers to Bob Shell.
# Edit the lists below to match what you actually need.
# Re-run safely — `bob mcp add` is idempotent for matching configs (or use 'remove' first).

set -euo pipefail

if ! command -v bob >/dev/null 2>&1; then
  echo "ERROR: bob not in PATH. npm install -g bobshell"
  exit 1
fi

echo "==> Adding MCP servers..."

# ---- Knowledge & Research ----
bob mcp add context7      "npx -y @upstash/context7-mcp"            || true
bob mcp add arxiv         "uvx arxiv-mcp-server"                    || true
bob mcp add brave-search  "npx -y @modelcontextprotocol/server-brave-search" || true
bob mcp add firecrawl     "npx -y firecrawl-mcp"                    || true

# ---- Code & Repo ----
bob mcp add filesystem    "npx -y @modelcontextprotocol/server-filesystem $HOME/projects" || true
bob mcp add git           "uvx mcp-server-git"                      || true
bob mcp add github        "npx -y @modelcontextprotocol/server-github" || true

# ---- AI / ML specific ----
bob mcp add huggingface   "npx -y @huggingface/mcp-server"          || true
bob mcp add e2b           "npx -y @e2b/mcp-server"                  || true
bob mcp add semgrep       "uvx semgrep-mcp"                         || true

# ---- Data ----
# bob mcp add postgres "npx -y @modelcontextprotocol/server-postgres postgresql://readonly:pass@host/db" || true

# ---- Observability / Productivity ----
bob mcp add sentry        "npx -y @sentry/mcp-server"               || true
bob mcp add linear        "npx -y @tacticlaunch/mcp-linear"         || true
bob mcp add memory        "npx -y @modelcontextprotocol/server-memory" || true

echo
echo "==> Configured MCP servers:"
bob mcp list

cat <<EOF

Reminder — set these env vars for the servers that need them:
  BRAVE_API_KEY                   (brave-search)
  FIRECRAWL_API_KEY               (firecrawl)
  GITHUB_PERSONAL_ACCESS_TOKEN    (github)
  HF_TOKEN                        (huggingface)
  E2B_API_KEY                     (e2b)
  SENTRY_AUTH_TOKEN, SENTRY_ORG   (sentry)
  LINEAR_API_KEY                  (linear)

Restrict per-session with:
  bob --allowed-mcp-server-names context7 arxiv huggingface --chat-mode=ai-engineer "..."
EOF
