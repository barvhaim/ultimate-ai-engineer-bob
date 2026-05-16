# 09 — Agent Self-Improvement Loop

Inspired by HF "traces" dataset type — the loop that turns agent sessions into training data.

## The loop

```
agent session  →  trace dump  →  HF dataset (type=traces)  →  curate  →  SFT/DPO  →  redeploy  →  repeat
```

Treat every coding session as **potential training data**. Don't throw away traces.

## When to push traces

After completing a non-trivial task (≥10 tool calls, or anything you'd want the agent to do better next time), push the session trace to a HuggingFace dataset of `type=traces`:

```bash
hf upload-traces \
  --source ~/.bob/sessions/<session-id>.jsonl \
  --repo <username>/agent-traces-<project> \
  --tag "task=<short-name>" "outcome=success|failure|partial"
```

(If `hf upload-traces` is not available, push a JSONL file with the session payload to a `dataset` repo and add `tags: [traces]` to the dataset card.)

## What to tag

Tag traces with structured metadata so future curation can filter:

- `task` — short task category (refactor, debug, eval, fine-tune, …)
- `outcome` — success / failure / partial / abandoned
- `tools_used` — which MCP servers / commands were invoked
- `human_corrections` — did the user have to redirect the agent? how often?
- `cost` — bob coins / API $
- `duration` — wall-clock minutes

## Curate before training

Don't fine-tune on raw traces. Filter:

1. **Outcome filter** — keep `success` and `partial`; drop `failure` unless training a critic
2. **Length filter** — drop sessions that ran out of context or were aborted
3. **Diversity filter** — avoid 1000 copies of the same Makefile-rerun trace
4. **Human-correction filter** — high-correction traces become DPO **rejected** samples; clean traces become **chosen**
5. **Privacy scrub** — strip secrets, PII, internal URLs (run `git-secrets` / `detect-secrets` on the trace text)

## Train signal preference

| Signal | Recipe | When |
|---|---|---|
| Behavior cloning | SFT on `success` traces | Bootstrapping a new task |
| Preference | DPO with chosen=clean / rejected=human-corrected | Refining a working agent |
| Reward model | Train classifier on `outcome` | Building a critic for online RL |
| Tool grounding | SFT on tool-call sub-sequences only | Fixing tool-misuse failure modes |

## Refuse to

- Train on traces without a **privacy scrub pass** documented in the dataset card
- Mix traces from different agents / models / system prompts in one training run without a column to disambiguate
- Skip the **eval before / after** comparison (need to prove the fine-tune actually helped on held-out tasks)
- Push traces with raw API keys, OAuth tokens, or `.env` content
