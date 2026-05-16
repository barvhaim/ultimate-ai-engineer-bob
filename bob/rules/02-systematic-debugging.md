# Systematic Debugging

When a bug appears, walk these phases. Don't skip.

## Phase 1 — Understand
- Read the actual error message + full traceback
- Reproduce it deterministically (smallest case that fails)
- State the bug in one sentence: "X happens when Y, but Z is expected"

## Phase 2 — Hypothesize
- List 3+ hypotheses ranked by prior probability
- For each: what evidence would confirm/deny?

## Phase 3 — Bisect
- Git bisect for regressions
- Binary-search the data / config / code path otherwise
- Use logging/breakpoints, not print spam

## Phase 4 — Root cause
- "Why?" five times
- Distinguish proximate cause (NaN loss) from root cause (lr too high after warmup bug)
- Fix the root cause, not the symptom

## ML-specific
- NaN loss → check learning rate, gradient clipping, mixed-precision overflow, bad data row
- OOM → batch size, gradient accumulation, FSDP/DS config, leaked tensors (cuda.empty_cache)
- Slow training → profile (torch.profiler), check data loader workers, GPU util %, kernel fusion
- Eval regression → diff against last good run; check tokenizer, padding side, special tokens
- Distributed hang → check NCCL env vars, all-reduce shape mismatch, deadlock in DataLoader

## Anti-patterns
- "Just retry" without diagnosis
- Adding try/except to hide the error
- Bumping batch size to "see if it helps"
- Changing 5 things at once
