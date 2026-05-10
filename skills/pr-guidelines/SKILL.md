---
name: pr-guidelines
description: Use when drafting, opening, updating, reviewing, or preparing pull requests; writing PR titles, descriptions, summaries, validation notes, risk sections, screenshots notes, issue links, review responses, or deciding whether a PR should be draft, ready, split, blocked, or merged.
---

# Skill: pr-guidelines

## Purpose

Make pull requests small, reviewable, honest, and easy to merge.

Use this skill to turn a change set into a clear PR title/body, check PR readiness, or respond to review feedback without hiding risk or scope.

## First Checks

Before drafting or reviewing a PR, inspect what actually changed when available:

```bash
git status -sb
git diff --stat
git diff
git log --oneline --decorate --max-count=10
```

If changes are staged or committed, prefer the relevant staged or branch diff:

```bash
git diff --cached --stat
git diff --cached
git log --oneline --decorate @{u}..HEAD
git diff --stat @{u}...HEAD
```

Do not write a confident PR summary from memory when the diff is available.

## PR Scope

A good PR has one coherent purpose.

Prefer splitting when the PR contains:

- unrelated behavior changes
- refactors mixed with feature work
- formatting churn mixed with logic
- generated files mixed with manual edits without explanation
- multiple independent fixes
- broad dependency updates plus product changes

Keep a larger PR only when the pieces cannot be reviewed or verified independently, and explain why.

## Title

Use a concise Conventional Commit style title by default:

```text
feat(scope): add concise capability
fix(scope): correct faulty behavior
docs(scope): clarify usage
refactor(scope): simplify module boundary
```

Rules:

- Use `git-commit-message` when choosing the title.
- Prefer the PR title to match the primary change, not every detail.
- Keep it short and scannable, ideally under 72 characters.
- Do not end with a period.
- Do not invent issue IDs, ticket IDs, scopes, or breaking changes.
- Preserve an exact user-provided PR title unless it conflicts with repo rules.

## Body

Use only sections that add signal. Prefer this shape:

```markdown
## Summary
-

## Why
-

## Validation
-

## Risk
-
```

Add optional sections when useful:

```markdown
## Screenshots
## Migration
## Rollback
## Related Issues
```

Write the body for reviewers:

- explain what changed
- explain why it changed
- call out user-visible behavior changes
- call out migrations, config changes, data changes, and breaking changes
- list exact validation commands and observed results
- say when validation was not run
- include screenshots or screen recordings for meaningful UI changes

Do not include empty boilerplate sections.

## Validation

Never claim validation that did not run.

Use exact commands when possible:

```markdown
## Validation
- `pnpm test` passed
- `pnpm lint` passed
- Not run: browser QA, because this change is docs-only
```

If checks failed, mention the failure and whether it is related.

For code changes, validation should align with the risk:

- unit tests for changed behavior
- integration/build/typecheck for runtime or package boundary changes
- browser or screenshot checks for meaningful UI changes
- affected package checks in monorepos

## Draft Or Ready

Use draft PRs when:

- implementation is incomplete
- tests or verification are still missing
- design questions are unresolved
- CI is expected to fail
- the PR is for early feedback

Mark ready only when:

- the scope is coherent
- the description is complete
- relevant checks have run or missing checks are disclosed
- known risks are called out
- there are no unresolved author-side unfinished items

## Review Responses

When addressing review comments:

- inspect the exact comment and surrounding code before changing files
- make the smallest fix that addresses the comment
- do not resolve or claim a thread is handled until the change is made or the response explains why no change is needed
- mention validation after follow-up changes
- ask for re-review when the requested changes are addressed

## Merge Readiness

A PR is merge-ready when:

- CI or relevant local checks pass
- required approvals are present
- unresolved review comments are handled
- branch is up to date if the repo requires it
- release notes, migrations, docs, or screenshots are included when relevant

Do not merge or recommend merge when a blocking risk is known and undisclosed.

## Output Modes

When drafting a PR, output a ready-to-use title and body:

```markdown
Title: ...

Body:
...
```

When reviewing PR readiness, output:

- Ready / Draft / Split / Blocked
- Blocking issues
- Suggested title/body changes
- Missing validation

When improving an existing PR body, preserve useful repo-specific template sections and remove empty noise.

## Hard Rules

- Do not hide breaking changes, migrations, data changes, or security-sensitive changes.
- Do not bundle unrelated work just because it is already in the branch.
- Do not claim tests, CI, screenshots, or review approvals that are not evidenced.
- Do not create a ready-for-review PR when the change should be draft.
- Do not overwrite a repository PR template unless the user asks.
