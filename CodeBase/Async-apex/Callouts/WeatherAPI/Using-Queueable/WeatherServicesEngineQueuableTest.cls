/**
 * @description Test class for WeatherServicesEngineQueuable
 * - Uses HttpCalloutMock to avoid real callouts
 * - No SeeAllData
 */
@IsTest
private class WeatherServicesEngineQueuableTest {

    // Simple HttpCalloutMock to return deterministic weather payload
    private class WeatherMock implements HttpCalloutMock {
        private Integer status;
        private String body;

        WeatherMock(Integer status, String body) {
            this.status = status;
            this.body = body;
        }

        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(status);
            res.setStatus(status == 200 ? 'OK' : 'ERROR');
            res.setBody(body);
            return res;
        }
    }

    // Sample 200 OK payload aligned with WeatherResponse class structure
    private static String sampleOkBody() {
        return '{"main":{"temp":298.55,"humidity":64},"weatherResponses":[{"main":"Clouds","description":"overcast clouds"}]}';
    }

    // Sample non-200 payload body
    private static String sampleErrorBody() {
        return '{"message":"error"}';
    }

    @IsTest
    static void test_directQueueable_success_updatesAccount() {
        // Arrange
        Account a = new Account(Name = 'Acme', BillingCity = 'Pune');
        insert a;

        Test.setMock(HttpCalloutMock.class, new WeatherMock(200, sampleOkBody()));

        // Act
        Test.startTest();
        System.enqueueJob(new WeatherServicesEngineQueuable(a.Id, a.BillingCity));
        Test.stopTest(); // executes the queueable

        // Assert
        Account refreshed = [SELECT Temperature__c, Humidity__c, Weather_Conditions__c FROM Account WHERE Id = :a.Id];
        System.assertNotEquals(null, refreshed.Temperature__c, 'Temperature__c should be set');
        System.assertNotEquals(null, refreshed.Humidity__c, 'Humidity__c should be set');
        System.assertEquals('Clouds', refreshed.Weather_Conditions__c, 'Weather_Conditions__c should be set from payload');
    }

    @IsTest
    static void test_trigger_enqueues_queueable_for_accounts_with_billing_city() {
        // Arrange: 3 accounts -> 2 with BillingCity, 1 without
        List<Account> accts = new List<Account>{
            new Account(Name = 'A1', BillingCity = 'Mumbai'),
            new Account(Name = 'A2', BillingCity = 'Bengaluru'),
            new Account(Name = 'A3') // no BillingCity, should not enqueue
        };
        insert accts;

        // Set mock to allow queueable callouts executed via trigger
        Test.setMock(HttpCalloutMock.class, new WeatherMock(200, sampleOkBody()));

        // Act: fire after update trigger (the trigger is defined on after update)
        for (Account a : accts) {
            a.Description = 'Touch to update';
        }

        Test.startTest();
        update accts; // should enqueue 2 jobs
        Test.stopTest();

        // Assert: both accounts with BillingCity should be updated
        Map<Id, Account> refreshed = new Map<Id, Account>([
            SELECT Id, Temperature__c, Humidity__c, Weather_Conditions__c
            FROM Account
            WHERE Id IN :new Map<Id, Account>(accts).keySet()
        ]);

        System.assertNotEquals(null, refreshed.get(accts[0].Id).Temperature__c, 'A1 temperature should be set');
        System.assertNotEquals(null, refreshed.get(accts[0].Id).Humidity__c, 'A1 humidity should be set');
        System.assertEquals('Clouds', refreshed.get(accts[0].Id).Weather_Conditions__c);

        System.assertNotEquals(null, refreshed.get(accts[1].Id).Temperature__c, 'A2 temperature should be set');
        System.assertNotEquals(null, refreshed.get(accts[1].Id).Humidity__c, 'A2 humidity should be set');
        System.assertEquals('Clouds', refreshed.get(accts[1].Id).Weather_Conditions__c);

        // A3 had no BillingCity; should remain nulls
        System.assertEquals(null, refreshed.get(accts[2].Id).Temperature__c, 'A3 temperature should remain null');
        System.assertEquals(null, refreshed.get(accts[2].Id).Humidity__c, 'A3 humidity should remain null');
        System.assertEquals(null, refreshed.get(accts[2].Id).Weather_Conditions__c, 'A3 conditions should remain null');
    }

    @IsTest
    static void test_queueable_handles_non200_by_throwing_and_failing_job_safely() {
        // Arrange
        Account a = new Account(Name = 'Err Co', BillingCity = 'Nowhere');
        insert a;

        // Mock a non-200 to force exception path
        Test.setMock(HttpCalloutMock.class, new WeatherMock(500, sampleErrorBody()));

        // Act + Assert
        // The exception thrown inside execute will surface during stopTest for queueable execution.
        Boolean threw = false;
        try {
            Test.startTest();
            System.enqueueJob(new WeatherServicesEngineQueuable(a.Id, a.BillingCity));
            Test.stopTest();
        } catch (Exception e) {
            threw = true;
            // Optional assertion on message fragment
            System.assert(e.getMessage().contains('Failed with status code 500') || e.getMessage() != null, 'Should throw for non-200');
        }
        System.assertEquals(true, threw, 'Queueable should throw on non-200 per implementation');
    }
}
