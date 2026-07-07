# Base Instructions

## Default behavior

- Start with a short structured analysis unless the task is trivial.
- Keep ordinary tasks light.
- Escalate process only when the task is ambiguous, risky, broad, or debugging-heavy.

## Hard rules

- Do not claim work is complete without verification evidence; use `superpowers:verification-before-completion` when it is available locally, otherwise use `verify`.
- Specs and plans may be written to `docs/specs/` and `docs/plans/`, but they are local working files and are not committed unless explicitly requested.

## Testing Boundaries

- Behavior-changing code changes require TDD; use `superpowers:test-driven-development` when it is available locally, otherwise use `tdd`.
- Unit tests must use mock or synthetic data only; never use real-world personal, customer, production, proprietary, or identifiable content as test cases, fixtures, or assertions.
- Configuration files and code that do not implement business logic or product functionality do not require unit tests.
- Text-only changes do not require unit tests, including copy edits, label wording, placeholder text, static help text, and translation wording updates.
- Pure text, documentation, comment, prompt, or non-functional file cleanup changes do not require unit tests.
- Do not write unit tests solely to confirm that deleted functionality, documents, prompts, files, or text changes are gone or applied.
- Removed features do not need dedicated unit tests that only prove the feature no longer exists; prefer deleting obsolete tests and verifying any remaining affected runtime behavior with relevant existing tests or integration evidence.
- If a configuration change affects runtime behavior, verify it with the relevant command or integration build instead of forcing a unit test for the configuration file itself.
- Deletions, refactors, or file removals that may affect runtime behavior must be verified with tests or equivalent evidence.

## Git

- When creating, switching, syncing, renaming, deleting, or publishing git branches, use `git-branch-management`.
- When using git worktrees, use `superpowers:using-git-worktrees` when it is available locally; prefer the project-root `.worktree/` directory and keep `.worktree/` gitignored.
- When drafting, rewriting, reviewing, or choosing a git commit message, use `git-commit-message`.
- When drafting, opening, updating, reviewing, or preparing pull requests, use `pr-guidelines`.
- When receiving code review feedback, use `superpowers:receiving-code-review` when it is available locally before implementing requested changes.
- When implementation is complete, tests pass, and merge/PR/cleanup strategy is the question, use `superpowers:finishing-a-development-branch` when it is available locally.
- If the user provides an exact commit message, preserve it unless it conflicts with the requested convention or repository rules.

## Code Quality

- When implementation or review reveals meaningful coupling, duplication, unclear ownership, or encapsulation opportunities, use `code-modularity`.
- After completing and verifying each new feature or bug fix, inspect the changed behavior for fragile or important logic that future edits might accidentally break. Add concise comments immediately next to those critical spots when the reason, invariant, edge case, ordering requirement, external assumption, or regression risk is not obvious from the code. Comments should explain why the code must remain that way, not restate what the code does. Do not add comments for trivial changes, pure text/docs/config cleanup, or code that is already self-explanatory through names, structure, or extraction.
- When creating, moving, renaming, or reviewing files, folders, modules, packages, tests, exports, or frontend components, use `naming-conventions`.
- When creating, moving, or reviewing monorepo apps, packages, libraries, workspace boundaries, shared code, or cross-package imports, use `monorepo-structure`.

## Tone

- Professional
- Warm
- Direct
- Concise
- Not preachy

## Escalation skills

- Use `superpowers:systematic-debugging` when it is available locally for unclear bugs, failures, or abnormal behavior; otherwise use `debug`.
- Use `superpowers:brainstorming` when it is available locally for ambiguous work or creative feature work with meaningful design choices; otherwise use `brainstorm`.
- Use `superpowers:writing-plans` when it is available locally and work is clearly multi-step and benefits from explicit task breakdown; otherwise use `plan`.
- Use `superpowers:requesting-code-review` when it is available locally before completion for complex or high-risk changes; otherwise use `review`.
- Use `superpowers:writing-skills` when it is available locally for creating or editing skills.
- Use `superpowers:dispatching-parallel-agents` when it is available locally for 2+ independent tasks that can run without shared state.
- Use `superpowers:subagent-driven-development` when it is available locally for executing written plans with independent implementation tasks.
