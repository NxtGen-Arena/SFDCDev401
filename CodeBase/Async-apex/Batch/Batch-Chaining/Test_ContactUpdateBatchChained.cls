@isTest
public class Test_ContactUpdateBatchChained {
    @testSetup
    static void setup() {
        insert new Contact(LastName='Chain Contact');
        insert new Account(Name='Chain Account');
    }

    static testMethod void testChainedBatch() {
        Test.startTest();
        ContactUpdateBatchChained batch = new ContactUpdateBatchChained();
        Database.executeBatch(batch, 1);
        Test.stopTest();

        System.assertEquals(1, [SELECT COUNT() FROM Contact WHERE Email = 'auto@domain.com']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Industry = 'Technology']);
    }
}
