/**
 * globalSearch
 * -------------
 * End-to-end demo combining:
 *  - genuine LDS (getObjectInfo from lightning/uiObjectInfoApi) for the
 *    selected object's plural label — reactive, cached, zero Apex
 *  - an Apex + SOSL search (SOSL isn't exposed through LDS itself)
 *  - client-side debounce on the search input
 *  - client-side pagination over the SOSL result set
 *  - NavigationMixin to open the selected record on row click
 *
 * Trainer talking point: point out which piece is LDS (object metadata)
 * and which piece needed Apex (the actual cross-field search) — this is
 * the "when do you still need Apex" contrast the whole demo builds to.
 */
import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import searchRecords from '@salesforce/apex/SoslSearchController.searchRecords';

const DEBOUNCE_DELAY = 300; // ms
const PAGE_SIZE = 10;

// Column + display config per searchable object. Must mirror the field
// list in SoslSearchController.OBJECT_FIELDS on the Apex side.
const OBJECT_CONFIG = {
    Account: {
        label: 'Accounts',
        columns: [
            { label: 'Name', fieldName: 'Name' },
            { label: 'Industry', fieldName: 'Industry' },
            { label: 'Phone', fieldName: 'Phone', type: 'phone' },
            { label: 'City', fieldName: 'BillingCity' }
        ]
    },
    Contact: {
        label: 'Contacts',
        columns: [
            { label: 'First Name', fieldName: 'FirstName' },
            { label: 'Last Name', fieldName: 'LastName' },
            { label: 'Email', fieldName: 'Email', type: 'email' },
            { label: 'Phone', fieldName: 'Phone', type: 'phone' },
            { label: 'Account', fieldName: 'AccountName' }
        ]
    },
    Lead: {
        label: 'Leads',
        columns: [
            { label: 'First Name', fieldName: 'FirstName' },
            { label: 'Last Name', fieldName: 'LastName' },
            { label: 'Company', fieldName: 'Company' },
            { label: 'Email', fieldName: 'Email', type: 'email' },
            { label: 'Status', fieldName: 'Status' }
        ]
    },
    Opportunity: {
        label: 'Opportunities',
        columns: [
            { label: 'Name', fieldName: 'Name' },
            { label: 'Stage', fieldName: 'StageName' },
            { label: 'Amount', fieldName: 'Amount', type: 'currency' },
            { label: 'Close Date', fieldName: 'CloseDate', type: 'date' }
        ]
    }
};

const ROW_ACTIONS = [{ label: 'View', name: 'view' }];

export default class GlobalSearch extends NavigationMixin(LightningElement) {

    selectedObject = 'Account';
    debouncedSearchTerm = '';
    lastSearchedTerm = '';
    currentPage = 1;
    isLoading = false;
    errorMessage;

    @track allRecords = [];

    delayTimeout;

    // ---- Genuine LDS: cached, reactive object metadata, no Apex ----
    @wire(getObjectInfo, { objectApiName: '$selectedObject' })
    objectInfo;

    get objectPluralLabel() {
        return this.objectInfo?.data?.labelPlural || OBJECT_CONFIG[this.selectedObject].label;
    }

    get searchLabel() {
        return `Search ${this.objectPluralLabel}`;
    }

    // ---- Apex + SOSL, wired reactively off the debounced term ----
    @wire(searchRecords, { searchTerm: '$debouncedSearchTerm', objectApiName: '$selectedObject' })
    wiredSearch({ data, error }) {
        this.isLoading = false;
        if (data) {
            this.errorMessage = undefined;
            this.allRecords = this.flattenRecords(data, this.selectedObject);
            this.lastSearchedTerm = this.debouncedSearchTerm;
        } else if (error) {
            this.errorMessage = error?.body?.message || 'Something went wrong running the search.';
            this.allRecords = [];
        }
    }

    // Contact.Account.Name comes back as a nested object from SOSL —
    // flatten it so lightning-datatable can bind AccountName directly.
    flattenRecords(records, objectApiName) {
        if (objectApiName === 'Contact') {
            return records.map((rec) => ({
                ...rec,
                AccountName: rec.Account ? rec.Account.Name : ''
            }));
        }
        return records;
    }

    // ---------------- Object picker ----------------
    get objectOptions() {
        return Object.keys(OBJECT_CONFIG).map((key) => ({
            label: OBJECT_CONFIG[key].label,
            value: key
        }));
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        this.allRecords = [];
        this.currentPage = 1;
        // Re-run the existing search term against the newly selected object.
    }

    // ---------------- Debounced search input ----------------
    handleSearchTermChange(event) {
        const value = event.target.value;
        window.clearTimeout(this.delayTimeout);
        this.isLoading = true;
        this.delayTimeout = setTimeout(() => {
            this.currentPage = 1;
            this.debouncedSearchTerm = value; // triggers the wire reactively
        }, DEBOUNCE_DELAY);
    }

    // ---------------- Columns ----------------
    get columns() {
        return [
            ...OBJECT_CONFIG[this.selectedObject].columns,
            { type: 'action', typeAttributes: { rowActions: ROW_ACTIONS } }
        ];
    }

    // ---------------- Pagination ----------------
    get totalRecords() {
        return this.allRecords.length;
    }

    get totalPages() {
        return Math.max(1, Math.ceil(this.totalRecords / PAGE_SIZE));
    }

    get pagedRecords() {
        const start = (this.currentPage - 1) * PAGE_SIZE;
        return this.allRecords.slice(start, start + PAGE_SIZE);
    }

    get rangeStart() {
        return this.totalRecords === 0 ? 0 : (this.currentPage - 1) * PAGE_SIZE + 1;
    }

    get rangeEnd() {
        return Math.min(this.currentPage * PAGE_SIZE, this.totalRecords);
    }

    get isFirstPage() {
        return this.currentPage <= 1;
    }

    get isLastPage() {
        return this.currentPage >= this.totalPages;
    }

    handlePrevious() {
        if (!this.isFirstPage) this.currentPage -= 1;
    }

    handleNext() {
        if (!this.isLastPage) this.currentPage += 1;
    }

    // ---------------- Display state ----------------
    get hasResults() {
        return this.totalRecords > 0;
    }

    get hasError() {
        return !!this.errorMessage;
    }

    get showNoResults() {
        return !this.isLoading && !this.hasError && this.lastSearchedTerm && this.lastSearchedTerm.length >= 2 && this.totalRecords === 0;
    }

    get showPrompt() {
        return !this.isLoading && !this.hasError && (!this.lastSearchedTerm || this.lastSearchedTerm.length < 2) && this.totalRecords === 0;
    }

    // ---------------- Row navigation ----------------
    handleRowAction(event) {
        const row = event.detail.row;
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: this.selectedObject,
                actionName: 'view'
            }
        });
    }
}
