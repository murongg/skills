---
name: plan
description: Use when work spans multiple steps, files, or execution passes and explicit task breakdown would reduce mistakes before implementation begins.
---

# Skill: plan

## Purpose

Use this skill when the work is clearly multi-step and should be broken down before implementation.

## When to use it

- the task spans multiple files or modules
- the task will likely take multiple execution passes
- the task is a complex feature
- explicit sequencing would reduce mistakes

## Planning rules

- break the work into concrete steps
- keep the plan as short as the task allows
- include verification steps
- use `plan` before execution for complex features
- route code-changing implementation through `tdd`

## Planning discipline

Use the shortest plan that still reduces mistakes.

Prefer:
- no written plan for small obvious work
- a short inline plan for moderate tasks
- a written plan only when sequencing, scope, or coordination really matter

Every plan should answer:
- what gets done first
- what can be verified after each step
- where the risky parts are

## Output options

- short inline plan for moderate tasks
- written plan in `docs/plans/` for larger tasks

## Git rule

If a plan is written to `docs/plans/`, treat it as a local working file and do not commit it unless explicitly requested.
