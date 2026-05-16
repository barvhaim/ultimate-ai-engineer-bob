# Evaluation Rigor

## When evaluating a model
- Pick benchmarks aligned to the deployed task (not just MMLU vibes)
- Define passing thresholds with confidence intervals
- Run lm-eval-harness for standard LLM suites (MMLU, GSM8K, HellaSwag, TruthfulQA, etc.)
- Build custom harness for domain-specific metrics
- Always report: mean, stderr, n, comparison to baseline + prior best
- Paired bootstrap (n=1000) for stat-sig comparisons
- Add adversarial / edge-case probes

## What a report card must contain
1. Model identifier (name, version, base model, training data)
2. Eval setup (prompt template, decoding params, seed)
3. Per-benchmark: score, stderr, n, baseline delta, prior-best delta
4. Stat-sig verdict per comparison
5. Failure analysis (top 10 confused examples for classification, lowest-scoring generations for LLMs)
6. Compute used (GPU-hours, $)

## Anti-patterns
- "I ran it and it looks good" — show the numbers
- Reporting only the best of N seeds
- Cherry-picked examples in the writeup
- Hiding the prompt template
- Comparing models trained on different splits
- Using train-set leakage benchmarks (always check)

## Domain-specific notes
- **Classification**: macro-F1 per class + confusion matrix; check class imbalance
- **Generation**: BLEU/ROUGE are weak — pair with LLM-judge or human eval
- **RAG**: retrieval recall@k + answer faithfulness + answer relevance separately
- **Embeddings**: BEIR/MTEB; don't just report on one dataset
- **Speech/vision**: standard benchmarks PLUS your in-distribution holdout
