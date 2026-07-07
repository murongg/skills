---
name: review
description: Use when a change is broad, higher-risk, or explicitly needs inspection for correctness, regressions, missing tests, or scope drift before completion.
---

# Skill: review

## Preference note

If `superpowers:requesting-code-review` is available locally, prefer it for major feature completion, merge readiness, and high-risk changes. If addressing external review feedback, prefer `superpowers:receiving-code-review` when available. Use this `review` skill as the fallback or for lighter in-progress review.

## Purpose

Inspect higher-risk work for defects, regressions, missing tests, and scope drift.

## When to use it

- the change is broad enough that regressions are plausible
- the task affects multiple files or behaviors
- the user explicitly asks for a review

## Review priorities

1. correctness issues
2. regression risk
3. missing or weak test coverage
4. unnecessary scope expansion
5. meaningful coupling, duplication, or ownership-boundary risks
6. naming that obscures ownership, purpose, or maintainability
7. monorepo package boundary, workspace, or cross-package dependency risks

Present findings in severity order.

## Output style

- findings first
- concise explanations
- explicit uncertainty when evidence is missing

## Output format

When reporting findings:

- list concrete findings before summary
- include file and line references when you have them
- keep the focus on bugs, regressions, and missing tests

If no findings are discovered, say that explicitly and mention any remaining risk or testing gaps.

## Integration rules

- if review finds a likely bug, route back into the preferred debugging skill
- if review finds missing code coverage, route back into the preferred TDD skill
- if review finds meaningful coupling, duplication, unclear ownership, or encapsulation risk, route into `code-modularity`
- if review finds file, folder, module, package, test, export, or component naming problems, route into `naming-conventions`
- if review finds monorepo app/package boundary, workspace config, shared package, or cross-package import problems, route into `monorepo-structure`
- after changes are complete, route into the preferred verification skill

## Anti-patterns

- leading with a general overview instead of the actual findings
- praising the work before checking for breakage
- treating style comments as more important than correctness or risk
