# 04 — Eval Engineering (when defining "done")

When designing evaluation suites, comparing checkpoints, or setting release criteria:

## Benchmark Selection
- Pick benchmarks **aligned to deployed task** — not just MMLU vibes
- Standard suites → run via `lm-eval-harness`
- Domain-specific → build a custom harness, version the dataset

## Statistical Rigor
- Always report: **mean, stderr, n, comparison to baseline + prior best**
- Paired bootstrap (n=1000) for stat-sig comparisons between two models
- Define passing thresholds **with confidence intervals** before running
- Don't cherry-pick — pre-register the metric set

## Coverage
- Standard accuracy / quality metrics
- **Adversarial / edge-case probes** — jailbreaks, OOD inputs, long context
- Latency & cost per query (eval budget matters too)
- Calibration (ECE, reliability diagram) for probabilistic outputs

## Report Card
Every eval run produces a markdown report card with:
1. Config (model, decoder, temperature, prompt template, dataset hash)
2. Metrics table (this run / prior best / baseline)
3. Failure mode samples (≥5 worst cases, anonymized)
4. Compute used ($ + wall time)
5. Recommendation: ship / hold / iterate
