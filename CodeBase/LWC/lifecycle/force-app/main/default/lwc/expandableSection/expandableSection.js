import { LightningElement, api } from 'lwc';

/**
 * A reusable collapsible box that demonstrates two kinds of slots:
 *  - the DEFAULT slot   <slot></slot>            — unlabeled content
 *  - a NAMED slot       <slot name="actions">     — content the parent
 *                                                    explicitly targets
 * Whatever the parent puts inside <c-expandable-section>...</c-expandable-section>
 * is composed into these slots — this component never sees or owns
 * that markup, it only decides WHERE it renders.
 */
export default class ExpandableSection extends LightningElement {
    @api title = 'Section';
    isOpen = true;

    get sectionIconName() {
        return this.isOpen ? 'utility:chevrondown' : 'utility:chevronright';
    }

    get toggleAriaExpanded() {
        return this.isOpen ? 'true' : 'false';
    }

    toggleOpen() {
        this.isOpen = !this.isOpen;
    }
}
