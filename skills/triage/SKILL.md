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
- L1: direct execution, preferred TDD if code changes, preferred verification at the end
- L2: direct execution or short internal plan, preferred TDD if code changes, optional preferred review, preferred verification at the end
- L3: preferred brainstorming and planning before implementation
- L4: isolated workspace if helpful, then full escalated workflow

## Superpowers preference

Use local Superpowers equivalents when available, then fall back to `my-skills`: `superpowers:systematic-debugging` -> `debug`, `superpowers:test-driven-development` -> `tdd`, `superpowers:verification-before-completion` -> `verify`, `superpowers:brainstorming` -> `brainstorm`, `superpowers:writing-plans` -> `plan`, and `superpowers:requesting-code-review` -> `review`.

## Direct-fix bug rule

When a bug is clear and well-scoped, do not pause just to ask whether to try fixing it.

Use the fast path when all of these are true:

- the symptom is concrete
- the likely change area is narrow
- the next step is obvious enough to try safely

If those conditions do not hold, switch to the preferred debugging skill.

## Routing rules

- Code change -> preferred TDD skill
- Clear, well-scoped bug with a concrete symptom -> direct execution, then preferred TDD if code changes, then preferred verification
- Bug, failing test, error, abnormal behavior with unclear cause -> preferred debugging skill
- Ambiguous or broad work -> preferred brainstorming skill, then preferred planning skill
- Completion claim -> preferred verification skill

## Red flags

- using `debug` for a bug that is already obvious and narrowly scoped
- skipping `debug` when the cause is still guesswork
- reaching for `plan` when a short direct fix would do
- treating every task as if it needs the same level of ceremony

## Omission rule

The preamble may be skipped only for pure conversation, single-command requests, and extremely small, unambiguous tasks.
