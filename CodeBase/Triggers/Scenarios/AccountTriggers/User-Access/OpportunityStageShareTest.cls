@IsTest
public class OpportunityStageShareTest {

    @IsTest
    static void testShareOnClosedWon() {

        // 🔹 Create User-A
        Profile p = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'Standard User'
            LIMIT 1
        ];

        User userA = new User(
            Alias = 'usera',
            Email = 'usera@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'UserA',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            UserName = 'usera@company.com'
        );
        insert userA;

        // 🔹 Create Opportunity
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(10)
        );
        insert opp;

        // 🔹 Update stage to Closed Won
        Test.startTest();
        opp.StageName = 'Closed Won';
        update opp;
        Test.stopTest();

        // 🔹 Verify sharing
        List<OpportunityShare> shares = [
            SELECT Id, OpportunityAccessLevel
            FROM OpportunityShare
            WHERE OpportunityId = :opp.Id
            AND UserOrGroupId = :userA.Id
        ];

        System.assertEquals(1, shares.size(), 'Opportunity should be shared');
        System.assertEquals(
            'Read',
            shares[0].OpportunityAccessLevel,
            'Access level should be Read'
        );
    }
}
