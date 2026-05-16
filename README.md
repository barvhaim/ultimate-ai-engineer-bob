# 🧠 Ultimate AI Engineer — Bob Shell Project Template

A **project template** that turns IBM Bob Shell into a senior AI/ML engineer with the **open-source AI engineering ecosystem** baked in. No installer, no copy steps — clone, `cd`, run `bob`.

> Inspired by Marwa Noyan's "Having an AI engineer at your fingertips" (Open Agent Ecosystem). Stack: Bob Shell + Hugging Face Hub + open models.

## Quick start

```bash
git clone https://github.com/njs2017/ultimate-ai-engineer-bob my-project
cd my-project
export BOBSHELL_API_KEY=<your-key>
export HF_TOKEN=<your-hf-token>          # for HF MCP, fine-tuning, traces

bob                                       # code mode — general implementation
bob --chat-mode plan          "design a DPO pipeline for GLM-4.6"

# Specialist personas (project-level custom modes):
bob --chat-mode ai-engineer       "build a multi-stage RAG over HF datasets"
bob --chat-mode ml-researcher     "best open coding model under 32B as of today?"
bob --chat-mode mlops-engineer    "containerize the vLLM server with autoscaling"
bob --chat-mode eval-engineer     "build a paired-bootstrap eval comparing checkpoints"
bob --chat-mode security-auditor  "audit src/ for prompt injection vectors"
```

That's it. Bob discovers `AGENTS.md`, `.bob/rules/`, `.bob/rules-{slug}/`, `.bob/custom_modes.yaml`, `.bob/commands/`, and `.bob/settings.json` automatically.

## What you get

### 11 always-on rules (`.bob/rules/`)
TDD · systematic debugging · verification before completion · AI engineer workflow · experiment tracking · eval rigor · cost discipline · **open-models-first** · **agent self-improvement loop** · HF workflows · local serving

### Modes — 4 native + 5 custom

**Native** (built into Bob, immutable): `plan` · `code` (default) · `ask` · `advanced`

**Custom** (defined in [`.bob/custom_modes.yaml`](./.bob/custom_modes.yaml), project-scoped):

| Slug | Role | Edit access | Rules dir |
|---|---|---|---|
| 🧠 `ai-engineer` | Training, serving, MLOps, evals end-to-end | full | `.bob/rules-ai-engineer/` |
| 🔬 `ml-researcher` | Lit review, model selection, arXiv | `*.md` only | `.bob/rules-ml-researcher/` |
| ⚙️ `mlops-engineer` | Containers, IaC, CI/CD, observability | infra files only | `.bob/rules-mlops-engineer/` |
| 📊 `eval-engineer` | Paired-bootstrap evals + report cards | evals/tests/notebooks | `.bob/rules-eval-engineer/` |
| 🔒 `security-auditor` | ML supply-chain + prompt-injection audit | **read-only** | `.bob/rules-security-auditor/` |

Edit permissions are enforced by Bob via `fileRegex` — the auditor cannot write code even if instructed to.

### 8 slash commands (`.bob/commands/`)
**Engineering:** `/research` · `/baseline` · `/eval` · `/ship` · `/audit`
**Open-models pipeline:** `/serve` (local vLLM/llama.cpp/MLX) · `/fine-tune` (HF skills SFT/DPO/GRPO) · `/trace` (push session to HF traces dataset)

### 10 MCP servers (`.bob/settings.json`)
**hf-mcp** (3M models, datasets, Spaces-as-tools, jobs) · Context7 · arXiv · Brave Search · Firecrawl · Filesystem · Git · GitHub · E2B (sandboxed code) · Semgrep

Project-scoped — Bob auto-loads them. Restrict per-session:

```bash
bob --allowed-mcp-server-names hf-mcp context7 arxiv --chat-mode ask "..."
```

## The self-improvement loop

The template wires up the loop Marwa demoed in her talk:

```
bob session  →  /trace  →  HF dataset (type=traces)  →  curate  →  /fine-tune  →  /serve  →  bob with new model
```

Each non-trivial session becomes potential training data. See [`.bob/rules/09-agent-self-improvement.md`](./.bob/rules/09-agent-self-improvement.md) for tagging, scrubbing, and DPO/SFT recipes.

## Open-models-first

Default model order: open source → open weights → closed APIs (only when no open option meets SLA, with the gap measured). See [`.bob/rules/08-open-models-first.md`](./.bob/rules/08-open-models-first.md).

Currently strong open picks (rotate as the leaderboard moves):
- **Coding agent**: GLM-4.6, Qwen3-Coder, DeepSeek-Coder
- **General**: Llama-3.3, Qwen3, Gemma-3
- **Vision-language**: Qwen3-VL, Gemma-3-VL, Llama-3.2-Vision

Always cross-check the **HF Hub benchmark dataset** for the deployed task before committing.

## Setup

### 1. Bob Shell
```bash
npm install -g bobshell
export BOBSHELL_API_KEY=<key>
```

### 2. HuggingFace (for `/fine-tune`, `/trace`, `/serve` from Hub)
```bash
pip install huggingface_hub
hf auth login                            # or: export HF_TOKEN=...

# Optional but recommended — install HF skills:
hf skills install hf-cli                 # repo / job management
hf skills install llm-trainer            # SFT / DPO / GRPO
hf skills install gradio                 # demo apps
hf skills install datasets               # dataset exploration
```

### 3. Optional MCP keys

```bash
export BRAVE_API_KEY=...                 # brave-search
export FIRECRAWL_API_KEY=...             # firecrawl
export GITHUB_PERSONAL_ACCESS_TOKEN=...  # github
export E2B_API_KEY=...                   # e2b sandbox
```

Servers without their key set fail gracefully — Bob skips them.

### 4. Local serving (optional — only if running models on this box)

```bash
pip install vllm                         # NVIDIA GPU
# or
brew install llama.cpp                   # CPU / GGUF / cross-platform
# or
pip install mlx-lm                       # Apple Silicon
```

## Layout

```
.
├── README.md
├── LICENSE                            # MIT
├── AGENTS.md                          # project context (Bob's entry point)
├── .bobrules                          # single-file fallback for minimal setups
├── .bob/
│   ├── settings.json                  # 10 MCP servers (project scope)
│   ├── rules/                         # 11 always-on rules
│   ├── rules-ai-engineer/             # 🧠 Senior AI engineer (full edit)
│   ├── rules-ml-researcher/           # 🔬 Researcher (md-only edit)
│   ├── rules-mlops-engineer/          # ⚙️  MLOps (infra-only edit)
│   ├── rules-eval-engineer/           # 📊 Evals (eval/test/notebook-only edit)
│   ├── rules-security-auditor/        # 🔒 Auditor (read-only)
│   ├── rules-code/                    # native code-mode rule (code standards)
│   ├── rules-plan/                    # native plan-mode rule (planning checklist)
│   ├── commands/                      # 8 slash commands
│   └── context/                       # @-imported by AGENTS.md
└── docs/
    └── ARCHITECTURE.md
```

## Customize for your project

1. Edit `AGENTS.md` — replace the `make` commands and project description
2. Edit `.bob/context/stack.md` — your actual frameworks, models, datasets
3. Edit `.bob/context/active-experiments.md` — what's currently running
4. Edit `.bob/context/known-pitfalls.md` — gotchas you've hit
5. Tune `.bob/settings.json` — remove MCP servers you don't need

## Inspiration

This template encodes patterns from:

- [Marwa Noyan — "Having an AI Engineer at your fingertips" (Open Agent Ecosystem)](https://youtu.be/OV56RddyFuU) — open-models-first, HF Hub as substrate, traces, self-improvement loop
- IBM Bob Shell native modes (`plan` / `code` / `ask` / `advanced`)
- The Hermes Agent ecosystem (mode-scoped rules, MCP-first tool access)

## License

MIT — see [LICENSE](LICENSE).
