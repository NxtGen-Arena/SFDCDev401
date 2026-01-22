@isTest
public class UserTriggerMixedDMLTest {

    @isTest
    static void testTriggerBasedMixedDMLFix() {

        Profile p = [
            SELECT Id FROM Profile
            WHERE Name = 'Standard User'
            LIMIT 1
        ];

        User u = new User(
            Alias = 'train2',
            Email = 'trainer2@test.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Trainer',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            UserName = 'trainer' + System.currentTimeMillis() + '@test.com'
        );

        Test.startTest();
        insert u;   // Trigger fires
        Test.stopTest(); // @future executes

        // Assert Trainer Profile created
        Trainer_Profile__c profile = [
            SELECT Id FROM Trainer_Profile__c
            WHERE Trainer_User__c = :u.Id
            LIMIT 1
        ];
        System.assertNotEquals(null, profile);

        // Assert Permission Set assigned
        PermissionSetAssignment psa = [
            SELECT Id FROM PermissionSetAssignment
            WHERE AssigneeId = :u.Id
            LIMIT 1
        ];
        System.assertNotEquals(null, psa);
    }
}
