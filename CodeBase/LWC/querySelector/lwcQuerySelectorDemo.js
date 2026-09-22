import { LightningElement } from 'lwc';

export default class LwcQuerySelectorDemo extends LightningElement {

    email = '';
    validationMessage = '';

    contacts = [
        { id: '1', name: 'Aarav Sharma', email: 'aarav@example.com' },
        { id: '2', name: 'Priya Nair', email: 'priya@example.com' },
        { id: '3', name: 'Rahul Verma', email: 'rahul@example.com' }
    ];

    handleEmailChange(event) {
        this.email = event.target.value;
    }

    // ------------------------------------------------------------------
    // renderedCallback fires every time the template (re)renders.
    // This is the ONLY safe lifecycle hook to call this.template.querySelector
    // in reliably -- connectedCallback runs BEFORE the template exists in
    // the DOM, so a querySelector call there will always return null.
    // ------------------------------------------------------------------
    renderedCallback() {
        // Example of a one-time DOM read after first render.
        // Guarded so it only logs once, since renderedCallback can re-fire.
        if (!this._loggedOnce) {
            const anyInput = this.template.querySelector('lightning-input');
            if (anyInput) {
                console.log('First lightning-input found on initial render:', anyInput);
            }
            this._loggedOnce = true;
        }
    }

    // 1. BASIC querySelector by tag -------------------------------------
    // Purpose: grab a single, unambiguous element and act on it directly.
    handleFocusEmail() {
        const emailInput = this.template.querySelector('lightning-input[type="email"]');
        if (emailInput) {
            emailInput.focus();
        }
    }

    // 2. Selecting by CLASS ----------------------------------------------
    // Purpose: pick out one of several same-tag elements using a CSS class.
    handleHighlightLastName() {
        const lastNameField = this.template.querySelector('.last-name-field');
        if (lastNameField) {
            lastNameField.focus();
            // toggling a class is a common companion pattern to visually flag a field
            lastNameField.classList.add('slds-has-error');
            setTimeout(() => lastNameField.classList.remove('slds-has-error'), 1500);
        }
    }

    // 3. Selecting by data-* attribute inside a for:each ------------------
    // Purpose: target exactly one row's element in a dynamically rendered list,
    // using the same data-id that was placed on the button that was clicked.
    handleFocusRow(event) {
        const rowId = event.target.dataset.id;
        const rowInput = this.template.querySelector(`lightning-input[data-id="${rowId}"]`);
        if (rowInput) {
            rowInput.focus();
        }
    }

    // 4. querySelectorAll — validate every matching field in one pass -----
    // Purpose: don't track each field manually; loop over all of them,
    // call checkValidity()/reportValidity() on each, and aggregate the result.
    handleValidateAll() {
        const inputs = this.template.querySelectorAll('.validated-input');
        let allValid = true;

        inputs.forEach((input) => {
            if (!input.checkValidity()) {
                input.reportValidity();
                allValid = false;
            }
        });

        this.validationMessage = allValid
            ? 'All fields are valid.'
            : 'Please fill in all required fields correctly.';
    }

    // 5. lwc:ref — modern, faster alternative to querySelector ------------
    // Purpose: for a single, statically known element, this.refs.<name>
    // avoids a DOM traversal and a string-based CSS selector entirely.
    handleFocusViaRef() {
        this.refs.refDemoInput.focus();
    }

    // 6. Parent calling a child's @api method ------------------------------
    // Purpose: querySelector here returns the CHILD COMPONENT's custom element
    // (c-child-focus-demo), not its shadow DOM internals. You can only call
    // methods the child explicitly exposes with @api -- shadow DOM boundaries
    // are respected either way.
    handleFocusChild() {
        const child = this.template.querySelector('c-child-focus-demo');
        if (child) {
            child.focusChildInput();
        }
    }
}
