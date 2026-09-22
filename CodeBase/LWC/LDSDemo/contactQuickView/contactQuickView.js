/**
 * contactQuickView
 * -----------------
 * Demo 1: lightning-record-form — the zero-code entry point into LDS.
 * Drop this on a Contact record page. Layout, validation, Save button,
 * and error toasts are all handled by LDS with no Apex written.
 */
import { LightningElement, api } from 'lwc';

const FIELDS = [
    'Contact.FirstName',
    'Contact.LastName',
    'Contact.Email',
    'Contact.Phone'
];

export default class ContactQuickView extends LightningElement {
    @api recordId;
    @api objectApiName;

    fields = FIELDS;
}
