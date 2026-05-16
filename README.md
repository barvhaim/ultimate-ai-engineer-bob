# 🧠 Ultimate AI Engineer — Bob Shell Project Template

A **project template** that turns IBM Bob Shell into a senior AI/ML engineer. No installer, no copy steps — clone, `cd`, run `bob`.

> **Stack:** IBM Bob Shell (`bob`) + native chat modes + auto-loaded `.bob/rules/` + project-scoped MCP servers

## Quick start

```bash
git clone https://github.com/njs2017/ultimate-ai-engineer-bob my-project
cd my-project
export BOBSHELL_API_KEY=<your-key>
bob                                    # starts in code mode by default
bob --chat-mode plan "design a DPO pipeline for llama-3.2-3b"
bob --chat-mode ask  "what's SOTA for code embeddings as of 2025?"
bob --chat-mode advanced "audit src/ for prompt injection vectors"
```

That's it. Bob discovers `AGENTS.md`, `.bob/rules/`, `.bob/rules-{mode}/`, `.bob/commands/`, and `.bob/settings.json` automatically from the working directory.

## What you get

### 7 always-on rules (`.bob/rules/`)
TDD · systematic debugging · verification before completion · AI engineer workflow · experiment tracking · eval rigor · cost discipline

### Mode-scoped expertise

| Mode | Persona loaded | Rules dir |
|---|---|---|
| `code` (default) | Senior AI engineer + MLOps + eval engineer | `.bob/rules-code/` |
| `ask` | ML researcher (arXiv-citing, comparison tables) | `.bob/rules-ask/` |
| `advanced` | ML security auditor (Semgrep, prompt injection, supply chain) | `.bob/rules-advanced/` |
| `plan` | Planning checklist (bite-sized tasks, evidence-first) | `.bob/rules-plan/` |

### 5 slash commands (`.bob/commands/`)
`/research` · `/baseline` · `/eval` · `/ship` · `/audit`

### 11 MCP servers (`.bob/settings.json`)
Context7 · arXiv · Brave Search · Firecrawl · Filesystem · Git · GitHub · HuggingFace · E2B · Semgrep · Memory

Project-scoped — Bob loads them automatically when you launch from this directory. To restrict per-session:

```bash
bob --allowed-mcp-server-names context7 arxiv huggingface --chat-mode code "..."
```

## Setup

### 1. Bob Shell
```bash
npm install -g bobshell
export BOBSHELL_API_KEY=<key>          # required for non-interactive use
```

### 2. MCP API keys (optional — only for the servers you use)

```bash
export BRAVE_API_KEY=...               # brave-search
export FIRECRAWL_API_KEY=...           # firecrawl
export GITHUB_PERSONAL_ACCESS_TOKEN=...  # github
export HF_TOKEN=...                    # huggingface
export E2B_API_KEY=...                 # e2b
```

Servers without their key set will fail gracefully — Bob just skips them.

## Layout

```
.
├── README.md
├── LICENSE                            # MIT
├── AGENTS.md                          # project context (Bob's entry point)
├── .bobrules                          # single-file fallback for minimal setups
├── .bob/
│   ├── settings.json                  # MCP servers (project scope)
│   ├── rules/                         # always-on (7 files)
│   ├── rules-code/                    # code mode: AI eng + MLOps + eval
│   ├── rules-ask/                     # ask mode: ML researcher
│   ├── rules-advanced/                # advanced mode: security auditor
│   ├── rules-plan/                    # plan mode: planning checklist
│   ├── commands/                      # slash commands (5 files)
│   └── context/                       # @-imported by AGENTS.md (5 files)
└── docs/
    └── ARCHITECTURE.md
```

## Customize for your project

1. Edit `AGENTS.md` — replace the `make` commands and project description
2. Edit `.bob/context/stack.md` — your actual frameworks, models, datasets
3. Edit `.bob/context/active-experiments.md` — what's currently running
4. Edit `.bob/context/known-pitfalls.md` — gotchas you've hit
5. Tune `.bob/settings.json` — remove MCP servers you don't need

## License

MIT — see [LICENSE](LICENSE).
