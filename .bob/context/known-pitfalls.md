# Known Pitfalls

(Project-specific gotchas. Add to this file whenever you waste >30 minutes on something.)

## Examples to follow

### Tokenizer left-padding for generation
Generation needs left padding; training needs right padding. If you reuse the same tokenizer instance, set padding side per-call.

### `torch.load` and pickle
Always pass `weights_only=True` when loading weights from external sources. Set `safetensors` as the default save format.

### HF Hub revision pinning
Never load a model from `main` in production. Pin a specific revision SHA in config.

### W&B run resumption
`wandb.init(id=..., resume="must")` — without `resume="must"`, a network blip starts a new run and you lose the comparison.
