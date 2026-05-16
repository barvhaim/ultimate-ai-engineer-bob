# ML Stack Defaults

## Training
- PyTorch 2.5+ (`torch.compile=True` where stable)
- 🤗 Transformers + Accelerate
- TRL for RLHF/DPO/GRPO
- FSDP for >7B params; DDP for smaller
- Ray Train for multi-node when Accelerate hits limits

## Tracking
- W&B project per experiment family
- MLflow as fallback for air-gapped envs
- HF Hub for public artifacts; internal registry for private

## Datasets
- 🤗 datasets for tabular/text
- WebDataset for >1TB streaming
- Splits stored on HF Hub (private) or S3 with versioning

## Evaluation
- lm-eval-harness for standard LLM benchmarks
- Custom + statistical sig tests for domain-specific
- Paired bootstrap (n=1000)

## Serving
- vLLM (default for LLMs)
- TGI as alternative
- llama.cpp for edge / CPU
- TorchServe / Triton for non-LLM models

## Quantization
- GPTQ / AWQ for GPU inference
- GGUF for CPU / edge
- bitsandbytes 4/8-bit for QLoRA

## Structured output
- Outlines or instructor (regex / Pydantic schemas)
