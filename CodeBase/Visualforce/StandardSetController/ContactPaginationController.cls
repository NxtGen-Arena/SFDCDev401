public class ContactPaginationController {
    public ApexPages.StandardSetController setCon { get; set; }

    public List<Contact> getContacts() {
        return (List<Contact>)setCon.getRecords();
    }

    public ContactPaginationController() {
        List<Contact> allContacts = [SELECT Id, Name, Email FROM Contact ORDER BY Name ASC];
        setCon = new ApexPages.StandardSetController(allContacts);
        setCon.setPageSize(10);
    }

    public void next() {
        if(setCon.getHasNext()) setCon.next();
    }

    public void previous() {
        if(setCon.getHasPrevious()) setCon.previous();
    }
}
