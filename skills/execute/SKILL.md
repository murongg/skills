---
name: execute
description: Use when the task is already understood well enough to implement directly, or when a brainstorm or plan already exists and the work needs to move into execution.
---

# Skill: execute

## Purpose

Use this skill to move from understanding into implementation.

## When to use it

- the task is already clear enough to start
- a short inline plan already exists
- a written plan already exists
- the next step is implementation, not more discussion

## Core rule

Choose the lightest execution shape that is still responsible.

Prefer:
- direct implementation for small clear tasks
- short checkpoints for medium tasks
- staged execution for broader work

## Execution rules

- If code changes, route through `tdd`.
- If the work reveals an unclear bug, route back into `debug`.
- If the work reveals missing design clarity, route back into `brainstorm` or `plan`.
- Before claiming completion, route into `verify`.

## Checkpoint rule

Stop and surface a checkpoint when:

- a hidden assumption turns out to be wrong
- the task expands beyond the original scope
- the next implementation step is risky enough to justify review

## Anti-patterns

- turning every execution task into a long ceremony
- pushing through blockers without updating the workflow choice
- claiming execution is complete without verification
