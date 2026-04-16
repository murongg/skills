# Skill: verify

## Purpose

Require evidence before claiming work is complete.

## Required output

Before saying a task is complete, report:

- what was checked
- which command or action produced the evidence
- what the observed result was

## Verification rules

- Use the smallest relevant verification first.
- If code changed, include the relevant test result.
- If behavior changed, include the command, test, or runtime evidence that demonstrates the new behavior.
- If verification could not be run, say so explicitly and explain why.

## Hard stop

Do not say "done", "fixed", or "complete" without evidence.
