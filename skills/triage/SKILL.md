---
name: triage
description: Use when a task needs a quick complexity, scope, or risk check before deciding whether to answer directly, debug first, or escalate into brainstorming or planning.
---

# Skill: triage

## Purpose

Quickly classify the task before deeper action.

## Goal

Choose the lightest workflow that is still responsible.

## Output format

Use this short structure for most tasks:

- Task understanding: ...
- Affected scope: ...
- Verification: ...

Add this only when needed:

- Workflow: direct execution / debug first / clarify first / plan first / isolated workspace

## Decision rules

- L0: answer or act directly
- L1: direct execution, TDD if code changes, verify at the end
- L2: direct execution or short internal plan, TDD if code changes, optional review, verify at the end
- L3: brainstorm and plan before implementation
- L4: isolated workspace if helpful, then full escalated workflow

## Direct-fix bug rule

When a bug is clear and well-scoped, do not pause just to ask whether to try fixing it.

Use the fast path when all of these are true:

- the symptom is concrete
- the likely change area is narrow
- the next step is obvious enough to try safely

If those conditions do not hold, switch to `debug`.

## Routing rules

- Code change -> `tdd`
- Clear, well-scoped bug with a concrete symptom -> direct execution, then `tdd` if code changes, then `verify`
- Bug, failing test, error, abnormal behavior with unclear cause -> `debug`
- Ambiguous or broad work -> `brainstorm`, then `plan`
- Completion claim -> `verify`

## Red flags

- using `debug` for a bug that is already obvious and narrowly scoped
- skipping `debug` when the cause is still guesswork
- reaching for `plan` when a short direct fix would do
- treating every task as if it needs the same level of ceremony

## Omission rule

The preamble may be skipped only for pure conversation, single-command requests, and extremely small, unambiguous tasks.
