/**
 * @description Tests for ContractExpirationEngineBatch
 */
@IsTest
private class ContractExpirationEngineBatchTest {

    /**
     * Minimal fields for User creation in tests.
     */
    private static User createUser(String aliasSeed) {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User u = new User(
            FirstName = 'Test',
            LastName = 'User' + aliasSeed,
            Alias = (aliasSeed.length() >= 8 ? aliasSeed.substring(0, 8) : aliasSeed).toLowerCase(),
            Email = 'user' + aliasSeed + '@example.com',
            Username = 'user' + aliasSeed + '@example.com.' + System.currentTimeMillis(),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = p.Id
        );
        return u;
    }

    @TestSetup
    static void setupData() {
        // Create two users to own accounts (ensures Owner.Email is populated)
        User u1 = createUser('aliasu1');
        User u2 = createUser('aliasu2');
        insert new List<User>{ u1, u2 };

        // Eligible accounts (Notification_Sent__c = false)
        List<Account> eligible = new List<Account>{
            new Account(Name = 'Eligible A', OwnerId = u1.Id, Notification_Sent__c = false),
            new Account(Name = 'Eligible B', OwnerId = u2.Id, Notification_Sent__c = false)
        };

        // Ineligible accounts (already notified)
        List<Account> ineligible = new List<Account>{
            new Account(Name = 'Ineligible A', OwnerId = u1.Id, Notification_Sent__c = true),
            new Account(Name = 'Ineligible B', OwnerId = u2.Id, Notification_Sent__c = true)
        };

        insert eligible;
        insert ineligible;
    }

    @IsTest
    static void test_Batch_ProcessesEligibleAccounts() {
        // Sanity: pre-conditions
        System.assertEquals(2, [SELECT Count() FROM Account WHERE Notification_Sent__c = false], 'Two eligible accounts expected pre-batch');
        System.assertEquals(2, [SELECT Count() FROM Account WHERE Notification_Sent__c = true], 'Two ineligible accounts expected pre-batch');

        Test.startTest();
        // Execute batch with a small scope to exercise execute loop
        Id jobId = Database.executeBatch(new ContractExpirationEngineBatch(), 1);
        Test.stopTest();

        // Eligible accounts should be updated to true
        List<Account> allAccts = [SELECT Id, Name, Notification_Sent__c FROM Account ORDER BY Name];
        Integer updatedCount = 0;
        for (Account a : allAccts) {
            if (a.Name.startsWith('Eligible')) {
                System.assertEquals(true, a.Notification_Sent__c, 'Eligible account should be flagged as notified');
                updatedCount++;
            } else if (a.Name.startsWith('Ineligible')) {
                System.assertEquals(true, a.Notification_Sent__c, 'Ineligible account should remain true');
            }
        }
        System.assertEquals(2, updatedCount, 'Two eligible accounts should have been processed');

        // Finish method writes a log row
        List<Error_Logger__c> logs = [
            SELECT Id, Classification__c, Process_Type__c, Process_Name__c, Log_Details__c
            FROM Error_Logger__c
            WHERE Process_Name__c = 'ContractExpirationEngineBatch'
            ORDER BY CreatedDate DESC
        ];
        System.assert(logs.size() >= 1, 'At least one log row should exist from finish');
        Error_Logger__c finishLog = logs[0];
        System.assertEquals('Log', finishLog.Classification__c, 'Finish should log with Classification=Log');
        System.assertEquals('BatchApex', finishLog.Process_Type__c, 'Process_Type should be BatchApex');
        System.assert(finishLog.Log_Details__c != null && finishLog.Log_Details__c.contains('Batch completed'), 'Finish log should contain completion message');

        // Ensure no error-classified rows for normal path
        Integer errorRows = [SELECT Count() FROM Error_Logger__c WHERE Process_Name__c = 'ContractExpirationEngineBatch' AND Classification__c = 'Error'];
        System.assertEquals(0, errorRows, 'No error logs expected on success');
    }

    @IsTest
    static void test_Batch_NoOp_WhenAllAlreadyNotified() {
        // Flip any remaining Notification_Sent__c to true so start() finds none
        List<Account> notNotified = [SELECT Id, Notification_Sent__c FROM Account WHERE Notification_Sent__c = false];
        for (Account a : notNotified) {
            a.Notification_Sent__c = true;
        }
        if (!notNotified.isEmpty()) {
            update notNotified;
        }

        System.assertEquals(0, [SELECT Count() FROM Account WHERE Notification_Sent__c = false], 'No eligible accounts left');

        Test.startTest();
        Id jobId = Database.executeBatch(new ContractExpirationEngineBatch(), 10);
        Test.stopTest();

        // No accounts should change back to false; remains all true
        Integer remainingFalse = [SELECT Count() FROM Account WHERE Notification_Sent__c = false];
        System.assertEquals(0, remainingFalse, 'Batch should be a no-op when no eligible accounts');

        // Finish still writes a completion log
        List<Error_Logger__c> logs = [
            SELECT Id, Classification__c, Process_Name__c, Log_Details__c
            FROM Error_Logger__c
            WHERE Process_Name__c = 'ContractExpirationEngineBatch'
            ORDER BY CreatedDate DESC
        ];
        System.assert(logs.size() >= 1, 'Finish should still insert a completion log even with no work');
        System.assertEquals('Log', logs[0].Classification__c, 'Classification should be Log');
    }
}
