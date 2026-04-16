---
name: tdd
description: Use when changing production code, fixing behavior in code, or making a code-level refactor that requires a failing test before implementation.
---

# Skill: tdd

TDD is mandatory for code changes.

## Rule

If code changes, write a failing test first.

## Required sequence

1. Write or update a test that expresses the intended behavior.
2. Run the test and confirm it fails for the expected reason.
3. Implement the smallest code change that can make it pass.
4. Re-run the test and confirm it passes.
5. Run any relevant neighboring tests before completion.

## Applies to

- production code changes
- bug fixes implemented in code
- behavior-changing refactors

## Does not apply to

- prose-only documentation edits
- path-only changes
- non-behavioral housekeeping edits

## Hard stop

Do not write production code before the failing test exists.
