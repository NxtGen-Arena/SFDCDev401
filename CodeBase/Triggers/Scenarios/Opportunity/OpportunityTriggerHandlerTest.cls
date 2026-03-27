@IsTest
public class OpportunityTriggerHandlerTest {

    @IsTest
    static void testMinMaxDateCalculation() {

        // Create Account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Create Opportunities
        Opportunity opp1 = new Opportunity(
            Name = 'Opp 1',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10)
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Opp 2',
            AccountId = acc.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30)
        );

        insert new List<Opportunity>{ opp1, opp2 };

        // Verify Min & Max
        acc = [
            SELECT Min_Opportunity_Date__c, Max_Opportunity_Date__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(Date.today().addDays(10), acc.Min_Opportunity_Date__c);
        System.assertEquals(Date.today().addDays(30), acc.Max_Opportunity_Date__c);

        // Delete one Opportunity
        delete opp1;

        // Verify recalculation
        acc = [
            SELECT Min_Opportunity_Date__c, Max_Opportunity_Date__c
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(Date.today().addDays(30), acc.Min_Opportunity_Date__c);
        System.assertEquals(Date.today().addDays(30), acc.Max_Opportunity_Date__c);
    }
}
