# Global AI Engineering Conventions

## Python
- Python 3.11+, type hints on all public functions
- Black + ruff + mypy strict
- Pydantic v2 for configs, dataclasses for internal records
- Use `uv` for env management (never bare pip)

## Reproducibility Checklist
- [ ] `seed_everything(42)` at entrypoint
- [ ] `uv.lock` committed
- [ ] Hydra/YAML config saved with each run as W&B artifact
- [ ] W&B run URL in commit message
- [ ] Model card on HF Hub (or internal registry) before declaring shipped
- [ ] Inference image tag pinned in deploy manifest

## Git hygiene
- One concept per commit
- Commits reference experiment IDs / W&B runs / tickets
- PRs include: goal, eval delta, rollback plan, monitoring change
- Never `--force` push to main; force-with-lease only on personal branches
