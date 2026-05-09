---
name: monorepo-structure
description: Use when creating, moving, reviewing, or refactoring monorepo apps, packages, libraries, workspace layout, package boundaries, cross-package imports, shared code, package scripts, dependency ownership, release/versioning setup, or affected build/test/lint/typecheck workflows.
---

# Skill: monorepo-structure

## Purpose

Keep monorepos understandable by making apps, packages, ownership, dependencies, and verification boundaries explicit.

Use this skill when work crosses package/workspace boundaries or when deciding whether code belongs in an app, a reusable package, tooling, config, or docs.

## Reference Model

Use this blended model unless the repository already has stronger conventions:

- Turborepo: lightweight `apps/` and `packages/` layout, package graph, and task graph.
- Nx: enforceable project/package boundaries and tag-based dependency rules.
- moonrepo: layer, stack, owner, maintainer, and project metadata.
- Changesets: multi-package versioning, changelogs, and internal dependency updates for publishable packages.

Do not force any one tool. Detect and follow existing workspace tooling such as `pnpm-workspace.yaml`, `turbo.json`, `nx.json`, `.moon/`, `lerna.json`, `package.json` workspaces, or Changesets config.

## Default Layout

Prefer:

```text
apps/       deployable applications
packages/   reusable libraries and internal packages
tools/      repo tooling, scripts, generators, CLIs
configs/    shared lint, TypeScript, build, test, or styling config
docs/       repository documentation
```

Use `naming-conventions` for package, folder, and file names. Keep package names short and one-word-first when that stays clear.

Avoid nested workspace globs such as `apps/**` or `packages/**` unless the package manager and repository already support them clearly.

## Boundary Rules

Default dependency direction:

- apps may depend on packages
- packages must not depend on apps
- tools may depend on packages when needed
- configs should stay dependency-light and not depend on apps
- packages should import other packages through public exports

Avoid:

- deep imports across package boundaries
- circular dependencies between packages
- shared, common, utils, or core packages without clear ownership and scope
- app-specific logic inside reusable packages
- package internals imported by unrelated workspaces

If using Nx, moon, or another boundary-aware tool, prefer encoded constraints over comments or tribal knowledge.

## Package Creation

Create a new package only when there is a real boundary:

- reused by multiple apps or packages
- independent owner or maintenance responsibility
- independent build, test, lint, typecheck, or release boundary
- dependency isolation need
- clear public API or exports surface
- publish/versioning need

Do not create a package only because:

- a folder is getting large
- code looks loosely similar
- architecture would look neater
- reuse is speculative

Colocate first until reuse or boundary pressure is real.

## Shared Code

Shared code must have a purpose, owner, and audience.

Prefer scoped packages:

```text
packages/auth
packages/ui
packages/db
packages/config
packages/validation
packages/logger
```

Avoid catch-all packages:

```text
packages/shared
packages/common
packages/utils
packages/core
```

Use a broad shared package only when the repository already defines exactly what belongs there.

## Package Metadata

Each workspace package should usually own:

- `package.json`
- package-level scripts when commands differ from root defaults
- explicit dependencies used by that package
- public exports when other workspaces import it
- tests or verification commands appropriate to the package

Keep root dependencies for repo-level tooling. Put runtime dependencies in the package that uses them.

For publishable packages, keep versioning, changelog, exports, and internal dependency update behavior explicit. Prefer Changesets or the repository's established release tool.

## Imports And Public APIs

Cross-package imports should use the package public API:

```text
import { Button } from "@repo/ui"
```

Avoid deep internals:

```text
import { Button } from "@repo/ui/src/components/Button"
```

Use `index.ts` or package `exports` only as a stable boundary. Do not turn barrels into dumping grounds or hide complex implementation logic behind them.

## Task Graph And Verification

After changing package boundaries, workspace config, exports, or cross-package dependencies, run the smallest affected verification:

- affected build
- affected test
- affected typecheck
- affected lint
- package graph or task graph check if available

Examples:

```bash
pnpm --filter <package> test
pnpm --filter <package> build
pnpm turbo run build --filter=<package>
pnpm nx affected -t test,build
```

Use existing scripts and tools. Do not invent a monorepo toolchain just to satisfy this skill.

## Review Signals

Route into this skill when review or implementation finds:

- an app imported by a package
- cross-package deep imports
- circular package dependencies
- a shared package becoming a dumping ground
- dependencies installed only at root but used by one package
- missing package exports
- package scripts that do not match repository task conventions
- workspace config not updated with new/moved packages
- affected verification skipped after boundary changes

## Output Format

When proposing monorepo changes, include:

- Boundary issue:
- Affected workspaces:
- Suggested structure:
- Dependency direction:
- Config/package metadata updates:
- Verification:

Prefer one small boundary change at a time. If the change is broad, route into `plan`.

## Hard Rules

- Do not move code across package boundaries without checking imports, exports, package metadata, and affected verification.
- Do not create packages with vague ownership.
- Do not make packages depend on apps.
- Do not deep import package internals across workspace boundaries unless the repo explicitly allows it.
- Do not add root dependencies that belong to one package.
