import { createElement } from 'lwc';
import LifecycleLogger from 'c/lifecycleLogger';

describe('c-lifecycle-logger', () => {
    afterEach(() => {
        // Jest's DOM doesn't reset itself between tests — remove
        // whatever we mounted so the next test starts clean.
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('logs constructor, connectedCallback and renderedCallback on mount', () => {
        const element = createElement('c-lifecycle-logger', {
            is: LifecycleLogger
        });
        document.body.appendChild(element);

        // LWC re-renders asynchronously (a microtask), so assertions
        // that depend on the DOM reflecting a change need to wait one
        // tick — returning a resolved Promise is the standard pattern.
        return Promise.resolve().then(() => {
            const hookNames = Array.from(
                element.shadowRoot.querySelectorAll('.slds-text-title_bold')
            ).map((el) => el.textContent);

            expect(hookNames).toContain('constructor()');
            expect(hookNames).toContain('connectedCallback()');
            expect(hookNames).toContain('renderedCallback()');
        });
    });

    it('calls disconnectedCallback when removed from the DOM', () => {
        const element = createElement('c-lifecycle-logger', {
            is: LifecycleLogger
        });
        // Spy on console.log since disconnectedCallback only logs there
        // (the component is already gone from the screen by then).
        const consoleSpy = jest.spyOn(console, 'log').mockImplementation();

        document.body.appendChild(element);
        document.body.removeChild(element);

        expect(consoleSpy).toHaveBeenCalledWith(
            expect.stringContaining('disconnectedCallback()')
        );
        consoleSpy.mockRestore();
    });
});
