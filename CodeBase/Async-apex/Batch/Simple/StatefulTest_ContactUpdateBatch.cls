@isTest
public class Test_ContactUpdateBatch {
    @testSetup
    static void setup() {
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            contacts.add(new Contact(LastName='Test '+i));
        }
        insert contacts;
    }

    static testMethod void testStatefulBatch() {
        Test.startTest();
        ContactUpdateBatch batch = new ContactUpdateBatch();
        Database.executeBatch(batch, 2);
        Test.stopTest();

        for (Contact c : [SELECT Email FROM Contact]) {
            System.assertEquals('default@example.com', c.Email);
        }
    }
}
