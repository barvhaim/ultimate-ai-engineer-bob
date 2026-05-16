---
description: Build a baseline model end-to-end (Phase 1 of AI engineer workflow)
---
Build the baseline:

1. Stand up a data loader on the smallest reasonable split
2. Train the dumbest reasonable model for 1 epoch (or fewer steps)
3. Wire eval harness — at minimum 1 benchmark with stderr
4. Wire serving (vLLM for LLMs, sklearn `predict` for classical)
5. Log everything to W&B (project + run name per `.bob/rules/05-experiment-tracking.md`)
6. Report final metrics + the W&B URL

This baseline is the reference for all future work. Do not delete it.
Do not optimize anything in this pass — just wire it end-to-end.
