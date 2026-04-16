# Complexity Rubric

## L0

Use for trivial or informational tasks.

Examples:
- explain a file
- run one command
- answer a direct question

Default behavior:
- answer or act directly
- no structured preamble required

## L1

Use for small, clear tasks.

Examples:
- a small bug fix
- a tightly scoped edit
- a doc-only change

Default behavior:
- short structured analysis
- direct execution
- TDD if code changes
- verify before completion

## L2

Use for moderate but bounded tasks.

Examples:
- a multi-file change
- a small refactor
- a bounded feature with some regression risk

Default behavior:
- short structured analysis
- direct execution or a short internal plan
- TDD for code changes
- optional review
- verify before completion

## L3

Use for complex or ambiguous tasks.

Examples:
- unclear requirements
- multiple viable approaches
- cross-module work

Default behavior:
- brainstorm
- plan
- TDD where code changes occur
- review
- verify

## L4

Use for high-risk or long-running tasks.

Examples:
- large refactors
- architecture-heavy changes
- risky, broad change sets

Default behavior:
- workspace if needed
- brainstorm
- plan
- TDD
- review
- verify
