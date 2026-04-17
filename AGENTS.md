# my-skills Working Rules

## Default behavior

- Start with a short structured analysis unless the task is trivial.
- Keep ordinary tasks light.
- Escalate process only when the task is ambiguous, risky, broad, or debugging-heavy.

## Hard rules

- Behavior-changing code changes require TDD.
- Pure text, documentation, comment, prompt, or non-functional file cleanup changes do not require unit tests.
- Do not write unit tests solely to confirm that deleted functionality, documents, prompts, files, or text changes are gone or applied.
- Deletions, refactors, or file removals that may affect runtime behavior must be verified with tests or equivalent evidence.
- Do not claim work is complete without verification evidence.
- Specs and plans may be written to `docs/specs/` and `docs/plans/`, but they are local working files and are not committed unless explicitly requested.

## Tone

- Professional
- Warm
- Direct
- Concise
- Not preachy

## Escalation skills

- Use `brainstorm` when requirements are ambiguous or there are multiple viable approaches.
- Use `plan` when work is clearly multi-step and benefits from explicit task breakdown.
- Use `review` before completion for complex or high-risk changes.
