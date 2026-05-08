---
name: git-branch-management
description: Use when creating, switching, renaming, syncing, publishing, tracking, comparing, or deleting git branches; choosing branch names; setting upstreams; inspecting branch state; cleaning merged branches; or resolving branch workflow questions before commit, push, pull, merge, rebase, or PR work.
---

# Skill: git-branch-management

## Purpose

Manage git branches safely and predictably.

Use this skill to choose the right branch operation, avoid losing user work, and keep local and remote branch state understandable.

## Default Strategy

Prefer a simplified GitHub Flow unless the repository already documents another workflow:

- Keep the default branch as the source of truth.
- Create one short-lived branch per coherent change.
- Merge branches back to the default branch through the repo's normal review path.
- Delete merged task branches after the work lands.
- Keep branches small enough to review, rebase, revert, or abandon cleanly.

For CI/CD-heavy projects, lean toward trunk-based habits: integrate often, avoid long-lived divergence, and keep release state in tags or deployment automation when the repo already supports that.

Do not introduce Gitflow-style `develop`, `release/*`, or `hotfix/*` branches unless the repo already uses them or the user has real release constraints such as scheduled releases, multiple maintained versions, compliance gates, or customer-specific hotfix lines.

## First Checks

Before branch changes, inspect state:

```bash
git status -sb
git branch --show-current
git branch -vv
git remote -v
```

For remote-aware operations, run:

```bash
git fetch --prune
```

Read the output before acting. If the working tree has uncommitted changes, do not switch, rebase, delete, or reset unless the operation is safe for those changes or the user explicitly approves the handling.

## Branch Naming

Follow repository conventions when they exist. If none are visible, prefer short task branches:

- `feature/<short-slug>` for user-facing features.
- `fix/<short-slug>` for bug fixes.
- `docs/<short-slug>` for documentation-only work.
- `test/<short-slug>` for test-only work.
- `refactor/<short-slug>` for behavior-preserving code restructuring.
- `chore/<short-slug>` for maintenance.
- `spike/<short-slug>` for short-lived experiments that should not be merged as-is.

Assistant-created branches should use the same prefixes based on change type; do not create a separate assistant-specific prefix.

Use lowercase letters, digits, hyphens, and one slash after the prefix. Keep the full branch name under 60 characters when practical, and keep the slug to 2-5 specific words.

Do not use spaces, underscores, dots, emoji, non-ASCII characters, or repeated hyphens. Do not repeat the prefix in the slug, such as `fix/fix-login-error`.

Use ticket numbers only when the repo or user provides them, and keep placement consistent with existing branches.

Avoid broad names like `update`, `changes`, `fix`, `wip`, or `branch`. Avoid reserved or workflow names such as `main`, `master`, `develop`, `release`, `hotfix`, `HEAD`, `origin`, `release/*`, and `hotfix/*` unless they match the repo's established strategy.

Choose the prefix by intent:

- `feature/` must add user-facing or API-facing capability.
- `fix/` must correct faulty behavior.
- `docs/` must stay documentation-only.
- `test/` must stay test-only.
- `refactor/` must preserve behavior.
- `chore/` must not add user-visible functionality.
- `spike/` is temporary; rename or recreate a proper branch before merge.

## Common Operations

Create from the current branch:

```bash
git switch -c <branch>
```

Create from the updated default branch:

```bash
git fetch --prune
default_branch="$(git symbolic-ref refs/remotes/origin/HEAD --short | sed 's#^origin/##')"
git switch "$default_branch"
git pull --ff-only
git switch -c <branch>
```

If `origin/HEAD` is not configured, inspect remote branches and repo docs before assuming `main`:

```bash
git branch -r
```

Switch branches:

```bash
git switch <branch>
```

Publish and set upstream:

```bash
git push -u origin <branch>
```

Set upstream for an existing local branch:

```bash
git branch --set-upstream-to=origin/<branch> <branch>
```

Rename the current branch:

```bash
git branch -m <new-name>
```

Compare with upstream:

```bash
git status -sb
git log --oneline --decorate --left-right --graph @{u}...HEAD
```

## Cleanup

Before deleting, verify whether the branch is merged and whether it exists remotely:

```bash
git branch --merged
git branch -vv
git branch -r
```

Delete a merged local branch:

```bash
git branch -d <branch>
```

Delete an unmerged local branch only with explicit user approval:

```bash
git branch -D <branch>
```

Delete a remote branch only with explicit user approval:

```bash
git push origin --delete <branch>
```

Clean stale remote-tracking refs:

```bash
git fetch --prune
```

After a PR or merge lands, prefer this cleanup flow:

```bash
git fetch --prune
git switch <default-branch>
git pull --ff-only
git branch -d <merged-branch>
```

## Dirty Worktree Handling

If uncommitted changes block the requested branch operation, present the safest options:

- commit the changes first
- keep working on the current branch
- create a new branch from the current state
- stash only when the user approves and the stash message is specific

Do not silently stash, discard, reset, or checkout over user changes.

## Rebase, Merge, And Force Push

Use the least surprising history operation:

- Prefer `git pull --ff-only` when updating a branch from its upstream.
- Ask before rebasing a shared branch.
- Ask before merging another branch into the current branch unless the user explicitly requested it.
- Never force push by default.
- If force push is explicitly needed, prefer `git push --force-with-lease` and explain the risk first.

## Output Style

When acting, report:

- selected branch strategy when it matters
- current branch before and after
- whether the worktree was clean or dirty
- remote/upstream relationship when relevant
- exact branch command used
- remaining risk or follow-up, if any

When the user asks for a plan, give the shortest safe command sequence.

## Hard Rules

- Do not use `git reset --hard`, `git checkout --`, `git clean`, `git branch -D`, or remote branch deletion unless the user explicitly requests or approves it.
- Do not delete the current branch; switch away first.
- Do not assume `main`; detect the default branch when it matters.
- Do not create broad branch names like `fix`, `update`, or `changes`.
- Do not hide a dirty working tree behind branch operations.
