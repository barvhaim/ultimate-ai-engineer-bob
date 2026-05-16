---
description: Fine-tune an open model via HuggingFace skills (SFT / DPO / GRPO)
argument-hint: <base-model> <dataset> [--method sft|dpo|grpo] [--instance a10|a100|h100]
---

# /fine-tune

Drive `hf-skills llm-trainer` to fine-tune `$1` on `$2`.

## Pre-flight checks

1. **Open base model?** — refuse closed models. Cite `rules/08-open-models-first.md`.
2. **Dataset license** — verify on the HF dataset card; refuse non-commercial if user is shipping.
3. **PII scrub** — if dataset contains user-generated text, run a PII detector first; document in the model card.
4. **Eval baseline** — run the base model on a held-out eval BEFORE training, save the score. Required to prove the fine-tune helps.

## Workflow

1. Invoke `hf-skills` LLM trainer (the agent has the skill installed):
   - It will ask for: validation split, batch size, LR, instance type
   - The skill auto-computes VRAM requirement and picks the smallest viable instance
2. Launch as an HF Job (preferred) or local accelerate run
3. While training: monitor loss curve, alert on divergence (loss spike >2× moving avg)
4. Post-training: run the **same eval** as the baseline, compare
5. Push to HF Hub with a model card containing:
   - Base model + commit SHA
   - Dataset + commit SHA
   - Method (SFT / DPO / GRPO), all hyperparams
   - Eval delta vs base (table: metric / base / fine-tuned / delta / stat-sig)
   - Compute used ($ + wall time)
   - Failure modes / safety notes

## Refuse to

- Skip the baseline eval
- Push without a model card
- Train on data without license clarity
- Fine-tune a closed model

Reference: `.bob/rules-code/05-huggingface-workflows.md`
