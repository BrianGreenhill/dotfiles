---
name: git-worktree
description: >-
  ALWAYS use this skill before editing any files in a git repository. Create a
  git worktree so your changes are isolated from the user's working directory.
  This skill applies to ANY task that will create, edit, or delete files in a
  git repo — not just branch switching. Invoke this skill as your very first
  step whenever you are about to modify files.
---

# Git Worktree — Always Isolate Your Work

## The rule

**Before editing ANY file in a git repository, create a worktree and work
there.** The user's checkout is their workspace — you must not touch it. Other
agents may also be operating on the same repo concurrently.

This applies to every task: bug fixes, new features, config changes, docs
updates, experiment setup — anything that modifies files.

## Workflow

### Step 1: Create a worktree

**Always fetch the latest default branch first**, then create the worktree:

```bash
# Fetch latest main/master before branching
git fetch origin main  # or master — use whichever the repo uses

# New branch (most common — you're making changes)
git worktree add -b my-branch-name ../repo-my-branch-name origin/main

# Existing remote branch
git fetch origin branch-name
git worktree add ../repo-branch-name branch-name
```

> **Important:** Use `origin/main` (not `main`) as the start point to ensure
> you branch from the latest remote state, not a stale local ref.

**Worktree path convention:** sibling directory named `<repo>-<branch-slug>`.
Take the branch name, replace `/` with `-`, drop verbose prefixes.

Example: repo at `/Users/me/work/my-repo`, branch `fix/http-methods`
→ worktree at `/Users/me/work/my-repo-fix-http-methods`

### Step 2: cd into the worktree

```bash
cd ../repo-my-branch-name
```

**All subsequent work happens here.** Every file edit, build, test, and commit
must happen inside the worktree directory. Do not use absolute paths to edit
files in the worktree from the original checkout.

### Step 3: Do your work

Edit files, build, test, commit, push — everything works normally:

```bash
# edit files...
make build && make test
git add -A && git commit -m "fix: my change"
git push origin my-branch-name
```

### Step 4: Return and clean up

When the task is complete:

```bash
cd /original/repo/path
git worktree remove ../repo-my-branch-name
```

Tell the user which branch has their changes and where to find it.

## Rules

1. **Create a worktree FIRST**, before any file edits. This is not optional.
2. **cd into the worktree** before doing any work.
3. **Never `git checkout` or `git switch`** in the user's working directory.
4. **Place worktrees as siblings** (e.g., `../repo-branch`), never inside
   the repo.
5. **Clean up** when done. Remove the worktree after pushing.
6. **Tell the user** the worktree path and branch name.

## Exceptions — when you do NOT need a worktree

- **Read-only tasks**: answering questions, searching code, viewing files,
  running queries. If you won't create/edit/delete any files, skip this.
- **The user explicitly tells you** to work in their current checkout.

## Gotchas

- A branch can only be checked out in **one worktree at a time.** Use
  `git worktree list` to check. If it's already checked out, cd to that
  worktree instead of creating a new one.
- Worktrees share the `.git` object store — `git fetch` and reflog are shared.
- If `git worktree add` fails because the branch exists locally, use
  `git worktree add ../path branch-name` (no `-b`).
