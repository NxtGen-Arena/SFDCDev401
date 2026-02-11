@isTest
public class Test_UpdateAccountIndustryBatch {
    @testSetup
    static void setup() {
        List<Account> accts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accts.add(new Account(Name='Test '+i));
        }
        insert accts;
    }

    static testMethod void testBatchRun() {
        Test.startTest();
        UpdateAccountIndustryBatch batch = new UpdateAccountIndustryBatch();
        Database.executeBatch(batch, 5);
        Test.stopTest();

        for (Account a : [SELECT Industry FROM Account WHERE Industry != null]) {
            System.assertEquals('Technology', a.Industry);
        }
    }
}
