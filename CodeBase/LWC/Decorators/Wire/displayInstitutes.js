import { LightningElement, wire, track } from 'lwc';

// Apex Methods
import getInstitutes from '@salesforce/apex/InstituteController.getInstitutes';
import searchInstitutes from '@salesforce/apex/InstituteController.searchInstitutes';

export default class InstituteList extends LightningElement {

    // -----------------------------
    // Example 1: @wire without parameter
    // -----------------------------
    @wire(getInstitutes)
    institutes;

    // -----------------------------
    // Example 2: @wire with parameter
    // -----------------------------
    @track selectedIndustry = 'Consulting';

    @wire(searchInstitutes, { city: '$selectedIndustry' })
    filteredInstitutes;

    // Handle dropdown value change
    handleIndustryChange(event) {
        this.selectedIndustry = event.target.value;
    }

    // Picklist options
    industryOptions = [
        { label: 'Healthcare', value: 'Healthcare' },
        { label: 'Pharma', value: 'Pharma' },
        { label: 'Consulting', value: 'Consulting' },
        { label: 'Energy', value: 'Energy' }
    ];
}
