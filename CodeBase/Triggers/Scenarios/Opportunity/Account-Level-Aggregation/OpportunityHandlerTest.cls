@IsTest
public class OpportunityHandlerTest {

    @TestSetup
    static void setupData() {
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Account A'),
            new Account(Name = 'Account B')
        };
        insert accounts;

        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(
                Name = 'Opp 1',
                StageName = 'Prospecting',
                CloseDate = Date.today(),
                Amount = 1000,
                AccountId = accounts[0].Id
            ),
            new Opportunity(
                Name = 'Opp 2',
                StageName = 'Prospecting',
                CloseDate = Date.today(),
                Amount = 2000,
                AccountId = accounts[0].Id
            )
        };
        insert opps;
    }

    // -------------------------------
    // INSERT Scenario
    // -------------------------------
    @IsTest
    static void testInsertOpportunity() {
        Account acc = [SELECT Id FROM Account WHERE Name = 'Account A' LIMIT 1];

        Test.startTest();
        Opportunity opp = new Opportunity(
            Name = 'Opp Insert',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 3000,
