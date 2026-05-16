# Project: Ultimate AI Engineer (Bob Shell template)

@./.bob/context/global-conventions.md
@./.bob/context/stack.md
@./.bob/context/repo-layout.md
@./.bob/context/active-experiments.md
@./.bob/context/known-pitfalls.md

## What This Is

A **project template** for AI/ML work using IBM Bob Shell. Clone it, `cd` in, run `bob`. Bob auto-loads:

- `.bob/rules/` — always-on engineering discipline (TDD, debugging, verification, cost, eval rigor)
- `.bob/rules-{plan,code,ask,advanced}/` — mode-scoped expertise (see below)
- `.bob/commands/` — slash commands (`/eval`, `/ship`, `/research`, `/baseline`, `/audit`)
- `.bob/settings.json` — MCP servers (Context7, arXiv, GitHub, HF, Semgrep, E2B, …)

## Working with Bob's modes

Bob has 4 native chat modes — pick by intent:

| Mode | Command | When to use | Loads on top of `rules/` |
|---|---|---|---|
| **plan** | `bob --chat-mode plan` | Architecture, multi-file changes, design docs | `rules-plan/` planning checklist |
| **code** | `bob --chat-mode code` | Implementation, training, MLOps, evals | `rules-code/` AI engineer + MLOps + eval personas |
| **ask** | `bob --chat-mode ask` | Literature review, method selection, doc lookup | `rules-ask/` ML researcher persona |
| **advanced** | `bob --chat-mode advanced` | Security audit, deep refactor, cross-cutting review | `rules-advanced/` security auditor persona |

Default (no flag) = `code`.

## Slash commands

- `/research <topic>` — literature review with arXiv citations
- `/baseline <task>` — bootstrap a dumb baseline before optimizing
- `/eval <model>` — design + run an eval suite with stat-sig
- `/ship <feature>` — deployment checklist (rollback, monitoring, cost)
- `/audit <path>` — security review with Semgrep MCP

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
- Don't commit data files >50MB; use S3 + HF Hub
- Don't run training on the inference cluster
- Don't deploy without monitoring + rollback plan
- Don't `pip install` from untrusted sources without checksum
- Don't use `pickle.load` / `torch.load` on untrusted input
