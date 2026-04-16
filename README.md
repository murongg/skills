# my-skills

`my-skills` is a personal, multi-platform skills system for daily development work.

It keeps the engineering discipline that matters most:
- code changes use TDD
- completion requires verification

It keeps the default workflow light:
- short structured analysis first
- direct execution for simple tasks
- escalation only for ambiguity, risk, or debugging-heavy work

Phase 1 includes:
- `use-my-skills`
- `triage`
- `tdd`
- `debug`
- `verify`
- reference docs for tool mapping and complexity levels

Phase 2 adds:
- `brainstorm`
- `plan`
- `review`

Specialized guidance can also be layered in without bloating the core workflow. This repo vendors frontend guidance and exposes it through a thin bridge skill:
- `frontend-specialist`

## Quick Start

Run the installer directly with `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash
```

The script is interactive by default and will ask which platform to install for.

If you want a non-interactive install, pass `--platform` with one of:
- `codex`
- `opencode`
- `claude`
- `all`

After installation, restart the target tool and ask it to use `my-skills/use-my-skills`.

Repository:
- GitHub: `https://github.com/murongg/skills/tree/main`
- Clone URL: `https://github.com/murongg/skills.git`

## Installation

### Installer script

The repository includes a local installer:

```bash
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash
```

You can target a specific platform non-interactively like this:

```bash
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash -s -- --platform codex
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash -s -- --platform opencode
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash -s -- --platform claude
```

What it does:
- builds a generated clean skills tree that combines your core skills with selected vendored specialist skills
- installs that clean skills tree as a real directory under `~/.agents/skills/my-skills`
- links Claude Code and OpenCode to that central directory
- never overwrites an existing non-symlink directory
- stops with a clear error if the target path already exists and points somewhere else

Installed locations:
- Codex / Codex CLI: real directory at `~/.agents/skills/my-skills`
- OpenCode: symlink at `~/.config/opencode/skills/my-skills`
- Claude Code: symlink at `~/.claude/skills/my-skills`

If you cloned the repo somewhere other than `~/my-skills`, the installer still works. It builds the generated skills tree from the current repo, copies it into `~/.agents/skills/my-skills`, and then points the other platform directories at that central install.

### Manual installation

Manual file copying is intentionally not documented here.

Use the installer script instead so it can:
- bootstrap the repo when running from `curl | bash`
- fetch submodules
- build the generated clean skills tree correctly
- install a real central directory under `~/.agents/skills/my-skills`
- point Claude Code and OpenCode at that central install

Recommended commands:

```bash
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash
```

Or, for a specific platform:

```bash
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash -s -- --platform codex
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash -s -- --platform opencode
curl -fsSL https://raw.githubusercontent.com/murongg/skills/main/scripts/install.sh | bash -s -- --platform claude
```

## Verify Installation

After restarting the target tool, try one of these prompts:

- `Use the my-skills/use-my-skills skill and summarize how you would handle a small bugfix.`
- `Load my-skills/triage and show me the default lightweight preamble.`
- `Use my-skills/tdd and tell me the required sequence for a code change.`

If the tool can load those skills, the installation worked.

If a platform reports duplicate skill warnings, that usually means the same `my-skills` directory is linked into more than one discovery location. That is noisy but not the same as a load failure.

## Usage

Typical flows:

- Small bugfix:
  `use-my-skills -> triage -> tdd -> verify`
- Debugging a failure:
  `use-my-skills -> triage -> debug -> tdd -> verify`
- Ambiguous feature work:
  `use-my-skills -> triage -> brainstorm -> plan -> review -> verify`

Bug handling rule:

- If a bug is clear and well-scoped, `my-skills` should try fixing it directly instead of pausing just to ask for permission.
- If the cause is unclear, it should route into `debug` first.

## Project Layout

- `skills/` - your core workflow skill set
- `skills/references/` - shared tool mapping and complexity guidance
- `vendor/` - upstream sources kept for synchronization reference
- `.generated/` - installer-built clean skill tree used for local installation
- `docs/specs/` - local design notes, ignored by git by default
- `docs/plans/` - local implementation plans, ignored by git by default
- `tests/smoke/` - lightweight repository checks

## Vendored Skills

This repo uses external specialist guidance when it is useful, but exposes the selected skills through the installer-generated clean skill tree instead of checking them into the core `skills/` directory.

Current bridge skill:
- `frontend-specialist`

Selected specialist skills are merged into the generated install tree, including:
- `vercel-react-best-practices`
- `composition-patterns`
- `react-native-skills`
- `react-view-transitions`
- `web-design-guidelines`
- `vercel-cli-with-tokens`
- `deploy-to-vercel`
- `ui-ux-pro-max`

Use `frontend-specialist` when React, Next.js, or broader frontend work needs deeper specialist guidance, instead of stuffing framework-specific rules into `use-my-skills`, `triage`, or `review`.

## Current Status

- Phase 1 is implemented: `use-my-skills`, `triage`, `tdd`, `debug`, `verify`
- Phase 2 is implemented: `brainstorm`, `plan`, `review`
- Phase 3 is still open: `workspace`, richer platform docs, and broader testing
