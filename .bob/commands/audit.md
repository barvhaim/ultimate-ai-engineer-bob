---
description: Security audit for a path — Semgrep + ML-specific checks
argument-hint: <path>
---
Security audit on: $1

1. Switch to /mode security-auditor
2. Run Semgrep MCP on the path
3. Run ML-specific checks:
   - Insecure deserialization (pickle / `torch.load(weights_only=False)` on untrusted input)
   - PII in code, configs, logs
   - Hardcoded secrets / tokens
   - HF Hub repos pinned by revision (not `main`)
   - Prompt injection vectors in user-facing endpoints
4. Output findings as: [SEVERITY] file:line — issue / fix / rationale
5. Save the report to `docs/security/$(date +%Y-%m-%d)-$1.md` (slugified)
