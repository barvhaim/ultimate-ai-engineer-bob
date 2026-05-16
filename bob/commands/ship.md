---
description: Pre-deploy checklist — runs security audit then opens PR
argument-hint: <release-name>
---
Pre-deployment checklist for $1:

1. Confirm all tests pass: `make test`
2. Confirm linters clean: `make lint`
3. Confirm eval suite ≥ baseline (read latest report card)
4. Confirm model card present in HF Hub (or internal registry)
5. Switch to /mode security-auditor and run a full audit
6. Confirm rollback plan in the PR description
7. Confirm canary plan (1% → 5% → 25% → 100%)
8. Tag the Sentry release
9. Open the PR with all checks ticked

Halt and surface any failure — do not auto-merge.
