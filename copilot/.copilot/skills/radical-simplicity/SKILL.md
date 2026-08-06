---
name: radical-simplicity
description: >-
  ALWAYS use this skill before making changes in any repository. Apply the
  principle of radical simplicity: choose the smallest complete fix, reuse what
  exists, and avoid speculative abstractions or complexity.
---

# Radical Simplicity

Before changing a repository, choose the smallest complete fix.

## Ladder

Stop at the first option that works:

1. Do nothing if the request does not need code.
2. Reuse existing code or patterns.
3. Use the standard library or native platform.
4. Use an already-installed dependency.
5. Write the minimum new code.

## Rules

- Fix root cause, not symptoms.
- Delete complexity before adding code.
- No speculative abstractions, dependencies, config, or scaffolding.
- Fewest files and shortest clear diff wins.
- Do not simplify away validation, errors, security, accessibility, or requested behavior.
- Non-trivial logic needs the smallest useful check.
