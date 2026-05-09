---
name: naming-conventions
description: Use when creating, moving, renaming, or reviewing files, folders, modules, packages, components, hooks, helpers, tests, or exports, especially when choosing concise one-word-first names, enforcing PascalCase frontend component names, avoiding vague utility names, or aligning names with existing repository conventions.
---

# Skill: naming-conventions

## Purpose

Choose clear names for files, folders, modules, components, and exports.

Use a one-word-first naming style: prefer one stable concept over long descriptive phrases, while preserving enough meaning to avoid vague names.

## Precedence

Follow this order:

1. Explicit user instruction.
2. Existing repository convention.
3. Framework or platform convention.
4. This skill's default rules.

Exception: frontend component files must use PascalCase unless the user explicitly says otherwise.

## Language Scope

The default file and folder rules are optimized for JavaScript, TypeScript, and web projects.

For other languages, follow the language ecosystem and repository conventions first:

- Python, Ruby, and Rust commonly prefer `snake_case` files.
- Go commonly prefers short lowercase package names and `_test.go` test files.
- Java, Kotlin, C#, and Swift commonly use `PascalCase` files for types.
- C and C++ vary by project; common styles include `snake_case` or names matching the primary type.

The one-word-first preference still applies when it does not conflict with language or repository convention.

## Core Preference

Prefer one-word names when one word clearly names the concept:

```text
auth/
user/
billing/
search/
parser.ts
schema.ts
client.ts
cache.ts
queue.ts
router.ts
adapter.ts
policy.ts
session.ts
```

Use two-word names only when one word would be vague or misleading:

```text
rate-limit/
billing-cycle.ts
search-index.ts
```

Avoid three or more words unless the phrase is a stable domain term.

## Files And Folders

Default to lowercase for non-component files and folders.

For JavaScript, TypeScript, web, and frontend-adjacent projects:

- Use `kebab-case` for non-component files and folders when multiple words are needed.
- Use one slash only for normal folder hierarchy, not to encode long names.
- Keep directory depth shallow unless the hierarchy reflects real ownership.
- Prefer domain or responsibility names over action phrases.

Avoid:

- `utils.ts`, `helpers.ts`, `common.ts`, `shared.ts`, `misc.ts`, `stuff.ts`
- `new`, `old`, `final`, `temp`, `backup`
- names that describe implementation mechanics instead of purpose
- moving code into shared folders only because names look similar

Use a broad shared name only when the repository already gives it a precise meaning.

## Frontend Components

Frontend component files and component folders must use PascalCase:

```text
UserMenu.tsx
BillingCard.tsx
SearchPanel.tsx
UserMenu/
BillingCard/
```

The component file name should match the component export when practical:

```text
UserMenu.tsx -> export function UserMenu()
BillingCard.tsx -> export default BillingCard
```

Component-adjacent non-component files may use lower-case conventions:

```text
UserMenu.tsx
user-menu.test.tsx
user-menu.stories.tsx
user-menu.css
```

If the repository already uses `ComponentName.test.tsx` or `ComponentName.module.css`, follow that existing local pattern for adjacent files.

## Tests

Test files should mirror the source file or concept:

```text
parser.ts -> parser.test.ts
user.ts -> user.test.ts
UserMenu.tsx -> user-menu.test.tsx or UserMenu.test.tsx, matching local convention
```

Do not create disconnected top-level test names when a colocated or mirrored name is clearer.

## Exports And Index Files

Name a single-export file after its main export or concept.

For multi-export files, require strong cohesion. If there is no single common theme, split the file.

Use `index.ts` only for stable public API barrels or framework-required entry points. Do not hide complex implementation logic in `index.ts`.

## Renaming Decisions

Rename when:

- the current name no longer matches responsibility
- the name is too vague to guide future changes
- the file or folder has become a dumping ground
- a clearer name reduces import or navigation confusion

Do not rename when:

- the change is only personal taste
- churn is high and the benefit is low
- the repository has a strong opposite convention
- the name is long but is a stable domain term

## Integration

- Use during `code-modularity` when extracting, moving, or splitting files.
- Use during `review` when naming harms readability, ownership, or future maintenance.
- Use when creating frontend components to enforce PascalCase component names.
- Use when introducing tests to keep test names aligned with source names.

## Output

When proposing names, give 2-3 options at most:

- Recommended:
- Alternative:
- Avoid:

Explain briefly why the recommended name is specific, short, and consistent with local conventions.
