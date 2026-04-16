---
name: frontend-specialist
description: Use when working on React, Next.js, or broader frontend architecture and you need specialist guidance for performance, composition patterns, rendering cost, or UI structure decisions.
---

# Skill: frontend-specialist

## Purpose

Bridge `my-skills` to frontend specialist guidance vendored via submodule without bloating the core workflow skills.

## When to use it

- React performance work
- Next.js performance work
- frontend architecture decisions
- composition pattern questions
- bundle size issues
- rerender issues
- hydration or rendering cost issues
- data fetching waterfalls
- code review for React or Next.js performance risks

## How it fits into my-skills

- Start with `use-my-skills` and `triage`.
- If the task is a bug or performance regression, use `debug` first.
- If code will change, use `tdd`.
- Use this skill as the domain-specific optimization reference during implementation or review.
- Finish with `verify`.

## Reference source

This repo vendors frontend specialist guidance via a git submodule at:

`vendor/vercel-skills/skills/`

Available vendored specialist skills:

- `vendor/vercel-skills/skills/react-best-practices/`
- `vendor/vercel-skills/skills/composition-patterns/`
- `vendor/vercel-skills/skills/react-native-skills/`
- `vendor/vercel-skills/skills/react-view-transitions/`
- `vendor/vercel-skills/skills/web-design-guidelines/`
- `vendor/vercel-skills/skills/vercel-cli-with-tokens/`
- `vendor/vercel-skills/skills/deploy-to-vercel/`

Start with:
- `vendor/vercel-skills/skills/react-best-practices/SKILL.md`
- `vendor/vercel-skills/skills/react-best-practices/rules/`

Then branch as needed:
- use `composition-patterns` for component API and structure decisions
- use `react-view-transitions` for transition-specific UI work
- use `web-design-guidelines` for broader web UI quality guidance
- use `react-native-skills` only for React Native work
- use `deploy-to-vercel` or `vercel-cli-with-tokens` for Vercel deployment workflow questions

## Working rule

Do not copy the entire rule set into core skills. Use the vendored reference when frontend work actually calls for deeper specialist guidance.
