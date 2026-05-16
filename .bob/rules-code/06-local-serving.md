# 06 — Local Serving Patterns

When the task requires running a model on this machine (or a single GPU box), use this decision tree.

## Decision tree

```
Need to serve a model locally?
├── LLM, GPU available, max throughput
│   └── vLLM (OpenAI-compatible API on :8000)
├── LLM, Mac (Apple Silicon)
│   └── MLX-LM / LM Studio
├── LLM, CPU-only or mixed GPU/CPU, GGUF quantization
│   └── llama.cpp (`llama-server`) or Ollama
├── LLM, agentic with tools, single binary
│   └── llama-agent (built into llama.cpp)
├── VLM (multimodal)
│   └── vLLM (qwen-vl, gemma-vl), MLX-VLM, llama.cpp w/ vision
└── Need a coding agent UI
    └── Jan / OpenWebUI in front of any of the above
```

## Quick recipes

### vLLM (production-grade local LLM serving)
```bash
pip install vllm
vllm serve <hf-model-id> --max-model-len 8192 --port 8000
# OpenAI-compatible:
curl http://localhost:8000/v1/chat/completions -d '{"model":"<id>","messages":[...]}'
```

### llama.cpp (GGUF, CPU/GPU, lightest)
```bash
llama-server --hf-repo <user/repo-GGUF> --hf-file <model.Q4_K_M.gguf> --port 8080
# Or as agent:
llama-agent --hf-repo <user/repo-GGUF> --hf-file <file>
```

### MLX (Apple Silicon, fastest on M-series)
```bash
pip install mlx-lm
mlx_lm.server --model <hf-mlx-id> --port 8000
```

## Picking a quantization

Use HF Hub model card → GGUF section → **Hardware compatibility** column. Rules of thumb:

| VRAM | Best quant for ~70B | Best quant for ~30B | Best quant for ~7B |
|---|---|---|---|
| 8 GB | (won't fit) | Q3_K_S (degraded) | Q5_K_M |
| 16 GB | Q2_K (degraded) | Q4_K_M | Q8_0 / fp16 |
| 24 GB (L4 / 3090) | Q3_K_M | Q5_K_M / Q6_K | fp16 |
| 48 GB (A6000) | Q4_K_M | Q8_0 / fp16 | fp16 |
| 80 GB (A100/H100) | Q5_K_M / Q6_K | fp16 | fp16 |

Always **measure perplexity vs the unquantized model on a held-out set** before declaring a quant "good enough".

## Pointing Bob at a local model

Bob speaks OpenAI-compatible APIs. To use your local server:

```bash
export OPENAI_API_BASE=http://localhost:8000/v1
export OPENAI_API_KEY=dummy        # required string, content doesn't matter
bob --model <local-model-id> --chat-mode code "..."
```

## Refuse to

- Recommend a quantization without naming the perplexity / benchmark delta vs unquantized
- Run inference on a model that doesn't fit in VRAM (will silently swap → 100× slower; fail loudly instead)
- Skip `nvidia-smi` / `mlx_metrics` / `htop` baseline before claiming "it's slow"
- Use `transformers.AutoModel.from_pretrained` for production inference — that's a dev/test path, not a serving path
