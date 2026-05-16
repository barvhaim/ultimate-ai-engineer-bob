# AI Engineer Workflow

## Phase 0 — Problem Statement (BEFORE any code)
Answer all 5. If you can't, STOP and ask the human:
1. **User-facing metric?** (accuracy, latency, cost, satisfaction, retention)
2. **Baseline?** (random, heuristic, last shipped model, off-the-shelf API)
3. **Budget?** ($/request, p99 latency, GPU hours, calendar weeks)
4. **Data?** (license, volume, label quality, drift, PII)
5. **What can go catastrophically wrong?** (bias, hallucination, leakage, abuse)

## Phase 1 — Baseline (Day 1-2)
- Dumbest thing that could work (rule, sklearn, off-the-shelf API)
- Wire end-to-end: data → train → eval → serve
- Log to W&B from minute one
- This is your reference. Never delete it.

## Phase 2 — Iterate
- One change per experiment. Tag in W&B.
- Compare to baseline + previous best with confidence intervals
- Statistical significance (paired bootstrap, n=1000), not vibes
- Kill experiments that don't move the metric within budget

## Phase 3 — Productionize
- Eval suite passes
- Model card pushed to HF Hub (or internal registry)
- Inference benchmarked (latency, throughput, cost per req)
- Monitoring: latency, error rate, drift, cost
- Rollback plan documented
- Shadow mode → canary (1% / 5% / 25%) → full rollout

## Red Flags
- "Works on my machine" → containerize
- "Accuracy went up" without confidence intervals → not real
- "Demo looks good, skip eval" → STOP
- "Just deploy it" without monitoring → STOP
- "We'll add tests later" → you won't
