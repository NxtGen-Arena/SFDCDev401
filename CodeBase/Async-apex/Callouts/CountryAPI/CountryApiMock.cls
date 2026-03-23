public class CountryApiMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('[{"name":{"common":"India"}}]');
        return res;
    }
}

@isTest
private class Test_CountryAPICalloutBatch {
    @testSetup
    static void setup() {
        insert new Country__c(AlphaCode__c = 'IN');
    }

    static testMethod void testBatch() {
        Test.setMock(HttpCalloutMock.class, new CountryApiMock());

        Test.startTest();
        Database.executeBatch(new CountryAPICalloutBatch(), 1);
        Test.stopTest();

        Country__c c = [SELECT CountryName__c FROM Country__c WHERE AlphaCode__c = 'IN'];
        System.assertEquals('India', c.CountryName__c);
    }
}
