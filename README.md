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
- creates a symlink from the platform's skills directory to this repo's `skills/`
- never overwrites an existing non-symlink directory
- stops with a clear error if the target path already exists and points somewhere else

Installed locations:
- Codex / Codex CLI: `~/.agents/skills/my-skills`
- OpenCode: `~/.config/opencode/skills/my-skills`
- Claude Code: `~/.claude/skills/my-skills`

If you cloned the repo somewhere other than `~/my-skills`, the installer still works. It links the platform skill directories to the current repo's `skills/` directory.

### Manual installation

If you prefer to install manually, create the same symlink yourself.

#### Codex / Codex CLI

```bash
git clone https://github.com/murongg/skills.git ~/my-skills
cd ~/my-skills
mkdir -p ~/.agents/skills
ln -s "$(pwd)/skills" ~/.agents/skills/my-skills
```

#### OpenCode

```bash
git clone https://github.com/murongg/skills.git ~/my-skills
cd ~/my-skills
mkdir -p ~/.config/opencode/skills
ln -s "$(pwd)/skills" ~/.config/opencode/skills/my-skills
```

#### Claude Code

```bash
git clone https://github.com/murongg/skills.git ~/my-skills
cd ~/my-skills
mkdir -p ~/.claude/skills
ln -s "$(pwd)/skills" ~/.claude/skills/my-skills
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

## Project Layout

- `skills/` - the installable skill set
- `skills/references/` - shared tool mapping and complexity guidance
- `vendor/` - external specialist repositories tracked separately from the core workflow skills
- `docs/specs/` - local design notes, ignored by git by default
- `docs/plans/` - local implementation plans, ignored by git by default
- `tests/smoke/` - lightweight repository checks

## Vendored Skills

This repo vendors external specialist guidance when it is useful, but keeps it separate from the core `my-skills` workflow.

Current vendor:
- `vendor/vercel-skills`

Current bridge skill:
- `frontend-specialist`

Use that bridge when React or Next.js work needs deeper performance guidance, instead of stuffing framework-specific rules into `use-my-skills`, `triage`, or `review`.

The current Vercel integration is tracked as a git submodule at `vendor/vercel-skills`. The bridge skill only references the upstream `skills/` subtree, so the core workflow stays focused even though the full upstream repo is present.

## Current Status

- Phase 1 is implemented: `use-my-skills`, `triage`, `tdd`, `debug`, `verify`
- Phase 2 is implemented: `brainstorm`, `plan`, `review`
- Phase 3 is still open: `workspace`, richer platform docs, and broader testing
