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

## Output style

- findings first
- concise explanations
- explicit uncertainty when evidence is missing

## Integration rules

- if review finds a likely bug, route back into `debug`
- if review finds missing code coverage, route back into `tdd`
- after changes are complete, route into `verify`
