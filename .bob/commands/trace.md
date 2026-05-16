---
description: Push the current Bob session trace to a HuggingFace traces dataset
argument-hint: <repo-name> [--tag task=<x>] [--tag outcome=success|failure|partial]
---

# /trace

Push this session's trace to `$1` as a dataset of `type=traces`.

## Steps

1. **Locate the trace** — Bob writes JSONL session logs under `~/.bob/sessions/<session-id>.jsonl`. Find the current session id from `BOB_SESSION_ID` env or the most recent file.

2. **Privacy scrub** — before upload:
   - Strip lines matching `(?i)(api[-_]?key|secret|token|password|bearer)`
   - Redact absolute paths under `$HOME` to `~`
   - Drop tool outputs containing `.env` content or `Authorization:` headers
   - If unsure, ABORT and ask the user

3. **Compute trace metadata**:
   - `outcome` — ask the user (success / failure / partial / abandoned)
   - `tools_used` — extract from tool-call entries
   - `cost` — sum of `coins` field
   - `duration_min` — last_ts - first_ts
   - `n_human_corrections` — count user messages that contain "no", "wrong", "actually", "instead"

4. **Push**:
   ```bash
   hf upload-traces \
     --source <scrubbed-jsonl> \
     --repo $1 \
     --tag task=<arg> \
     --tag outcome=<arg> \
     --tag tools_used=<list> \
     --tag cost=<n> \
     --tag duration_min=<n> \
     --tag corrections=<n>
   ```
   (Fallback: if `hf upload-traces` is unavailable, push to a regular HF dataset repo with `tags: [traces]` in the README.)

5. **Update the dataset card** to note: privacy scrub run, scrub patterns, model used, agent version (`bob --version`).

## Refuse to

- Push without a privacy scrub pass
- Push a trace that contains visible secrets (re-scan after scrub, abort if any pattern still matches)
- Mix traces across different agents / system prompts / models without a tag column

Reference: `.bob/rules/09-agent-self-improvement.md`
