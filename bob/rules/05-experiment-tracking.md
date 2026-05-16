# Experiment Tracking

Every training run logs to W&B (or MLflow if W&B unavailable).

## Required fields per run
- **Project**: one project per experiment family
- **Run name**: `<branch>-<short-sha>-<descriptive-tag>` (e.g. `dpo-helpfulness-a3b9f2-lr2e5`)
- **Tags**: experiment family, dataset version, base model
- **Config**: full Hydra/YAML config saved as artifact
- **Code state**: git commit SHA + uncommitted diff as artifact
- **Hardware**: GPU type, count, memory
- **Seed**: explicit, logged

## Required logged metrics
- Train loss (every N steps)
- Val loss (every epoch or eval interval)
- Learning rate schedule
- Grad norm (for spotting instabilities)
- Throughput (tokens/sec, samples/sec)
- GPU memory peak
- Wall-clock per epoch
- Final eval scores per benchmark

## Artifacts to save
- Final checkpoint (or best-by-val)
- Tokenizer (if changed)
- Eval predictions (for error analysis)
- Sample generations (for LLMs)
- Config + diff

## Comparing runs
- Always compare against baseline AND prior best
- Use W&B reports for shareable summaries
- Don't trust single-seed comparisons for small effects — run 3 seeds
