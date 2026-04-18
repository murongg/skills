---
name: use-my-skills
description: Use when starting any non-trivial development task and you need lightweight routing before deciding whether to execute directly, debug, or escalate into planning.
---

# Skill: use-my-skills

## Purpose

Primary entrypoint for the `my-skills` system.

Use this skill to decide whether the current task should:
- proceed directly
- go through debugging first
- escalate into planning or design
- use isolated workspace setup

## Default behavior

For most non-trivial tasks, start with a short structured preamble:

- Task understanding: what is being asked
- Affected scope: what files, modules, or behaviors are likely involved
- Verification: how the result will be checked

Add a fourth line only when needed:

- Workflow: direct execution / debug first / clarify first / plan first / isolated workspace

## Lightweight-first rule

Default to direct execution for small, clear tasks.

Do not escalate into a formal spec or plan unless the task is ambiguous, broad, risky, or obviously multi-step.

## Direct-execution signals

Prefer direct execution when:

- the request is concrete and bounded
- the likely edit surface is small or obvious
- a bug has a clear symptom and a narrow fix path
- the user is clearly asking for action, not speculation

In these cases, act first and explain briefly, instead of pausing to ask for permission.

## Escalation signals

Escalate before acting when:

- the task has multiple plausible approaches with meaningful trade-offs
- the bug is not yet understood well enough to reproduce or explain
- the task is a complex feature and should be planned before execution
- the change is broad enough that sequencing matters
- the likely blast radius is high

Escalation should be proportional. Prefer the lightest workflow that reduces real risk.

## Hard rules

- If code will change, route into `tdd`.
- If the task is a complex feature, route into `plan` before execution.
- If the task is a clear, well-scoped bug with an obvious reproduction path, the assistant may attempt a fix directly instead of stopping to ask for permission.
- If the task is a bug, failure, or abnormal behavior and the cause is not yet clear, route into `debug` first.
- Before claiming completion, route into `verify`.

## Red flags

- asking for permission when the task is already clear enough to execute
- patching a confusing bug without being able to explain the failure
- escalating into plan or spec mode for a small, obvious fix
- claiming success without fresh evidence

## User-facing style

- professional
- warm
- direct
- concise
- not preachy

Avoid repeatedly naming skills during routine work. Mention them explicitly only when the workflow meaningfully escalates.
