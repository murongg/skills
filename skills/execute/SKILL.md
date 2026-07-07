---
name: execute
description: Use when the task is already understood well enough to implement directly, or when a brainstorm or plan already exists and the work needs to move into execution.
---

# Skill: execute

## Purpose

Use this skill to move from understanding into implementation.

## Preference note

If a written implementation plan exists and `superpowers:executing-plans` is available locally, prefer that skill. If the written plan contains independent implementation tasks and `superpowers:subagent-driven-development` is available locally, prefer that skill. Use this `execute` skill for direct execution or as the fallback.

## When to use it

- the task is already clear enough to start
- a short inline plan already exists
- a written plan already exists
- the next step is implementation, not more discussion

Do not use this skill as the first step for complex features. Route those through the preferred planning skill before execution.

## Core rule

Choose the lightest execution shape that is still responsible.

Prefer:
- direct implementation for small clear tasks
- short checkpoints for medium tasks
- staged execution for broader work

## Execution rules

- If code changes, route through the preferred TDD skill.
- If the work is a complex feature and no plan exists yet, route into `superpowers:writing-plans` when it is available locally; otherwise route into `plan`.
- If the work reveals an unclear bug, route back into the preferred debugging skill.
- If the work reveals missing design clarity, route back into the preferred brainstorming or planning skill.
- Before claiming completion, route into the preferred verification skill.

## Checkpoint rule

Stop and surface a checkpoint when:

- a hidden assumption turns out to be wrong
- the task expands beyond the original scope
- the next implementation step is risky enough to justify review

## Anti-patterns

- turning every execution task into a long ceremony
- pushing through blockers without updating the workflow choice
- claiming execution is complete without verification
