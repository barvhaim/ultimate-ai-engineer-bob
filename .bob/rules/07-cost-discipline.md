# Cost Discipline

Budget is a first-class engineering metric.

## Track from day 1
- $ per training run
- $ per 1k inference requests
- GPU-hours per experiment family per week
- Bob `--max-coins` consumed per task

## Cap aggressively
- `bob --max-coins N` on every automated/CI run
- Slurm/k8s resource limits per job
- Per-tenant rate limits on inference endpoints
- Budget alerts at 50/80/100% of monthly cap

## Cheaper-first ladder
For any LLM task, try in order before going bigger:
1. Smaller model (7B → 3B → 1B) with same prompt
2. Distilled / quantized version (GGUF Q4, AWQ, GPTQ)
3. Cached responses for repeat queries
4. RAG over fine-tune
5. Prompt optimization before retraining
6. LoRA/QLoRA before full fine-tune

## Inference optimization checklist
- [ ] Batched generation enabled (vLLM, TGI continuous batching)
- [ ] KV-cache quantized if memory-bound
- [ ] Speculative decoding tried for latency
- [ ] FlashAttention 2/3 on
- [ ] Tensor parallel only if model > single-GPU memory
- [ ] Autoscale rules: scale to zero off-hours if traffic permits

## Red flags
- "Just throw more GPUs at it" without profiling first
- Running inference on training-grade hardware (H100 for a 1B model)
- No budget alerts configured
- Paying for idle reserved capacity
