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

## Hard rules

- If code will change, route into `tdd`.
- If the task is a bug, failure, or abnormal behavior, route into `debug` first.
- Before claiming completion, route into `verify`.

## User-facing style

- professional
- warm
- direct
- concise
- not preachy

Avoid repeatedly naming skills during routine work. Mention them explicitly only when the workflow meaningfully escalates.
