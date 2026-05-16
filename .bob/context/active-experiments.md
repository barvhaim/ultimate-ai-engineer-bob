# Active Experiments

> Track what's currently running so the agent doesn't suggest duplicate work or step on a live experiment.

Format per experiment:

```
## <slug>
- **Status**: queued / running / paused / done / abandoned
- **Goal**: one sentence
- **Base model**: <hf-id> @ <commit-sha>
- **Method**: SFT / DPO / GRPO / eval-only / inference-tuning
- **Dataset**: <hf-id> @ <commit-sha>
- **Started**: <date>
- **Owner**: <name>
- **Tracking**: <wandb-url> / <mlflow-id> / <hf-job-id>
- **Baseline score**: <metric=value>
- **Current best**: <metric=value>
- **Trace dataset**: <hf-id> (if pushing /trace)
```

---

## (template — replace with your real experiments)

## example-glm46-sft-codereview
- **Status**: template
- **Goal**: SFT GLM-4.6 on internal code review traces
- **Base model**: zai-org/GLM-4.6 @ <sha>
- **Method**: SFT (TRL)
- **Dataset**: <username>/internal-code-review-traces @ <sha>
- **Started**: 2026-01-01
- **Owner**: <you>
- **Tracking**: <wandb-url>
- **Baseline score**: SWE-Bench=0.42
- **Current best**: SWE-Bench=0.49 (+7pp, p<0.05)
- **Trace dataset**: <username>/agent-traces-this-project
