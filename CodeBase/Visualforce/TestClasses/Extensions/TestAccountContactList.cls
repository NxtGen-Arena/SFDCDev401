@isTest
private class TestAccountContactList {
    
    @isTest
    static void testPaginationAndAction() {
        // Create an Account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create 12 Contacts (to test pagination: 5 per page)
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 1; i <= 12; i++) {
            contacts.add(new Contact(
                LastName = 'Contact ' + i,
                Email = 'test' + i + '@email.com',
                AccountId = acc.Id,
                Reviewed__c = false
            ));
        }
        insert contacts;

        // Simulate Visualforce context
        Test.startTest();
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(acc);
        AccountContactListExtension ext = new AccountContactListExtension(stdCtrl);

        // Check initial pagination
        List<Contact> page1 = ext.getContacts();
        System.assertEquals(5, page1.size());
        System.assertEquals(true, ext.hasNext);

        ext.next(); // Go to page 2
        List<Contact> page2 = ext.getContacts();
        System.assertEquals(5, page2.size());

        ext.next(); // Page 3
        List<Contact> page3 = ext.getContacts();
        System.assertEquals(2, page3.size());
        System.assertEquals(false, ext.hasNext);

        // Run action method to mark contacts as reviewed
        ext.markAllReviewed();

        // Verify update
        List<Contact> updatedContacts = [SELECT Reviewed__c FROM Contact WHERE AccountId = :acc.Id];
        for (Contact c : updatedContacts) {
            System.assertEquals(true, c.Reviewed__c, 'Contact should be marked as reviewed');
        }

        Test.stopTest();
    }
}
