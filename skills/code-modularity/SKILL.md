---
name: code-modularity
description: Use when implementing, reviewing, or refactoring code and there are meaningful signs of coupling, duplication, large modules, unclear ownership, repeated conditionals, leaking implementation details, mixed business logic and IO/UI/framework code, hard-to-test dependencies, or opportunities to improve encapsulation without broad rewrites.
---

# Skill: code-modularity

## Purpose

Improve encapsulation and decoupling at the right moment without over-engineering.

Use this skill to decide whether a code change should include a small structural improvement, propose a focused refactor, or defer the idea because the payoff is not clear enough.

## Trigger Signals

Use this skill when implementation or review reveals:

- the same logic appears in multiple places
- a function, class, component, or module has multiple responsibilities
- modules reach into each other's internals
- package or workspace boundaries are unclear in a monorepo
- business logic is mixed with IO, UI, framework, persistence, or transport code
- changes require editing many unrelated files
- tests are hard to write because dependencies are tangled
- a new feature needs awkward branching because boundaries are unclear
- helper, utility, common, or shared files are becoming dumping grounds
- repeated data transformation, validation, permissions, or error handling logic
- public APIs expose implementation details that callers should not know

## Do Not Trigger For

Avoid modularity work when:

- the code is clear, local, and unlikely to change
- duplication is tiny and not yet meaningful
- the abstraction would be speculative
- the user asked for a narrow urgent fix
- the refactor would expand the blast radius without clear payoff
- there is no realistic verification path
- the change would mostly rename or move code without reducing coupling

## Decision Check

Before proposing or implementing a refactor, answer:

1. Is there real coupling, or just style discomfort?
2. Will this reduce future change cost or test friction?
3. Can it be done as a small behavior-preserving step?
4. Is there enough test, build, or runtime evidence to verify it?

If the answer is weak, defer the refactor and keep the main task focused.

## Preferred Refactor Shapes

Prefer small, local improvements:

- extract a cohesive function
- when the same meaningful logic is used in two or more places, extract it into a single named function unless the duplication is trivial, semantically different, intentionally clearer inline, or clearly temporary
- extract a module around one responsibility
- move logic closer to the data owner or domain owner
- use `naming-conventions` when naming extracted files, folders, modules, or components
- isolate side effects from pure business logic
- split UI rendering from state, data transformation, or validation
- introduce a narrow adapter at system boundaries
- pass explicit dependencies instead of importing hidden globals
- replace broad shared helpers with domain-specific helpers
- define a small interface only when there are multiple implementations or a real test seam

Avoid:

- generic `Manager`, `Service`, `Helper`, or `Util` names without clear ownership
- premature interface layers
- large rewrites
- abstractions only for aesthetics
- merging unrelated similarities into a shared utility
- changing behavior while claiming the work is only structural

## Commenting

- After completing and verifying each new feature or bug fix, inspect the changed behavior for fragile or important logic that future edits might accidentally break. Add concise comments immediately next to those critical spots when the reason, invariant, edge case, ordering requirement, external assumption, or regression risk is not obvious from the code. Comments should explain why the code must remain that way, not restate what the code does. Do not add comments for trivial changes, pure text/docs/config cleanup, or code that is already self-explanatory through names, structure, or extraction.
- If no comment is added, make sure the code is self-explanatory through naming, structure, or extraction.
- Do not add comments that merely restate the code.

## Working Modes

Review-only mode:

- Report the smell, affected files, and suggested small refactor.
- Do not edit files unless the user asks for implementation.

Implementation mode:

- Keep each refactor batch small.
- Prefer characterization tests before changing tangled behavior.
- Preserve existing public behavior unless the user explicitly requests behavior change.
- Verify after each batch before continuing.

## TDD And Verification

- Behavior-changing refactors require TDD.
- Pure movement or extraction with no intended behavior change still needs equivalent verification.
- If tests exist, run the narrowest relevant tests before and after the refactor.
- If no tests exist, use the smallest relevant build, typecheck, lint, or runtime check and state what remains unverified.
- If the refactor exposes a likely bug, route into the preferred debugging skill.
- If the refactor requires new behavior coverage, route into the preferred TDD skill.

## Output Format

When proposing modularity work, use:

- Smell observed:
- Files/modules:
- Suggested refactor:
- Why it reduces coupling:
- Risk:
- Verification:

Rank findings:

- P1: current structure is causing bugs, unsafe changes, or blocked tests
- P2: likely to slow near-term work or spread duplication
- P3: cleanup with limited urgency

When no useful modularity work is warranted, say so and keep the main task moving.

## Integration

- Use during implementation when structure friction appears naturally.
- Use during `review` when findings involve coupling, duplication, unclear ownership, or encapsulation risk.
- Use `naming-conventions` when modularity work creates, moves, renames, or splits files.
- Use `monorepo-structure` when modularity work crosses app, package, workspace, or public export boundaries.
- Use before large refactors to decide the smallest safe batch.
- Use after `debug` when a bug reveals that tangled boundaries helped create the failure.
