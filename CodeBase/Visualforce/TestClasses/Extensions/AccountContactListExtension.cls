public class AccountContactListExtension {
    private final Account acc;
    public ApexPages.StandardSetController setCon { get; set; }

    public AccountContactListExtension(ApexPages.StandardController stdCtrl) {
        this.acc = (Account)stdCtrl.getRecord();

        // Query Contacts related to this Account
        List<Contact> allContacts = [SELECT Id, Name, Email, Reviewed__c FROM Contact WHERE AccountId = :acc.Id];

        setCon = new ApexPages.StandardSetController(allContacts);
        setCon.setPageSize(5);
    }

    public List<Contact> getContacts() {
        return (List<Contact>) setCon.getRecords();
    }

    public Boolean hasNext {
        get { return setCon.getHasNext(); }
    }

    public Boolean hasPrevious {
        get { return setCon.getHasPrevious(); }
    }

    public void next() {
        setCon.next();
    }

    public void previous() {
        setCon.previous();
    }

    public PageReference markAllReviewed() {
        List<Contact> currentContacts = getContacts();
        for (Contact c : currentContacts) {
            c.Reviewed__c = true;
        }
        update currentContacts;
        return null;
    }

    public Integer getPageNumber() {
        return setCon.getPageNumber();
    }
}
