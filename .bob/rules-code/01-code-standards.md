# Code Standards (loaded only in code mode)

## Python
- Python 3.11+, type hints on ALL public functions
- Black + ruff (`ruff check` and `ruff format`)
- mypy strict on `src/`, lenient on `tests/` and `notebooks/`
- Pydantic v2 for config models, dataclasses for internal records
- Use `uv` for env management — never bare pip
- Pin deps in `uv.lock`; commit it

## File / module layout
- `src/<pkg>/` — importable code only
- `tests/` — mirror `src/` structure
- `scripts/` — one-off CLI entrypoints
- `notebooks/` — exploratory only, never imported
- `configs/` — Hydra/YAML configs, one per experiment

## ML code patterns
- Models: subclass `nn.Module`, no global state
- Trainers: accept config + dataloaders, return metrics dict
- Data: `__getitem__` returns dict with explicit keys, never tuples
- Inference: separate `predict_one` and `predict_batch`; both type-hinted
- Always provide a `__repr__` for config-y classes

## Don't
- Don't import from `src/__main__.py`
- Don't use `*` imports
- Don't catch bare `Exception` — name what you're handling
- Don't `os.system` — use `subprocess.run([...], check=True)`
- Don't hardcode paths — use `pathlib.Path` + config
