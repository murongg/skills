# AI-assisted interaction work

Use when making a prototype, comparing motion alternatives, or reporting a defect to a coding agent. This workflow is tool-independent; old product comparisons and model names in the source articles are historical context.

## Give the work a grounded starting point

Adapted from [Figma Make 的使用建议与更多 AI 的思考](https://wxad.design/abc/figma-make):

- Supply the existing tokens, components, relevant code, and a small amount of reference material. Explain which details are constraints and which are inspiration.
- Establish the static composition before tuning motion. For an exploratory prototype, settle the visible interaction before adding unnecessary services; retain an existing application's data flow.
- Ask for a parameterized comparison when the intended feel is undecided. Use it to make a choice, then remove unused alternatives and temporary controls.

References help constrain implementation, but do not guarantee invention. Describe the interaction's intended effect and what should vary, rather than expecting examples alone to communicate a creative direction.

## Make feedback observable

[使用 AI 制作交互动画的建议](https://wxad.design/abc/interactive-design-in-ai) emphasizes recording, specific observations, and learning from the resulting implementation.

Use this compact defect report when useful:

```text
Element: the selected-tab indicator.
Action: select A, then select C before the first transition finishes.
Observed: the indicator jumps back toward A; content already shows C.
Expected: the indicator continues from its current position toward C.
Evidence: normal-speed reproduction and the frame range showing the jump.
```

Fix the earliest visible discontinuity and reproduce the same sequence again. Change one interacting cause at a time; inspect nearby behavior after each correction. Avoid piling another effect over an unresolved state or geometry problem.

## Compare, then exercise judgment

When choices are aesthetic, produce a small set of alternatives with a meaningful difference: response, direction, layering, or feedback strength. Do not build an exhaustive matrix or a permanent settings system.

Evaluate them in context. Does the user understand the result sooner? Does the effect compete with the content? Does the interface remain responsive? The [2025 annual-selection project](https://wxad.design/abc/making-fun-interfaces) documents abandoning expressive treatments that distracted from the message; a polished prototype can still be the wrong choice.

## Preserve the learning

The [UI quality essay](https://wxad.design/abc/quality-of-ui) connects craft to repeated refinement and a coherent experience. After a useful iteration, retain only the non-obvious decisions the next maintainer needs: the state invariant, the geometry constraint, the reason for a motion choice, or the observed regression.

Do not turn one successful parameter set into a universal recipe. Do not create a new skill, component abstraction, or project document for every experiment unless requested or justified by repeated use.

All blog links are attribution and optional deeper reading. These distilled instructions can be used without accessing the author's internal demos, conversation histories, or company systems.
