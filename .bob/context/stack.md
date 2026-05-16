# Stack

> Default to **open** at every layer. Closed APIs only when measured open alternative misses SLA.

## Models (rotate as leaderboards move)

- **Coding agent**: GLM-4.6, Qwen3-Coder, DeepSeek-V3
- **General LLM**: Llama-3.3, Qwen3, Gemma-3
- **Vision-language**: Qwen3-VL, Gemma-3-VL, Llama-3.2-Vision
- **Embeddings**: BAAI/bge-m3, Qwen3-Embedding, jina-embeddings-v3
- **Rerankers**: BAAI/bge-reranker-v2-m3, Qwen3-Reranker
- **Speech**: Whisper-v3, Distil-Whisper, Parakeet
- **Image gen**: Qwen-Image, FLUX.1-schnell, SDXL-Turbo

Always verify on HF Hub benchmark datasets for the deployed task before committing.

## Frameworks

- **Training**: TRL (SFT/DPO/GRPO), Axolotl, accelerate, DeepSpeed
- **Serving**: vLLM (Linux/GPU), llama.cpp (CPU/GGUF), MLX-LM (Apple Silicon)
- **Evals**: lm-evaluation-harness, custom harnesses with paired bootstrap
- **Experiment tracking**: Weights & Biases, MLflow
- **Vector DB**: Qdrant, LanceDB, pgvector (only if needed — start without)

## Hosting

- **Hub**: Hugging Face (models, datasets, Spaces, **traces**)
- **Inference Providers**: HF routing → Together / Groq / Cerebras / Novita / Fireworks
- **Compute jobs**: HF Jobs (one-off batch) for fine-tuning, OCR sweeps, eval matrices
- **Buckets**: HF buckets (S3-compatible, mountable, cheaper) for trace storage

## Stack philosophy

- Reproducibility wins ties — pinned commit SHAs everywhere
- Cost & latency are first-class metrics, tracked from day 1
- Privacy by default — edge / browser deploy whenever possible
- Every shipped model has a **model card** + **eval delta vs base**
