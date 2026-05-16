# 05 — HuggingFace Hub Workflows

When the task involves model search, dataset access, training, or deployment — HF Hub is the default substrate.

## When to reach for HF tools

| Task | Tool | Why |
|---|---|---|
| Find a model for capability X | HF MCP `search_models` + benchmark datasets | 3M+ models indexed, capability-filtered |
| Compare providers (cost / speed / tool-use) | Inference Providers UI | Routes to Groq, Cerebras, Novita, Together, etc. |
| Run model API once | `hf inference` or Inference Providers SDK | No infra, pay-per-call |
| Fine-tune a model | `hf-skills` LLM trainer | Auto napkin-math for VRAM, picks instance |
| One-off batch job (OCR 30K PDFs, eval sweep) | HF Jobs | S3-like buckets, mount support, agent-driven |
| Build a demo | `hf-skills` Gradio | One file → Space deployment |
| Explore a dataset | HF MCP `dataset_viewer` | API access to any public dataset |
| Push agent traces | dataset repo with `type=traces` | Turn sessions into training data |

## HF Skills (install per-machine, not per-repo)

```bash
hf skills install hf-cli           # repo / job management
hf skills install llm-trainer      # SFT / DPO / GRPO via HF infra
hf skills install gradio           # demo apps
hf skills install datasets         # dataset exploration
hf skills install ocr              # OCR model selection + benchmarks
hf skills install vision           # object detection / segmentation training
```

The agent should call these directly — do NOT reimplement training loops when `llm-trainer` exists.

## Inference Providers — provider selection

Before serving a model, check Inference Providers for routing tradeoffs:

- **Cheapest**: usually Together / Novita
- **Fastest tokens/sec**: Groq, Cerebras (LPU / wafer-scale)
- **Tool-use support**: filter the column — not every provider supports it
- **Tool-use + cheap**: Together (most open models), Fireworks

Always pick by **measured cost-per-task**, not advertised $/Mtok.

## Spaces as remote compute

Spaces are not just demos — they're **callable compute** via HF MCP:

- "Generate image of X" → calls a Qwen-Image / FLUX Space
- "Transcribe this audio" → calls a Whisper Space
- "Segment this image" → calls a SAM Space

Enable `dynamic spaces` in HF MCP settings to expose every public Space as a tool.

## Refuse to

- Reimplement a training loop when `hf-skills` LLM trainer covers the case
- Quote a model's "cost" without specifying which Inference Provider
- Deploy a closed-source model as the default when an open equivalent within 5% on the deployed benchmark exists (cite the benchmark + score gap)
- Push fine-tuned weights without a model card stating: base model, dataset, hyperparams, eval delta vs base
