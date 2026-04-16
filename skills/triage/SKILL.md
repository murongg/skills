---
name: triage
description: Use when a task needs a quick complexity, scope, or risk check before deciding whether to answer directly, debug first, or escalate into brainstorming or planning.
---

# Skill: triage

## Purpose

Quickly classify the task before deeper action.

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

## Routing rules

- Code change -> `tdd`
- Bug, failing test, error, abnormal behavior -> `debug`
- Ambiguous or broad work -> `brainstorm`, then `plan`
- Completion claim -> `verify`

## Omission rule

The preamble may be skipped only for pure conversation, single-command requests, and extremely small, unambiguous tasks.
