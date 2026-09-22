/**
 * contactActions
 * ---------------
 * Demo 3: imperative LDS calls — updateRecord / deleteRecord — triggered
 * by a button click rather than component load. Also demonstrates
 * getRecordNotifyChange(), for the edge case where a record changes
 * outside LDS's own knowledge (e.g. an @AuraEnabled Apex DML) and the
 * cache needs to be told explicitly that it's stale.
 *
 * Place this on the same record page as contactQuickView and
 * contactPhoneBadge to show the cache-invalidation ripple across all
 * three components from a single click.
 */
import { LightningElement, api } from 'lwc';
import { updateRecord, deleteRecord, getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class ContactActions extends NavigationMixin(LightningElement) {
    @api recordId;

    handleUpdate() {
        const fields = {
            [ID_FIELD.fieldApiName]: this.recordId,
            [PHONE_FIELD.fieldApiName]: '9999999999'
        };

        updateRecord({ fields })
            .then(() => {
                this.toast('Success', 'Phone updated to 9999999999', 'success');
            })
            .catch((error) => {
                this.toast('Error updating record', this.reduceError(error), 'error');
            });
    }

    handleDelete() {
        deleteRecord(this.recordId)
            .then(() => {
                this.toast('Success', 'Contact deleted', 'success');
                // Navigate away since the record no longer exists.
                this[NavigationMixin.Navigate]({
                    type: 'standard__objectPage',
                    attributes: {
                        objectApiName: 'Contact',
                        actionName: 'list'
                    }
                });
            })
            .catch((error) => {
                this.toast('Error deleting record', this.reduceError(error), 'error');
            });
    }

    handleNotifyChange() {
        // Use when a record was changed OUTSIDE of LDS's own APIs
        // (e.g. a platform event, an Apex DML call from a separate
        // @AuraEnabled method) and the cache needs to be told to refetch.
        getRecordNotifyChange([{ recordId: this.recordId }]);
        this.toast('Cache invalidated', 'LDS notified — dependent wires will refetch', 'info');
    }

    toast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }

    reduceError(error) {
        if (error && error.body && error.body.message) {
            return error.body.message;
        }
        return 'Unknown error';
    }
}
