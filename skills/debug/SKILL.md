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

## Anti-pattern

Do not start patching code before you can explain what is failing and why.
