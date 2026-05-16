---
description: Deep research on a topic — finds papers, builds comparison table
argument-hint: <topic>
---
Deep research on: $1

1. Switch to /mode ml-researcher
2. Use arxiv MCP to find 5 papers from the last 18 months
3. For each: title, arXiv ID, method summary (3 lines), key results, code availability, hardware used
4. Build a comparison table
5. Use Context7 MCP to confirm any library/API claims
6. Recommend an approach for our setup (cite stack from `.bob/context/stack.md`)
7. List 2 alternatives + when to pick each
8. Save the writeup to `docs/research/$1.md`
