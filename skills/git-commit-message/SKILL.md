---
name: git-commit-message
description: Use when drafting, rewriting, reviewing, or choosing git commit messages, especially when the user asks for a commit msg, Conventional Commit, commit title/body/footer, changelog-friendly commit, or a message based on staged changes, git diff, or git status.
---

# Skill: git-commit-message

## Purpose

Create clear, minimal commit messages that follow Conventional Commits v1.0.0.

Use this skill to turn a diff, staged changes, or a user-described change into a commit message that is useful for humans, changelogs, and release automation.

## Required Checks

Before writing the message, inspect the actual change when available:

- Prefer `git diff --cached --stat` and `git diff --cached` for staged commits.
- If nothing is staged, use `git status --short` and ask whether to use unstaged changes, unless the user already provided the change summary.
- Do not include unrelated work in the message. If the diff contains mixed concerns, suggest splitting commits.

## Format

Use this structure:

```text
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

Examples:

```text
feat(installer): sync base instruction files
```

```text
fix(parser)!: reject empty scopes

BREAKING CHANGE: empty commit scopes now fail validation.
```

## Type Selection

Use the narrowest accurate type:

- `feat`: introduces a new user-facing or API-facing capability.
- `fix`: patches a bug.
- `docs`: documentation-only changes.
- `test`: adds or updates tests without changing production behavior.
- `refactor`: changes code structure without changing behavior.
- `perf`: improves performance.
- `build`: changes build system, dependencies, packaging, or generated artifacts.
- `ci`: changes CI configuration or automation.
- `chore`: maintenance that does not fit another type.
- `style`: formatting-only changes with no behavior impact.

If multiple types apply, choose the one that matches the primary user-visible effect. Prefer `feat` or `fix` only when the Conventional Commits meaning truly applies.

## Scope Selection

Use a scope when it improves scanning:

- Prefer a stable package, module, command, feature, or subsystem name.
- Keep it lowercase and concise.
- Omit scope when the change is repository-wide or a scope would be vague.

## Description Rules

- Use imperative mood: `add`, `fix`, `sync`, `remove`, `rename`.
- Start lowercase unless using a proper noun.
- Keep the first line concise, ideally under 72 characters.
- Do not end the subject with a period.
- Describe the change, not the process: prefer `sync base instruction files` over `update files`.

## Body And Footers

Add a body only when the subject cannot explain the why, risk, or migration impact.

Use footers for metadata:

- `BREAKING CHANGE: <details>` for breaking changes.
- `Closes #123`, `Refs #123`, or similar issue references when relevant.

For breaking changes, include either `!` after the type/scope or a `BREAKING CHANGE:` footer. Prefer using both when the impact is important.

## Output Modes

When the user asks for one message, output only the commit message unless context would prevent safe use.

When the diff is ambiguous, give 2-3 candidate messages with short labels:

- single-commit option
- split-commit option
- more specific scoped option

When reviewing an existing message, check:

- valid type and syntax
- subject clarity and length
- correct `!` or `BREAKING CHANGE:` handling
- whether the scope is useful
- whether the body/footer adds signal

## Hard Rules

- Do not invent ticket numbers, scopes, or breaking changes.
- Do not use `feat` for internal cleanup unless it adds a capability.
- Do not use `fix` unless the change corrects faulty behavior.
- Do not mention tests in the subject unless the commit is primarily test-only.
- Do not include markdown fences around the final commit message unless the user asks.
