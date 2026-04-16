---
name: brainstorm
description: Use when requirements are ambiguous, multiple viable approaches exist, or wrong assumptions would be costly and you need focused clarification before implementation.
---

# Skill: brainstorm

## Purpose

Use this skill when the task is too ambiguous for direct execution.

## When to use it

- requirements are unclear
- multiple valid approaches exist
- the task scope is large enough that wrong assumptions would be costly

## Default behavior

1. Clarify the task with focused questions.
2. Prefer one question at a time.
3. Summarize the likely approaches.
4. Recommend one approach with a short reason.
5. Only escalate into a written spec if the task is large enough to benefit from one.

## Scope discipline

Do not drag small clear tasks into brainstorming.

This skill is for:
- unclear scope
- real trade-offs
- meaningful design choices

This skill is not for:
- obvious bugfixes
- tiny edits
- tasks where the next step is already clear

## Output shape

Keep the discussion short and decision-oriented.

Aim to leave the user with:
- a clearer task boundary
- a recommended direction
- a reason for that recommendation

If the task becomes clear quickly, stop brainstorming and move on.

## Output style

- concise
- collaborative
- not preachy
- not over-formal for small tasks

## Git rule

If a spec is written to `docs/specs/`, treat it as a local working file and do not commit it unless explicitly requested.
