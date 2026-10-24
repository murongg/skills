# Component motion and spatial continuity

Use the patterns that explain the current interaction. Do not add every pattern to every component.

## Shared surfaces

The [跳跃 / Springen experiments](https://wxad.design/abc/springen) extend a small idea across related controls: neighboring items can share a moving highlight, and related popovers can share a surface. This can make a group feel continuous and reduce competing layers.

Apply it when the controls actually belong together. Keep persistent selection distinct from transient hover. Leaving the group should not erase the selected state, and moving between triggers should not repeatedly tear down and recreate the whole panel.

For card-to-dialog or popover-to-dialog morphs, preserve visual identity. Reusing the container is one approach discussed in [使用 AI 制作交互动画的建议](https://wxad.design/abc/interactive-design-in-ai). Shared-layout transitions or coordinated layers may fit the existing architecture better. Whichever approach is used, maintain dialog semantics and focus management; one DOM node is not a universal requirement.

When moving from an in-flow card to a fixed overlay, resolve source and destination geometry in compatible coordinates. Changing the mounting location must not introduce a visible position reset.

## Floating content

The [发芽 / Spross experiments](https://wxad.design/abc/spross) focus on practical overlay behavior: follow the anchor during nested scrolling, flip or shift near edges, and adapt to available space.

Use the positioning system already provided by the component library. Check scrolling ancestors, anchor movement, viewport changes, and long content. Constrain height and provide accessible overflow when necessary. Do not adopt automatic dialog scaling as a default: readability, zoom, and layout must still work.

For stacked dialogs or drawers, retain a readable hierarchy and the existing focus, dismissal, and scroll-lock behavior. Layer animation does not justify introducing nested dialogs into a flow that does not need them.

## Feedback should explain state

Adapt the relevant examples from [Functional Motion](https://wxad.design/abc/functional-motion):

- A stacked message group can unfold when inspected, making the pause in dismissal perceptible. Keep important messages and actions reachable by keyboard as well as pointer.
- Range-slider labels can combine when they would collide, while retaining the complete value range.
- Press feedback can reflect sustained interaction, while a quick click remains direct. Do not delay the action merely to display the feedback.

Do not copy the example timings or exit directions as global tokens. Confirmation and cancellation can use distinct motion only when the surrounding product supports that meaning.

## Choreography and depth

[交互动画的层级设计](https://wxad.design/abc/designing-depth) connects layering and sequencing to the relationships people infer from the interface.

- For overlapping cards, arrange the movement so their apparent depth remains believable instead of having solid surfaces pass through each other.
- For inserted or removed list items, consider separately when space changes and when content becomes visible. Avoid briefly showing content over its neighbors.
- Use parallax and stagger only when they express useful grouping or depth. Repeated independent delays can make routine work feel slower.
- Blur can suggest a background layer, but does not itself make that layer non-interactive. Preserve actual interaction and accessibility behavior independently.

## Performance belongs to the design

The [AD UI project review](https://wxad.design/abc/adui) treats design, component behavior, engineering efficiency, and workflow as connected concerns. Its bundle optimizations are project results, not promises for another application.

For motion work, inspect repeated measurement, rerendering during gestures, offscreen work, and expensive effects before adding complexity. Use transforms and opacity where they express the intended change; do not force a layout change into a transform if it distorts content or hit targets. Measure the affected path before claiming an improvement.
