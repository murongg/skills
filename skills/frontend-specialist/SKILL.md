---
name: frontend-specialist
description: Use when working on React, Next.js, or broader frontend architecture and you need specialist guidance for performance, composition patterns, rendering cost, or UI structure decisions.
---

# Skill: frontend-specialist

## Purpose

Bridge `my-skills` to frontend specialist guidance that is merged into the generated install tree without bloating the core workflow skills.

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

This repo keeps frontend specialist guidance in vendor sources, and the installer merges the selected specialist skills into the generated install tree.

Available specialist skills during install:

- `vendor/vercel-skills/skills/react-best-practices/`
- `vendor/vercel-skills/skills/composition-patterns/`
- `vendor/vercel-skills/skills/react-native-skills/`
- `vendor/vercel-skills/skills/react-view-transitions/`
- `vendor/vercel-skills/skills/web-design-guidelines/`
- `vendor/vercel-skills/skills/vercel-cli-with-tokens/`
- `vendor/vercel-skills/skills/deploy-to-vercel/`
- `vendor/ui-ux-pro-max/.claude/skills/ui-ux-pro-max/`
- `vendor/impeccable/.agents/skills/impeccable/`

Start with:
- `vendor/vercel-skills/skills/react-best-practices/SKILL.md`
- `vendor/vercel-skills/skills/react-best-practices/rules/`

Then branch as needed:
- use `composition-patterns` for component API and structure decisions
- use `react-view-transitions` for transition-specific UI work
- use `web-design-guidelines` for broader web UI quality guidance
- use `react-native-skills` only for React Native work
- use `deploy-to-vercel` or `vercel-cli-with-tokens` for Vercel deployment workflow questions
- use `ui-ux-pro-max` for broader UI/UX specialist guidance
- use `impeccable` for frontend-design craft, critique, polish, and anti-pattern guidance

## Working rule

Do not copy these framework-specific rules into the core workflow skills. Use the generated specialist skills when frontend work actually calls for deeper guidance.
