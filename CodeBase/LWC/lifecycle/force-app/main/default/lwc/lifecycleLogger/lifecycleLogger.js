import { LightningElement } from 'lwc';

/**
 * Demonstrates all four LWC lifecycle hooks by logging each one to a
 * visible list. Mount/unmount this component (see demoPlayground) to
 * see connectedCallback and disconnectedCallback fire.
 *
 * Order on mount: constructor() -> connectedCallback() -> render()
 * -> renderedCallback()
 */
export default class LifecycleLogger extends LightningElement {
    logs = [];
    nextId = 1;
    hasRenderedOnce = false;

    get hasLogs() {
        return this.logs.length > 0;
    }

    // Fires once, when the component instance is created — BEFORE it is
    // attached to the DOM. You do not have access to child elements,
    // @api properties set by the parent, or the DOM here yet.
    constructor() {
        super();
        this.addLog('constructor()', 'Component instance created.');
    }

    // Fires once, right after the element is inserted into the DOM.
    // The most common place for one-time setup: fire an imperative Apex
    // call, subscribe to a message channel, read initial @api values.
    connectedCallback() {
        this.addLog('connectedCallback()', 'Inserted into the DOM.');
    }

    // Fires after every render, including the first. It can run many
    // times over a component's life — keep it light, and guard against
    // work that would trigger another render (or you'll get a loop).
    renderedCallback() {
        if (!this.hasRenderedOnce) {
            this.hasRenderedOnce = true;
            this.addLog('renderedCallback()', 'First render complete.');
        }
    }

    // Fires once, right before the element is removed from the DOM.
    // Use it for cleanup: clear intervals/timeouts, remove listeners,
    // unsubscribe from message channels. By this point the component is
    // already gone from the screen, so it can only log to the console.
    disconnectedCallback() {
        // eslint-disable-next-line no-console
        console.log('[lifecycleLogger] disconnectedCallback() — removed from the DOM.');
    }

    // Fires if a lifecycle hook or an event handler in a CHILD component
    // throws an error. Lets a parent contain the failure instead of the
    // whole page breaking.
    errorCallback(error, stack) {
        this.addLog('errorCallback()', `Caught error: ${error.body?.message || error.message}`);
        // eslint-disable-next-line no-console
        console.error(stack);
    }

    addLog(hook, message) {
        this.logs = [...this.logs, { id: this.nextId++, hook, message }];
    }
}
