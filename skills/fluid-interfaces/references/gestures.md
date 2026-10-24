# Gestures and physical response

Use for direct manipulation, momentum, snapping, and boundary behavior. Choose native scrolling first unless a concrete interaction requires control it cannot provide. The blog's [transform-based scrolling experiment](https://wxad.design/abc/scroll-mock) explains one such tradeoff; it does not establish a default replacement for browser scrolling. Recheck dated compatibility claims before using them to justify custom behavior.

## Separate the decisions

Following the questions in [转盘交互动画](https://wxad.design/abc/carousel), decide each part independently:

| Decision | What to tune or inspect |
| --- | --- |
| How movement follows the input | Displacement mapping and sensitivity. It should not require exaggerated dragging or feel detached. |
| Where movement ends after release | Measured release velocity, projection, bounds, and any snap target. Slow inspection and fast traversal may need different outcomes. |
| How movement settles | Decay for coasting; a spring where attraction to a target or a boundary is needed. |
| Whether to overshoot | Use only if it helps communicate arrival, resistance, or the product's intended character. |

Prefer the installed library's physics implementation. A fixed-duration tween can serve a fixed transition; it is a poor substitute for release dynamics across varying velocities and distances. The article's numerical settings belong to its carousel, not to every draggable UI.

## Preserve continuity

The relevant model is [Apple's Designing Fluid Interfaces](https://developer.apple.com/videos/play/wwdc2018/803/): input can arrive during movement, and motion should remain responsive.

- When a new drag starts during settling, stop the previous controller and begin from the displayed position, not its previous destination.
- On release, hand the measured velocity to the next phase when supported. Retain consistent units across position, time, and velocity.
- When a target changes, retarget the active motion rather than stacking independent animations on the same property.
- A spring need not visibly bounce. Adjust damping and stiffness together against the intended response.

Timely input can still look stepped. The [fluid-interface case study](https://wxad.design/abc/making-fluid-interfaces) uses a fast, non-bouncy spring to smooth a response. Consider that treatment for secondary movement only when it improves continuity without perceptible lag; direct manipulation still needs tight input coupling.

An infinite carousel has no physical end boundary. Any arrival bounce there is a feedback choice, not evidence of an edge. Test the reason for it separately from the spring implementation.

## Handle the input lifecycle

These are implementation safeguards rather than additional features:

- Use the existing gesture primitive; for custom Pointer Events, account for capture, `pointercancel`, and lost capture. Browser cancellation is not successful submission or intentional dismissal.
- Preserve page scrolling and zooming outside the gesture's needs. Configure touch behavior on the relevant surface; avoid a page-wide `touch-action: none` workaround.
- Distinguish a click from a completed drag so a release cannot accidentally activate the item beneath it.
- Stop pending animation work and release listeners when the surface disappears.

Reference: [MDN: Pointer events](https://developer.mozilla.org/en-US/docs/Web/API/Pointer_events).

## Evaluate physical feel

Compare slow drags, quick flicks, a new drag during inertia, reversal, and release near a snap threshold. A supported keyboard or button path must still reach the same content.

Add resistance only at real boundaries or where the metaphor explicitly calls for it. Resistance should grow with overshoot without creating an unreachable resting state. For a carousel embedded in a vertically scrolling page, also verify that the user can continue scrolling the page.

Use a temporary parameterized prototype if the desired feel is uncertain. Change one property at a time and compare on the target input device. Keep tuning controls out of the shipped product unless requested.
