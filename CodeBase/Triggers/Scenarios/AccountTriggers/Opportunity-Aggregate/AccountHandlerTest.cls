@IsTest
public class AccountHandlerTest {

    @TestSetup
    static void setupData() {

        // Create Accounts
        List<Account> accounts = new List<Account>{
            new Account(Name = 'Test Account 1'),
            new Account(Name = 'Test Account 2')
        };
        insert accounts;

        // Create Opportunities for Account 1
        List<Opportunity> opps = new List<Opportunity>{
            new Opportunity(
                Name = 'Opp 1',
                StageName = 'Prospecting',
                CloseDate = Date.today(),
                Amount = 1000,
                Account
