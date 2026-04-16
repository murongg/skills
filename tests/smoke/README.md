# Smoke Checks

Phase 1 uses lightweight smoke checks.

Run these commands after editing the core skills:

```bash
test -f skills/use-my-skills/SKILL.md
test -f skills/triage/SKILL.md
test -f skills/tdd/SKILL.md
test -f skills/debug/SKILL.md
test -f skills/verify/SKILL.md
test -f skills/brainstorm/SKILL.md
test -f skills/plan/SKILL.md
test -f skills/review/SKILL.md
grep -n "docs/specs/" AGENTS.md
grep -n "TDD" skills/tdd/SKILL.md
grep -n "brainstorm" README.md
```

Expected results:
- each `test -f` command exits successfully
- the `grep` commands return matching lines
