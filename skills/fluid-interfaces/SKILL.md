---
name: fluid-interfaces
description: Design, implement, or review interactive web UI for continuous feedback, interruptible transitions, gesture physics, and component motion. Use when interactions feel jumpy, sluggish, disconnected, or excessively animated. Not for static visual styling or prerecorded animation.
---

# Fluid Interfaces

Make an interaction understandable and controllable throughout its transition. Judge the response to the user's next action, not only the animation that plays when left alone.

This is an independent synthesis of Aragakey.'s [设计垂点](https://wxad.design/abc/), with engineering safeguards added for implementation. The linked articles provide context and examples; their project-specific choices are not universal rules.

## Load only the relevant detail

- For dragging, carousels, inertia, snapping, or simulated scrolling, read [gestures](references/gestures.md).
- For tabs, menus, overlays, feedback, or changing content, read [components](references/components.md).
- For AI-assisted prototyping, comparing alternatives, or describing motion defects, read [AI workflow](references/ai-workflow.md).

For ordinary visual styling, use the project's existing design guidance. Keep the current framework, component system, and motion library unless a demonstrated limitation requires a change.

For a review request, report findings against these criteria; edit only when the user asks for changes.

## Establish the purpose

Inspect the affected interaction and its existing states before changing motion. Identify the task, the input methods, and what the user should understand or feel at the transition's end.

Choose a concrete purpose: acknowledge an action, preserve orientation, explain a relationship, reveal a changed value, or add playfulness appropriate to this product. Remove motion that competes with the primary task. An operational dashboard and a campaign experience can justify different choices.

Quality includes a coherent experience, repeated refinement, and applying a useful idea consistently where it belongs. Improve the requested interaction first; do not expand a local change into a new component library. Background: [用户界面的品质](https://wxad.design/abc/quality-of-ui) and [制作有趣的界面](https://wxad.design/abc/making-fun-interfaces).

## Design the response before the curve

Describe the relevant start, active, settling, and final states. Include an interruption path: what happens if the user acts again before the transition ends?

- Give prompt feedback. Decorative animation must not introduce an artificial wait before a valid action can run.
- Retarget from the current visual state. Preserve velocity where the motion model supports it; avoid snapping back to an old start position.
- Keep visual direction, grouping, and depth compatible with the interaction they suggest.
- Keep application state authoritative. An obsolete animation callback must not overwrite the user's newer selection or reopen a closed surface.

For example, opening a card and closing it halfway through should return smoothly from its current position. Rapidly choosing a different tab should finish on that tab, including its content and focus behavior. These are acceptance examples, not reasons to add either feature.

The response model comes from [制作流畅界面](https://wxad.design/abc/making-fluid-interfaces); the callback and state-ownership requirements are implementation safeguards.

## Implement with the existing primitives

Use native controls, browser behavior, and installed components when they meet the experience goal. Inspect a component's extension points before replacing it. Change the mechanism only when the current one cannot express the required behavior; the source-first approach discussed in [关于 shadcn/ui 的思考与启发](https://wxad.design/abc/shadcn) is an option, not a stack mandate.

Treat motion as part of component behavior. Preserve its semantic role, keyboard operation, focus handling, and accessible state. Hover and drag can enrich an interaction, but cannot be the only way to complete an essential task.

Respect reduced motion in both CSS and JavaScript-driven animation. Remove or replace unnecessary spatial movement while preserving immediate state feedback. Functionality must not depend on an animation finishing. See [MDN: prefers-reduced-motion](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/At-rules/@media/prefers-reduced-motion).

## Verify the interaction

Scale checks to the affected behavior:

| Check | Evidence to seek |
| --- | --- |
| Ordinary use | The intended task completes and the state is clear. |
| Repeated or reversed input | The latest valid intent wins without jumps, stale content, or stuck controls. |
| Cancellation | Dismissal, lost input, or unmount leaves a valid state. |
| Supported inputs | Keyboard and pointer paths work; touch does not depend on hover. |
| Reduced motion | The same task and final state remain available. |
| Changed geometry | Relevant resizing, long content, and viewport edges do not break positioning. |
| Performance | Observe the actual transition in the target browser; profile if it stutters. |

For timing defects, inspect a slow recording as well as normal-speed use. A screenshot cannot establish continuity or responsiveness. Automate meaningful state and interruption checks when changing behavior, following the project's testing rules; avoid assertions tied to arbitrary durations or exact spring constants.

Report the changed behavior, the checks actually performed, and any untested browser or device. Do not claim native feel or performance from code inspection alone.
