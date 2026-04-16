---
name: debug
description: Use when there is a bug, failing test, unexpected behavior, or runtime error and you need root-cause investigation before attempting a fix.
---

# Skill: debug

## Purpose

Debug from evidence instead of guessing.

## Fast-path exception

Do not force this skill when the bug is already clear, narrowly scoped, and ready for a direct fix. In that case, fix it directly and still use `tdd` for code changes plus `verify` before completion.

## Required sequence

1. Restate the observed failure.
2. Identify how to reproduce it.
3. Gather evidence from logs, tests, or runtime behavior.
4. Identify the most likely root cause.
5. If the fix requires code changes, route into `tdd` before implementing the fix.
6. Route into `verify` before claiming the issue is solved.

## Minimum bar before fixing

Before changing code under this skill, be able to say:

- what is failing
- how it can be reproduced or observed
- why the suspected area is the likely source

If you cannot say those three things yet, keep investigating.

## Anti-pattern

Do not start patching code before you can explain what is failing and why.

## Red flags

- "I think this might work"
- changing multiple things at once
- fixing the visible symptom without checking where it comes from
- skipping reproduction because the bug looks obvious when it is not
