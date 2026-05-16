# Project: Ultimate AI Engineer (Bob Shell template)

@./.bob/context/global-conventions.md
@./.bob/context/stack.md
@./.bob/context/repo-layout.md
@./.bob/context/active-experiments.md
@./.bob/context/known-pitfalls.md

## What This Is

A **project template** for AI/ML work using IBM Bob Shell. Clone it, `cd` in, run `bob`. Bob auto-loads:

- `.bob/rules/` — always-on engineering discipline (TDD, debugging, verification, cost, eval rigor, **open-models-first**, **agent self-improvement**)
- `.bob/rules-{plan,code,ask,advanced}/` — mode-scoped expertise (see below)
- `.bob/commands/` — slash commands (`/eval`, `/ship`, `/research`, `/baseline`, `/audit`, `/serve`, `/fine-tune`, `/trace`)
- `.bob/settings.json` — MCP servers (HF Hub, Context7, arXiv, GitHub, Semgrep, E2B, …)

## Working with Bob's modes

Bob has 4 native chat modes — pick by intent:

| Mode | Command | When to use | Loads on top of `rules/` |
|---|---|---|---|
| **plan** | `bob --chat-mode plan` | Architecture, multi-file changes, design docs | `rules-plan/` planning checklist |
| **code** | `bob --chat-mode code` | Implementation, training, MLOps, evals | `rules-code/` AI engineer + MLOps + eval + HF workflows + local serving |
| **ask** | `bob --chat-mode ask` | Literature review, model selection, doc lookup | `rules-ask/` ML researcher + model selection protocol |
| **advanced** | `bob --chat-mode advanced` | Security audit, deep refactor, cross-cutting review | `rules-advanced/` security auditor |

Default (no flag) = `code`.

## Slash commands

**Engineering:**
- `/research <topic>` — literature review with arXiv citations
- `/baseline <task>` — bootstrap a dumb baseline before optimizing
- `/eval <model>` — design + run an eval suite with stat-sig
- `/ship <feature>` — deployment checklist (rollback, monitoring, cost)
- `/audit <path>` — security review with Semgrep MCP

**Open-models pipeline (HF-native):**
- `/serve <hf-model-id>` — local serving via vLLM / llama.cpp / MLX
- `/fine-tune <base> <dataset>` — SFT / DPO / GRPO via `hf-skills` LLM trainer
- `/trace <repo>` — push session trace to a HF `type=traces` dataset for later fine-tuning

## The self-improvement loop

```
bob session  →  /trace  →  HF dataset (type=traces)  →  curate  →  /fine-tune  →  /serve  →  bob with new model
```

Every non-trivial session is potential training data. See `.bob/rules/09-agent-self-improvement.md`.

## Project commands (fill in for your repo)

- `make train` — single-node training
- `make train-distributed` — accelerate launch
- `make eval` — full eval suite (lm-eval-harness + custom)
- `make serve` — vLLM serve on :8000
- `make benchmark` — load test
- `make lint` — ruff + mypy
- `make test` — pytest with coverage

## Don't

- Don't push to main — always PR
- Don't commit data files >50MB; use HF Hub or S3
- Don't run training on the inference cluster
- Don't deploy without monitoring + rollback plan
- Don't recommend a closed model without naming the open alternative + measured gap
- Don't push agent traces without a privacy scrub pass
- Don't `pip install` from untrusted sources without checksum
- Don't use `pickle.load` / `torch.load` on untrusted input
