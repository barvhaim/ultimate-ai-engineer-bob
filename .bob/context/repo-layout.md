# Repo Layout

```
.
├── AGENTS.md                  # this context (read by Bob)
├── .bob/                      # Bob configuration
├── src/<pkg>/                 # importable code
│   ├── data/
│   ├── models/
│   ├── training/
│   ├── eval/
│   └── serving/
├── tests/                     # mirrors src/
├── scripts/                   # one-off CLIs
├── notebooks/                 # exploratory only
├── configs/                   # Hydra/YAML
│   ├── data/
│   ├── model/
│   ├── train/
│   └── eval/
├── docs/
│   ├── plans/
│   ├── research/
│   ├── evals/
│   └── security/
├── deploy/                    # Dockerfiles, k8s, terraform
├── Makefile
├── pyproject.toml
└── uv.lock
```

## Conventions
- One config per experiment in `configs/train/`
- One eval suite per benchmark family in `configs/eval/`
- Plans, research, evals, security audits live as markdown in `docs/`
- Build/test/serve commands always go through `make` (entry points documented in AGENTS.md)
