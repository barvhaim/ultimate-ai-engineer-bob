# 02 — Model Selection (research mode)

When the user asks "which model should I use", "what's SOTA for X", or "compare these models" — follow this protocol.

## Step 1 — Identify the deployed task

Don't pick on MMLU vibes. Ask:
- What's the **input** (text / image / audio / multimodal)?
- What's the **output** (free text / structured / tool calls / code patches)?
- What's the **latency budget** (p95 ms)?
- What's the **cost budget** ($/Mtok or $/req)?
- Is **fine-tuning** an option, or zero-shot only?
- **Open or closed** acceptable? (See `rules/08-open-models-first.md` — default open.)

## Step 2 — Find the right benchmark

Map the task to a HF Hub benchmark dataset:

| Task | Benchmarks |
|---|---|
| Coding (PR / patch quality) | SWE-Bench, SWE-Bench Pro, HumanEval (saturated) |
| Coding (snippet) | LiveCodeBench, BigCodeBench |
| Math reasoning | AIME, MATH, GSM8K (saturated) |
| Long-context | RULER, NIAH, LongBench |
| Multimodal | MMMU, MathVista, AI2D |
| Tool use / agents | TauBench, BFCL, AgentBench |
| Hallucination / faithfulness | TruthfulQA, FaithBench |
| Frontier general | Humanity's Last Exam |

Always cite the **leaderboard URL + leaderboard date** — scores rot.

## Step 3 — Build the comparison table

Required columns:

| Model | Open? | Score | Eval date | $/Mtok in/out | p95 latency | Tool-use? | Context | License | arXiv |

Rules:
- **All rows on the same eval config** (same harness version, same prompt template, same temperature)
- Mark **reproducibility risk** in a final column: ✅ open weights+code+data / ⚠️ weights only / ❌ closed
- If you only have one source benchmark, say so — don't fake breadth

## Step 4 — Make the recommendation

End with three blocks:

**Recommended:** `<model>` because <one sentence with the deciding metric>.

**Alternatives:**
- `<model-2>` — pick this if `<condition>` (e.g., "you have <16GB VRAM")
- `<model-3>` — pick this if `<condition>` (e.g., "tool-use accuracy matters more than raw quality")

**What we don't know:**
- Open question 1 (e.g., "no public eval on Hebrew tool-calling")
- Open question 2

## Step 5 — Cross-check with Inference Providers

If the recommendation is API-served, check HF Inference Providers for the cheapest / fastest provider that supports tool-use. Don't assume the model card's pricing is the live price.

## Refuse to

- Say "X is SOTA" without an arXiv / leaderboard link + date
- Compare scores from different harness versions
- Skip the "what we don't know" block — every model selection has uncertainty
