# Project: Ultimate AI Engineer (Bob Shell template)

@./.bob/context/global-conventions.md
@./.bob/context/stack.md
@./.bob/context/repo-layout.md
@./.bob/context/active-experiments.md
@./.bob/context/known-pitfalls.md

## What This Is

A **project template** for AI/ML work using IBM Bob Shell. Clone it, `cd` in, run `bob`. Bob auto-loads:

- `.bob/rules/` — always-on engineering discipline (TDD, debugging, verification, cost, eval rigor, HF workflows, local serving, **open-models-first**, **agent self-improvement**)
- `.bob/rules-{slug}/` — mode-scoped rules (auto-loaded when that mode is active)
- `.bob/custom_modes.yaml` — **5 specialist personas** as project-level custom modes (see below)
- `.bob/commands/` — slash commands (`/eval`, `/ship`, `/research`, `/baseline`, `/audit`, `/serve`, `/fine-tune`, `/trace`)
- `.bob/settings.json` — MCP servers (HF Hub, Context7, arXiv, GitHub, Semgrep, E2B, …)

## Working with modes

Bob ships **4 native modes** (plan / code / ask / advanced) — they cannot be modified, only used. This template adds **5 project-level custom modes** in `.bob/custom_modes.yaml`, each with its own role definition, tool permissions, and `fileRegex` edit restrictions.

### Native modes (always available)

| Mode | Command | When to use |
|---|---|---|
| **plan** | `bob --chat-mode plan` | Architecture, multi-file design before coding (loads `rules-plan/`) |
| **code** | `bob` *(default)* | General implementation (loads `rules-code/`) |
| **ask** | `bob --chat-mode ask` | Quick Q&A, doc lookup |
| **advanced** | `bob --chat-mode advanced` | Cross-cutting refactors, complex reasoning |

### Custom modes (this template's specialists)

| Slug | Role | Edit access | Tools |
|---|---|---|---|
| **ai-engineer** 🧠 | Senior AI/ML engineer — training, serving, MLOps, evals | full | read, edit, browser, command, mcp |
| **ml-researcher** 🔬 | Literature review + model selection with arXiv citations | `*.md` only | read, browser, mcp |
| **mlops-engineer** ⚙️ | Containers, IaC, CI/CD, observability | infra files only (Dockerfile, `*.tf`, `k8s/`, workflows…) | read, edit, command, mcp |
| **eval-engineer** 📊 | Statistically rigorous evals + report cards | evals/tests/notebooks only | read, edit, command, mcp |
| **security-auditor** 🔒 | ML supply-chain + prompt-injection audit | **none** (read-only) | read, browser, mcp |

```bash
bob --chat-mode ai-engineer       "design a DPO pipeline for $task"
bob --chat-mode ml-researcher     "compare GLM-4.6 vs Qwen3-Coder for code-completion"
bob --chat-mode mlops-engineer    "containerize the vLLM server with autoscaling"
bob --chat-mode eval-engineer     "build a paired-bootstrap eval comparing checkpoints"
bob --chat-mode security-auditor  "audit src/ before merge"
```

Each custom mode auto-loads `.bob/rules-{slug}/` on top of always-on `rules/`. Edit permissions are enforced by Bob via `fileRegex` — e.g. the auditor cannot write code even if asked.

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
