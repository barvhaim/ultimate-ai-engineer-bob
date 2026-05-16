# 08 — Open Models First

Inspired by Marwa Noyan (HF) — "Having an AI Engineer at your fingertips" (Open Agent Ecosystem).

## Default to open weights

When recommending or selecting a model, the default order is:

1. **Open source** (Apache-2.0 / MIT / open code + weights + harness) — GLM-4.6, Qwen3, Gemma, Llama, DeepSeek, Mistral
2. **Open weights** (non-commercial OK for research / internal use)
3. **Closed APIs** — only when no open option meets the SLA, or for explicit comparison

## Why this matters (state explicitly when recommending)

- **Reproducibility** — closed-model performance silently degrades (recent Claude regression). Open weights = bit-identical inference forever.
- **Privacy** — edge / browser deployment with zero data exfiltration
- **Compression** — quantize, distill, prune to fit your budget
- **Fine-tuning** — full control of the loss function and data mix
- **No vendor lock-in** — swap providers without rewriting

## Picking an open model

When asked "which model should I use for X":

1. Go to **HF Hub benchmark datasets** for the relevant capability:
   - Coding → SWE-Bench, SWE-Bench Pro
   - Math → AIME, MATH
   - General → Humanity's Last Exam, MMLU-Pro
   - Multimodal → MMMU, MathVista
2. Filter for **open** entries; rank by score on the deployed task (not vibes)
3. Cross-check **Inference Providers** for routing options (cheapest / fastest / tool-use support)
4. Verify **GGUF / MLX availability** if local-first

## Vision-language by default

Treat new flagship models as **VLMs day-zero** (Qwen3-VL, Gemma3-VL, etc.). Don't pick a text-only model when you might need image / screenshot understanding within 6 months.

## Refuse to

- Recommend a closed model without naming the open alternative + the gap in measured terms
- Quote benchmark scores without linking the leaderboard or the eval config
- Compare an open model on an old eval harness vs. a closed model on a new one — same harness, same date
