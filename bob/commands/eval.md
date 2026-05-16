---
description: Run the full evaluation suite and report stat-sig vs baseline
argument-hint: <tasks-comma-separated>
---
Run the full evaluation suite. Tasks: $1 (default: mmlu,gsm8k,hellaswag,truthfulqa).

1. Switch to /mode eval-engineer
2. Run lm-eval-harness on the listed tasks
3. Pull the previous best run from W&B
4. Run paired bootstrap (n=1000) for stat-sig per benchmark
5. Write a report card to `docs/evals/$(date +%Y-%m-%d).md`
6. Post the W&B run URL
7. Flag any regressions with severity
