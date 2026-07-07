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

## Superpowers preference

When a matching Superpowers skill is available locally, prefer it. Otherwise use the `my-skills` fallback.

| Need | Preferred local Superpowers skill | Fallback |
| --- | --- | --- |
| unclear bug, failure, abnormal behavior | `superpowers:systematic-debugging` | `debug` |
| code-changing TDD | `superpowers:test-driven-development` | `tdd` |
| completion verification | `superpowers:verification-before-completion` | `verify` |
| explicit multi-step planning | `superpowers:writing-plans` | `plan` |
| ambiguous work or creative feature design | `superpowers:brainstorming` | `brainstorm` |
| major completion or merge-readiness review | `superpowers:requesting-code-review` | `review` |
| receiving code review feedback | `superpowers:receiving-code-review` | `review`/`pr-guidelines` |
| executing a written implementation plan | `superpowers:executing-plans` | `execute` |
| independent tasks inside a written plan | `superpowers:subagent-driven-development` | `execute` |
| 2+ independent tasks without shared state | `superpowers:dispatching-parallel-agents` | direct execution |
| git worktree setup | `superpowers:using-git-worktrees` | `git-branch-management` |
| branch completion, merge, PR, or cleanup choice | `superpowers:finishing-a-development-branch` | `pr-guidelines`/`git-branch-management` |
| creating or editing skills | `superpowers:writing-skills` | local skill rules |

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

- If code will change, route into the preferred TDD skill.
- If the task is a complex feature, route into the preferred planning skill before execution.
- If the task is a clear, well-scoped bug with an obvious reproduction path, the assistant may attempt a fix directly instead of stopping to ask for permission.
- If the task is a bug, failure, or abnormal behavior and the cause is not yet clear, route into the preferred debugging skill first.
- Before claiming completion, route into the preferred verification skill.

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
