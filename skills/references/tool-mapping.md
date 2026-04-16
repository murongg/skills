# Tool Mapping

`my-skills` keeps workflow rules platform-neutral. Platform differences belong in mappings like these.

## Common capabilities

All supported platforms should provide equivalents for:
- reading files
- editing files
- searching files and content
- running shell commands
- loading skills when available

## OpenCode

- Todo tracking tool -> `todowrite`
- Skill loading -> native `skill` tool
- Shell commands -> native terminal command tool
- Subagents -> optional; use only as an enhancement

## Claude Code

- Todo tracking tool -> `TodoWrite`
- Skill loading -> `Skill`
- Shell commands -> `Bash`
- Subagents -> optional enhancement, not a requirement

## Codex / Codex CLI

- Todo tracking -> use the platform's task-tracking equivalent if available, otherwise inline progress updates
- Skill loading -> native skill discovery or local equivalent
- Shell commands -> native terminal execution
- Subagents -> optional enhancement, not a requirement
