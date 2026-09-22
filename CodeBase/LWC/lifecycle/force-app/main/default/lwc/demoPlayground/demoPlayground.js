import { LightningElement } from 'lwc';

/**
 * The playground: everything else composes into this one page.
 *  - Toggling showLogger mounts/unmounts <c-lifecycle-logger>, which is
 *    what actually triggers connectedCallback/disconnectedCallback.
 *  - <c-expandable-section> is used with both a default slot (plain
 *    paragraphs) and a named "actions" slot (a button).
 *  - lightning-input and lightning-button are SLDS-styled base
 *    components — no custom CSS needed for either.
 */
export default class DemoPlayground extends LightningElement {
    showLogger = true;
    name = '';

    get greeting() {
        return this.name ? `Hello, ${this.name}!` : 'Type your name above.';
    }

    get toggleButtonLabel() {
        return this.showLogger ? 'Unmount Lifecycle Logger' : 'Mount Lifecycle Logger';
    }

    handleNameChange(event) {
        this.name = event.detail.value;
    }

    toggleLogger() {
        this.showLogger = !this.showLogger;
    }
}
