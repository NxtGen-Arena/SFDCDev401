@IsTest
public class OpportunityMinMaxChainedQueueableTest {

    @IsTest
    static void testChainedQueueableExecution() {

        Account acc = new Account(Name = 'Chained Queue Test');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Opp',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today()
        );

        Test.startTest();
        insert opp;
        Test.stopTest(); // Ensures ALL chained queueables complete

        acc = [
            SELECT Min_Opportunity_Date__c, Max_Opportunity_Date__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(Date.today(), acc.Min_Opportunity_Date__c);
        System.assertEquals(Date.today(), acc.Max_Opportunity_Date__c);
    }
}
