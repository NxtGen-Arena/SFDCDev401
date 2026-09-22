import { createElement } from 'lwc';
import DemoPlayground from 'c/demoPlayground';

describe('c-demo-playground', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('updates the greeting when the name input changes', () => {
        const element = createElement('c-demo-playground', {
            is: DemoPlayground
        });
        document.body.appendChild(element);

        const input = element.shadowRoot.querySelector('lightning-input');
        // lightning-input (and other base components) report their value
        // through event.detail on a CustomEvent, not event.target.value
        // like a plain <input> — this mirrors what the real component
        // dispatches in the browser.
        input.dispatchEvent(
            new CustomEvent('change', { detail: { value: 'Sheetal' } })
        );

        return Promise.resolve().then(() => {
            const greeting = element.shadowRoot.querySelector('p');
            expect(greeting.textContent).toBe('Hello, Sheetal!');
        });
    });

    it('projects slotted content into the nested expandableSection', () => {
        // This is the properly supported way to test slot projection:
        // demoPlayground.html declares the slotted markup directly in
        // its own template (not via a hand-built DOM node), so the LWC
        // engine performs real slot distribution — exactly what happens
        // in the browser.
        const element = createElement('c-demo-playground', {
            is: DemoPlayground
        });
        document.body.appendChild(element);

        const section = element.shadowRoot.querySelector('c-expandable-section');
        // Default-slot content (the two <p> tags) lives in LIGHT DOM,
        // so we query the child component's host element directly,
        // not section.shadowRoot.
        const paragraphs = Array.from(section.querySelectorAll('p')).map(
            (p) => p.textContent
        );
        expect(paragraphs).toContain(
            'This paragraph is passed into the default slot.'
        );

        // Named-slot content (slot="actions") is also light DOM on the
        // child, found the same way.
        expect(section.querySelector('lightning-button-icon')).not.toBeNull();
    });

    it('unmounts and remounts the lifecycle logger via the toggle button', () => {
        const element = createElement('c-demo-playground', {
            is: DemoPlayground
        });
        document.body.appendChild(element);

        expect(element.shadowRoot.querySelector('c-lifecycle-logger')).not.toBeNull();

        const button = element.shadowRoot.querySelector('lightning-button');
        button.click();

        return Promise.resolve()
            .then(() => {
                // The if:true block removed it — child is gone entirely,
                // not just hidden.
                expect(element.shadowRoot.querySelector('c-lifecycle-logger')).toBeNull();
                button.click();
            })
            .then(() => {
                // Clicking again mounts a brand-new instance — its
                // lifecycle hooks fire again from constructor() onward.
                expect(element.shadowRoot.querySelector('c-lifecycle-logger')).not.toBeNull();
            });
    });
});
