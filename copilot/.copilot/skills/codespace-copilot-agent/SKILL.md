---
name: codespace-copilot-agent
description: >-
  Work on a repository in a GitHub Codespace using a Copilot CLI agent. Use
  when a task must stay in Codespaces or should be delegated to Copilot inside
  the remote development environment. Never create a local git worktree.
allowed-tools: Bash
---

# Codespace Copilot Agent Workflow

Use this workflow for repository changes that should be performed in a GitHub
Codespace.

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
   repository, branch, and task; otherwise create a fresh Codespace on the
   target branch.
4. Start the Codespace and verify its branch and clean working tree.
5. Run Copilot CLI non-interactively inside the Codespace:

   ```sh
   gh codespace ssh -c <codespace> -- \
     copilot -C /workspaces/<repository> --allow-all-tools \
       --autopilot -p '<complete task prompt>'
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

- Never use `/worktree`, `git worktree`, or a local checkout for the target repository.
- Never print, persist, or transfer access tokens.
- Never force-push unless the user explicitly requests it.
- Do not bypass hooks or tests.
- Do not merge the PR unless explicitly requested.
