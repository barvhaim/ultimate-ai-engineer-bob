# 🧠 Ultimate AI Engineer — Bob Shell Edition

A drop-in **Bob Shell** configuration that turns `bob` into a senior AI/ML engineer agent. Includes custom modes (subagents), auto-loaded rules (skills), slash commands, MCP server setup, and a wrapper for safe daily use.

> **Stack:** IBM Bob Shell (`bob`) · `.bob/rules/` · `~/.bob/custom_modes.yaml` · `.bob/commands/` · MCP servers · Bob extensions

## What you get

- 🧠 **5 custom modes** (subagents): `ai-engineer`, `ml-researcher`, `security-auditor`, `eval-engineer`, `mlops-engineer`
- 📜 **7 auto-loaded rules**: TDD, systematic debugging, verification before completion, AI engineer workflow, experiment tracking, eval rigor, cost discipline
- ⚡ **5 slash commands**: `/eval`, `/ship`, `/research`, `/baseline`, `/audit`
- 🔌 **12 MCP servers** preconfigured (Context7, arXiv, GitHub, HF, Semgrep, E2B…)
- 🛡️ **Safety wrapper** with audit log, auto-format on save, cost cap

## Quick install

```bash
git clone https://github.com/njs2017/ultimate-ai-engineer-bob ~/dev/uae-bob
cd ~/dev/uae-bob
./scripts/install.sh             # installs to ~/.bob and current project
export BOBSHELL_API_KEY=<key>
bob --chat-mode=ai-engineer "Design a DPO pipeline for llama-3.2-3b"
```

See [`docs/SETUP.md`](docs/SETUP.md) for the full guide.

## Layout

```
ultimate-ai-engineer-bob/
├── README.md
├── LICENSE
├── AGENTS.md                          # project context with @imports
├── .bobrules                          # single-file fallback
├── home/                              # → installed to ~/.bob/
│   ├── custom_modes.yaml              # 5 personas
│   └── audit.log                      # populated by wrapper
├── .bob/                              # → installed to <project>/.bob/
│   ├── rules/                         # always-loaded
│   │   ├── 01-tdd.md
│   │   ├── 02-systematic-debugging.md
│   │   ├── 03-verification-before-completion.md
│   │   ├── 04-ai-engineer-workflow.md
│   │   ├── 05-experiment-tracking.md
│   │   ├── 06-eval-rigor.md
│   │   └── 07-cost-discipline.md
│   ├── rules-code/                    # code-mode only
│   │   └── 01-code-standards.md
│   ├── rules-plan/                    # plan-mode only
│   │   └── 01-planning-checklist.md
│   ├── commands/                      # slash commands
│   │   ├── eval.md
│   │   ├── ship.md
│   │   ├── research.md
│   │   ├── baseline.md
│   │   └── audit.md
│   └── context/                       # imported by AGENTS.md
│       ├── global-conventions.md
│       ├── stack.md
│       ├── repo-layout.md
│       ├── active-experiments.md
│       └── known-pitfalls.md
├── scripts/
│   ├── install.sh                     # one-shot installer
│   ├── add-mcp-servers.sh             # bob mcp add ...
│   ├── bob-ai.sh                      # safe wrapper (source from .zshrc)
│   └── verify.sh                      # post-install sanity check
└── docs/
    ├── SETUP.md
    ├── ARCHITECTURE.md
    └── MIGRATION-FROM-CLAUDE-CODE.md
```

## License

MIT — see [LICENSE](LICENSE).
