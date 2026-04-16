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
test -f skills/execute/SKILL.md
test -f skills/review/SKILL.md
grep -n "docs/specs/" AGENTS.md
grep -n "TDD" skills/tdd/SKILL.md
grep -n "brainstorm" README.md
grep -n "clear, well-scoped bug" skills/use-my-skills/SKILL.md
grep -n "do not pause just to ask" skills/triage/SKILL.md
grep -n "Fast-path exception" skills/debug/SKILL.md
grep -n "Do not say \"done\"" skills/verify/SKILL.md
grep -n "Only escalate into a written spec if the task is large enough" skills/brainstorm/SKILL.md
grep -n "short inline plan for moderate tasks" skills/plan/SKILL.md
grep -n "Use this skill to move from understanding into implementation" skills/execute/SKILL.md
grep -n "severity order" skills/review/SKILL.md
grep -n "file and line references" skills/review/SKILL.md
grep -n "If no findings are discovered" skills/review/SKILL.md
```

Expected results:
- each `test -f` command exits successfully
- the `grep` commands return matching lines
