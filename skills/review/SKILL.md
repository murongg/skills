---
name: review
description: Use when a change is broad, higher-risk, or explicitly needs inspection for correctness, regressions, missing tests, or scope drift before completion.
---

# Skill: review

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

- if review finds a likely bug, route back into `debug`
- if review finds missing code coverage, route back into `tdd`
- after changes are complete, route into `verify`

## Anti-patterns

- leading with a general overview instead of the actual findings
- praising the work before checking for breakage
- treating style comments as more important than correctness or risk
