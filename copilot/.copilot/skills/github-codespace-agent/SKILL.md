---
name: github-codespace-agent
description: >-
  Work on the github/github repository in a GitHub Codespace using a Copilot
  CLI agent. Use for any implementation, debugging, review-fix, or validation
  task in github/github. Never create or use a local git worktree.
allowed-tools: Bash
---

# github/github Codespace Agent Workflow

Use this workflow for repository changes in `github/github`.

## Invariants

- Work in a GitHub Codespace, never in a local clone or worktree.
- Run a Copilot CLI agent inside the Codespace to investigate and implement changes.
- Keep the agent on the requested PR branch when one exists.
- Do not copy repository contents or credentials out of the Codespace.
- Use the smallest complete change and follow the repository's instructions.

## Workflow

1. Inspect the issue, PR, review, branch, and current checks with `gh`.
2. List existing Codespaces with `gh codespace list`.
3. Reuse a suitable stopped Codespace only when it already belongs to the same
   branch and task; otherwise create a fresh Codespace for `github/github` on
   the target branch.
4. Start the Codespace and verify its branch and clean working tree.
5. Run Copilot CLI non-interactively inside the Codespace:

   ```sh
   gh codespace ssh -c <codespace> -- \
     copilot -C /workspaces/github --allow-all-tools --allow-all-paths \
       --allow-all-urls --autopilot -p '<complete task prompt>'
   ```

   Include the PR and review context, requested behavior, constraints,
   validation expectations, and an instruction to commit and push the finished
   changes.
6. Inspect the resulting status, diff summary, commit, push state, and focused
   validation from outside the Codespace with `gh codespace ssh`.
7. If the agent is incomplete, resume its named session inside the same
   Codespace with a focused follow-up prompt rather than starting over.
8. Update the PR body or respond to review feedback when requested.
9. Stop the Codespace after the work is pushed and no further immediate
   iteration is needed.

## Safety

- Never use `/worktree`, `git worktree`, or a local checkout for `github/github`.
- Never print, persist, or transfer access tokens.
- Never force-push unless the user explicitly requests it.
- Do not bypass hooks or tests.
- Do not merge the PR unless explicitly requested.
