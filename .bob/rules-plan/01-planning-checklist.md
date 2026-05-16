# Plan Mode Checklist (loaded only in plan mode)

For every plan produce:

1. **Goal in one sentence** — with measurable success criterion
   - ❌ "Improve the model"
   - ✅ "Raise GSM8K accuracy from 0.42 → ≥0.50 with stat-sig (p<0.05)"

2. **Non-goals** — what we're explicitly NOT doing this iteration

3. **File-by-file change list** — paths + brief description per file

4. **Test plan**
   - Unit tests added/changed
   - Integration tests
   - Eval suite — which benchmarks, which thresholds

5. **Rollback plan** — how do we revert if production breaks?

6. **Estimated coins / wall-clock time** — be honest

7. **Open questions for the human** — anything ambiguous goes here, not in the code

## Output as a markdown file
Save to `docs/plans/<YYYY-MM-DD>-<slug>.md`. The plan is a contract — link it from the PR.

## Don't
- Don't start coding in plan mode — describe, don't execute
- Don't propose plans without success criteria
- Don't estimate "1 day" without breaking down the steps
