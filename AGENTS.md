# Project: <name>

@./.bob/context/global-conventions.md
@./.bob/context/stack.md
@./.bob/context/repo-layout.md
@./.bob/context/active-experiments.md
@./.bob/context/known-pitfalls.md

## What This Is
One paragraph. Audience, purpose, current status.

## Commands
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
