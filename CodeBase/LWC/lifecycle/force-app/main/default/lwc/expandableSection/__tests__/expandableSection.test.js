import { createElement } from 'lwc';
import ExpandableSection from 'c/expandableSection';

describe('c-expandable-section', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('renders the title and starts open', () => {
        const element = createElement('c-expandable-section', {
            is: ExpandableSection
        });
        element.title = 'Test Section';
        document.body.appendChild(element);

        const heading = element.shadowRoot.querySelector('.slds-text-heading_small');
        expect(heading.textContent).toBe('Test Section');

        // isOpen starts true, so the wrapper around the default slot
        // should exist in the shadow DOM.
        expect(element.shadowRoot.querySelector('.slds-m-top_small')).not.toBeNull();
    });

    it('exposes a default slot and a named "actions" slot', () => {
        // Manually appendChild-ing light DOM content onto the element
        // under test does NOT reliably simulate slot projection in
        // LWC's Jest environment (its synthetic-shadow test polyfill
        // doesn't distribute hand-built nodes the way a real browser
        // would). The properly supported way to test that slotted
        // content actually renders is through a real parent component's
        // template — see demoPlayground.test.js for that. Here, we
        // confirm this component's side of the contract: both slot
        // outlets exist where expected.
        const element = createElement('c-expandable-section', {
            is: ExpandableSection
        });
        document.body.appendChild(element);

        const defaultSlot = element.shadowRoot.querySelector('slot:not([name])');
        const actionsSlot = element.shadowRoot.querySelector('slot[name="actions"]');
        expect(defaultSlot).not.toBeNull();
        expect(actionsSlot).not.toBeNull();
    });

    it('collapses the content wrapper when the header button is clicked', () => {
        const element = createElement('c-expandable-section', {
            is: ExpandableSection
        });
        document.body.appendChild(element);

        const toggleButton = element.shadowRoot.querySelector('button');
        toggleButton.click();

        return Promise.resolve().then(() => {
            expect(element.shadowRoot.querySelector('.slds-m-top_small')).toBeNull();
            expect(toggleButton.getAttribute('aria-expanded')).toBe('false');
        });
    });
});
