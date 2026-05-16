---
description: Serve an open model locally (vLLM / llama.cpp / MLX) and point Bob at it
argument-hint: <hf-model-id> [--quant Q4_K_M] [--port 8000]
---

# /serve

Set up local serving for `$1` and reconfigure Bob to use it.

## Steps

1. **Detect platform**
   - If macOS / Apple Silicon → MLX path
   - If Linux + NVIDIA GPU + ≥24 GB VRAM → vLLM path
   - Else → llama.cpp + GGUF path

2. **Check VRAM / RAM**
   - Run `nvidia-smi` (Linux) or `system_profiler SPHardwareDataType` (macOS)
   - Compare to the model size — refuse to proceed if it won't fit, suggest a smaller quant

3. **Pull and serve**
   - vLLM: `vllm serve $1 --port ${port:-8000} --max-model-len 8192`
   - llama.cpp: `llama-server --hf-repo $1 --hf-file <picked-quant>.gguf --port ${port:-8080}`
   - MLX: `mlx_lm.server --model $1 --port ${port:-8000}`

4. **Smoke test**
   ```bash
   curl http://localhost:${port:-8000}/v1/chat/completions \
     -H "Content-Type: application/json" \
     -d '{"model":"'$1'","messages":[{"role":"user","content":"hi"}]}'
   ```

5. **Point Bob at it**
   ```bash
   export OPENAI_API_BASE=http://localhost:${port:-8000}/v1
   export OPENAI_API_KEY=dummy
   bob --model $1 --chat-mode code "..."
   ```

6. **Report**: model id, quant, VRAM used, tokens/sec from the smoke test, the exact `bob` command to use it.

Reference: `.bob/rules-code/06-local-serving.md`
