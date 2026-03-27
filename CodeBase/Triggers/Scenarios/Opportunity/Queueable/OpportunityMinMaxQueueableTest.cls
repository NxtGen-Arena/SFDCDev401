@IsTest
public class OpportunityMinMaxQueueableTest {

    @IsTest
    static void testQueueableMinMaxDates() {

        // Create Account
        Account acc = new Account(Name = 'Queueable Test Account');
        insert acc;

        // Create Opportunities
        Opportunity opp1 = new Opportunity(
            Name = 'Opp 1',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(5)
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Opp 2',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(20)
        );

        Test.startTest();
        insert new List<Opportunity>{ opp1, opp2 };
        Test.stopTest(); // Ensures queueable runs

        // Verify Account dates
        acc = [
            SELECT Min_Opportunity_Date__c, Max_Opportunity_Date__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(Date.today().addDays(5), acc.Min_Opportunity_Date__c);
        System.assertEquals(Date.today().addDays(20), acc.Max_Opportunity_Date__c);

        // Delete one Opportunity
        Test.startTest();
        delete opp1;
        Test.stopTest();

        acc = [
            SELECT Min_Opportunity_Date__c, Max_Opportunity_Date__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(Date.today().addDays(20), acc.Min_Opportunity_Date__c);
        System.assertEquals(Date.today().addDays(20), acc.Max_Opportunity_Date__c);
    }
}
