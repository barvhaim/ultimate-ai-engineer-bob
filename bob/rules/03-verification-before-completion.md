# Verification Before Completion

Before claiming "done", verify ALL of these:

## Code-level
- [ ] Linters pass (ruff, mypy, eslint, etc.)
- [ ] Tests pass — the new ones AND the existing ones
- [ ] Coverage didn't drop
- [ ] No new TODO/FIXME without a ticket
- [ ] No commented-out code
- [ ] No leftover debug prints / breakpoints

## ML-specific
- [ ] Training loss curve looks sane (smooth descent, no NaN spikes)
- [ ] Eval metrics meet or beat the previous best (with stat-sig test)
- [ ] Model card updated (data, hyperparams, metrics, intended use, limitations)
- [ ] W&B run linked in PR description
- [ ] Inference benchmark run (latency p50/p95/p99, throughput, GPU mem)
- [ ] Cost estimate per request

## Production-readiness
- [ ] Dockerfile builds + runs
- [ ] Healthcheck endpoint works
- [ ] Monitoring/alerts configured (or explicitly deferred with ticket)
- [ ] Rollback plan documented in PR
- [ ] Secrets via env/vault, never in code

## Refuse to claim "done" if
- Tests are skipped without a ticketed reason
- Eval was vibes-checked, not measured
- Deployment relies on manual steps not in a runbook
