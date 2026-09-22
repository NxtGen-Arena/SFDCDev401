import { LightningElement, api, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactHandler.getContactsForAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactListImperative extends LightningElement {
    // Receives the Account Id when this component is placed on an Account Record Page
    @api recordId;

    // Stores the list of contacts to display
    @track contacts = [];

    // Stores error information if something goes wrong
    @track error;

    // Controls whether the loading spinner should be shown
    isLoading = false;

    // This method runs when user clicks "Load Contacts"
    handleLoadContacts() {
        this.isLoading = true; // Show spinner

        // Call the Apex method imperatively
        getContacts({ accountId: this.recordId })
            .then(result => {
                this.contacts = result; // Store contacts from result
                this.error = undefined; // Clear previous errors
                this.showToast('Success', 'Contacts loaded successfully', 'success');
            })
            .catch(error => {
                this.error = error; // Store error message
                this.contacts = []; // Clear previous contact data
                this.showToast('Error', error.body.message, 'error');
            })
            .finally(() => {
                this.isLoading = false; // Hide spinner
            });
    }

    // Utility method to show toast notifications to the user
    showToast(title, message, variant) {
        const event = new ShowToastEvent({ title, message, variant });
        this.dispatchEvent(event);
    }
}