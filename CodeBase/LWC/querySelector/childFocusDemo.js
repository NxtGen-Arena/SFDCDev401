import { LightningElement, api } from 'lwc';

export default class ChildFocusDemo extends LightningElement {

    // Exposed to the parent. This is the ONLY way a parent component
    // can trigger behavior inside this child's shadow DOM --
    // it cannot call this.template.querySelector('c-child-focus-demo input')
    // and reach the <lightning-input> directly; shadow DOM blocks that.
    @api
    focusChildInput() {
        // Using lwc:ref inside the child itself too -- same rules apply
        // locally: this.refs only sees this component's own template.
        this.refs.childInput.focus();
    }
}
