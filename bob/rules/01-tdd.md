# Test-Driven Development

## Iron Law
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.

## Cycle
1. **RED** — write a failing test that captures the desired behavior
2. **GREEN** — write the minimum code that makes it pass
3. **REFACTOR** — clean up while keeping tests green

## For ML code specifically
- **Loss functions**: numerical tests with handcrafted inputs/expected outputs
- **Data loaders**: shape, dtype, range, no NaN, no leakage between splits
- **Training loops**: 1-step overfit on a tiny batch must drive loss to ~0
- **Inference**: golden examples with exact expected output (or expected metric range)
- **Eval pipelines**: integration test on a 10-row fixture before running on full data

## Red flags — STOP
- "I already manually tested it" → write the test
- "Tests after achieve the same purpose" → no, they don't
- "Too simple to test" → simple code still breaks
- "I'll add tests after the demo" → you won't

## Rationalization table
| Excuse | Reality |
|---|---|
| "It's just a script" | Scripts become pipelines. Test now. |
| "ML is non-deterministic" | Set seeds. Test on fixtures with deterministic seeds. |
| "Hard to mock the GPU" | Test the math on CPU with tiny tensors. |
| "Eval suite IS the test" | Eval is the slow integration test. You still need fast unit tests. |
