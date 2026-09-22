# LWC Concepts Playground

Three components that together demonstrate lifecycle hooks, directives,
SLDS, base components, and slots — plus Jest tests showing how each
piece gets verified.

## What's in the bundle

```
force-app/main/default/lwc/
├── lifecycleLogger/          Logs every lifecycle hook as it fires
│   └── __tests__/lifecycleLogger.test.js
├── expandableSection/        Collapsible box — default + named slots
│   └── __tests__/expandableSection.test.js
└── demoPlayground/           Parent that composes the other two
    └── __tests__/demoPlayground.test.js
jest.config.js                 Standard sfdx-lwc-jest config
package.json                   Test scripts + the one dev dependency
```

## Deploy and run

```bash
sf project deploy start --source-dir force-app -o yourOrgAlias
```

Drop `demoPlayground` onto an App Page, Record Page, or Home Page in
Lightning App Builder — it's the only one of the three exposed there;
`lifecycleLogger` and `expandableSection` are children, used only
inside `demoPlayground`.

## Where each concept lives

| Concept | Where to point |
|---|---|
| **Lifecycle hooks** | `lifecycleLogger.js` — all four hooks, each with a comment on what it's for and when it fires |
| **Mount/unmount** | `demoPlayground.js` `toggleLogger()` + the `if:true={showLogger}` wrapper — this is what actually triggers `connectedCallback`/`disconnectedCallback` |
| **Directives** | `if:true`/`if:false` (all three components) and `for:each` (`lifecycleLogger.html`, listing the log entries) |
| **SLDS** | Utility classes throughout — `slds-box`, `slds-grid`, `slds-text-heading_small`, `slds-m-*` spacing tokens — no custom CSS file needed in any of the three components |
| **Base components** | `lightning-card`, `lightning-input`, `lightning-button`, `lightning-button-icon`, `lightning-icon` |
| **Slots** | `expandableSection.html` — one default `<slot></slot>` and one named `<slot name="actions">`, both filled in from `demoPlayground.html` |

## Suggested walkthrough order (~20–25 min)

1. **Lifecycle hooks first, in isolation.** Open `lifecycleLogger.js`
   alone before showing the parent. Read the four hooks in order —
   constructor, connectedCallback, renderedCallback,
   disconnectedCallback — and have trainees predict the firing order
   before you deploy and show the log.

2. **Mount/unmount = lifecycle in action.** Switch to `demoPlayground`
   in the org. Click "Unmount Lifecycle Logger" and ask the class what
   they'd expect to see — then open the browser console to show
   `disconnectedCallback()` actually logged. Click again to remount
   and watch the on-screen log rebuild from scratch (new instance, new
   `constructor()`).

3. **Directives.** Point at `for:each` building the log list and
   `if:true`/`if:false` switching between the log list and the empty
   state — this reinforces the directive slides from the foundations
   session with hooks as the data source instead of Apex.

4. **SLDS without custom CSS.** Open `expandableSection.html` and
   circle every `slds-*` class. Emphasize that none of these three
   components ship a `.css` file — SLDS utility classes and base
   components are carrying all the styling.

5. **Base components.** Point at `lightning-input`'s `onchange` using
   `event.detail.value` — contrast this with a raw `<input>`'s
   `event.target.value` from the earlier session, since trainees will
   mix these up constantly.

6. **Slots last.** Open `demoPlayground.html`'s
   `<c-expandable-section>` block. Trace the two `<p>` tags (no `slot`
   attribute → default slot) and the `<div slot="actions">` (named
   slot) into `expandableSection.html`'s two `<slot>` elements. Toggle
   the section open/closed to show slotted content isn't re-fetched or
   re-created — it's just shown/hidden by the parent's directive.

## Testing LWC — setup

```bash
npm install
```

(pulls in `@salesforce/sfdx-lwc-jest`, the Salesforce-maintained Jest
preset that knows how to compile `.html`/`.js` LWC bundles and stub
out base `lightning-*` components for testing.)

```bash
npm run test:unit            # run once
npm run test:unit:watch      # re-run on file change — good for live demo
npm run test:unit:coverage   # generate a coverage report
```

## What each test file teaches

- **`lifecycleLogger.test.js`** — asserts hooks actually fired by
  reading the rendered log list, and spies on `console.log` to catch
  `disconnectedCallback` after removal. Note: only `@api`-decorated
  members are visible from outside a component's shadow boundary —
  trying to read a plain internal property/getter from the test
  (`element.someInternalField`) fails with an LWC warning, by design.
- **`expandableSection.test.js`** — asserts the component's own slot
  contract (`<slot>` and `<slot name="actions">` exist in its shadow
  DOM), and simulates a button click to check `aria-expanded` toggles.
  Deliberately does **not** try to hand-build a `<p>` with
  `element.appendChild()` and check it got projected — LWC's Jest
  synthetic-shadow polyfill doesn't distribute manually-appended light
  DOM the way a real browser does, so that pattern produces a false
  failure. The real projection test lives in `demoPlayground.test.js`.
- **`demoPlayground.test.js`** — dispatches a `CustomEvent('change', {
  detail: { value: ... } })` to simulate `lightning-input`'s real event
  shape (not a plain DOM `input` event); verifies slotted content by
  querying the *nested* `c-expandable-section` after it's composed
  through `demoPlayground`'s own template (the properly supported way
  to test slot projection); and demonstrates mounting → unmounting →
  remounting a child component across two assertions.

## The one pattern that shows up in every test

LWC re-renders asynchronously. After anything that changes reactive
state (a click, a property set), wrap your assertion in:

```js
return Promise.resolve().then(() => {
    // assertions here see the DOM AFTER the re-render
});
```

Forgetting this is the single most common reason a new trainee's test
fails intermittently — worth a deliberate live demo of removing the
`Promise.resolve().then()` wrapper and watching a test fail.
