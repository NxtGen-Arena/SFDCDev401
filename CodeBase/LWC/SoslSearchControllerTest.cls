@isTest
private class SoslSearchControllerTest {

    @TestSetup
    static void setupData() {
        Account acc = new Account(Name = 'Zenith Traders', Industry = 'Retail', Phone = '1234567890');
        insert acc;

        Contact con = new Contact(FirstName = 'Zoya', LastName = 'Traders', Email = 'zoya@zenith.example', AccountId = acc.Id);
        insert con;

        Lead ld = new Lead(FirstName = 'Zubin', LastName = 'Traders', Company = 'Zenith Traders', Status = 'Open - Not Contacted');
        insert ld;

        Opportunity opp = new Opportunity(Name = 'Zenith Traders - Expansion', StageName = 'Prospecting', CloseDate = Date.today().addDays(30), AccountId = acc.Id);
        insert opp;

        // SOSL requires committed/indexed data; Test.setFixedSearchResults
        // is used in the actual search test below to make results deterministic.
    }

    @isTest
    static void testSearchAccountsReturnsFixedResult() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Test.setFixedSearchResults(new List<Id>{ acc.Id });

        Test.startTest();
        List<SObject> results = SoslSearchController.searchRecords('Zenith', 'Account');
        Test.stopTest();

        System.assertEquals(1, results.size(), 'Expected one Account back from the fixed search result.');
    }

    @isTest
    static void testBlankSearchTermReturnsEmptyList() {
        List<SObject> results = SoslSearchController.searchRecords('', 'Account');
        System.assertEquals(0, results.size(), 'Blank search term should short-circuit to an empty list.');
    }

    @isTest
    static void testTooShortSearchTermReturnsEmptyList() {
        List<SObject> results = SoslSearchController.searchRecords('a', 'Account');
        System.assertEquals(0, results.size(), 'A single character should not reach the SOSL query.');
    }

    @isTest
    static void testUnsupportedObjectThrows() {
        Boolean threw = false;
        try {
            SoslSearchController.searchRecords('Zenith', 'Case');
        } catch (AuraHandledException ex) {
            threw = true;
        }
        System.assertEquals(true, threw, 'An unsupported object should raise an AuraHandledException.');
    }

    @isTest
    static void testSanitizesReservedCharacters() {
        Test.setFixedSearchResults(new List<Id>());
        // Should not throw even with SOSL-reserved characters in the term.
        List<SObject> results = SoslSearchController.searchRecords('O\'Brien & Co?', 'Contact');
        System.assertNotEquals(null, results, 'Sanitized query should still execute without error.');
    }
}
