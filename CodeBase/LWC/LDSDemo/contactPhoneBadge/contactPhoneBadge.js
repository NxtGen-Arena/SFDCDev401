/**
 * contactPhoneBadge
 * ------------------
 * Demo 2: the "aha" moment. Reads the SAME Contact record via the wire
 * adapter. Place this next to contactQuickView on the same record page.
 * Edit the phone number in the form and Save — this badge updates on
 * its own, with zero code connecting the two components. That's the
 * shared LDS client cache in action, not a coincidence.
 */
import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class ContactPhoneBadge extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [PHONE_FIELD] })
    contact;

    get phone() {
        return getFieldValue(this.contact.data, PHONE_FIELD) || '—';
    }
}
