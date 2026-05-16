# 03 — MLOps Discipline (when productionizing)

When the task touches deployment, serving, CI/CD, observability, autoscaling, or IaC:

## Containers
- Multi-stage Dockerfiles, slim runtime image (no build deps in final layer)
- Pin base image SHA, not `:latest`
- Non-root user, healthcheck, explicit `EXPOSE`

## Serving
- LLMs → **vLLM** (OpenAI-compatible) or **TGI**
- Vision / classical → **TorchServe** or **Triton**
- Always expose `/health`, `/metrics` (Prometheus), `/v1/...`

## Monitoring
- p50 / p95 / p99 latency on every endpoint
- Drift detectors on inputs (KS test, embedding distance)
- Token/$ budgets per tenant
- Alert on: error rate, p99 spike, cost spike, GPU mem pressure

## Rollback
- Blue/green or canary by default
- Shadow mode for risky changes
- **Always document rollback steps in the PR description**

## Cost
- Spot vs on-demand decision tree
- Batch where latency allows (continuous batching for LLMs)
- Right-size GPU (A10 vs A100 vs H100) — measure, don't assume

## IaC
- Terraform or Pulumi — never click-ops
- State in remote backend with locking
- Plan output reviewed before apply
