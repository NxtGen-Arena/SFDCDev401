/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
    private class ContactTriggerHandlerTest {

    //Event - on insert of new contacts
    //scenario 1: Postivite test case - Insert new contact agains Account. 
    //Expected result: Contact should be inserted and no error should be thrown. ON Account, # of Active contacts should be incremented.
    @isTest //open up data access to recrods in Salesforce Org
    private static void runPositiveTestCases()
    {
        /**
         * In Test classes, to stimuate the test, this code is executing when new contact is inserted.
         * In order to insert Contact, we need Account record.
         * So, we need to create an Account first. Then create Contact against this Account
         * [KEY POINT] By Default existing orgs data isn't visible to test classes and methods. Hence we need to create locally the data for testing. 
         * This data is no commited in the database
         */
        //Insert new account record
        //This statement throws System.QueryException because We are retrieveing actual org data and not test data. 
        //Account accnt = [SELECT Id FROM Account LIMIT 1]; 

        Account accnt = new Account(Name = 'Apex Test Class Demo',Active__c = 'Yes');
        insert accnt;

        // Insert new contact record
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact1', AccountId = accnt.Id);
        insert con;
        accnt = [SELECT Id,No_Of_Active_Contacts__c FROM Account WHERE Id =: accnt.Id];
        //validate the output
        System.assert(accnt.No_Of_Active_Contacts__c > 0);

        // Insert new contact record
        List<Contact> contactsData = new List<Contact>();
         con = new Contact(FirstName = 'Test', LastName = 'Contact2', AccountId = accnt.Id);
        contactsData.add(con);
        // Insert new contact record
        con = new Contact(FirstName = 'Test', LastName = 'Contact3', AccountId = accnt.Id);
        contactsData.add(con);
        insert contactsData;

        accnt = [SELECT Id,No_Of_Active_Contacts__c FROM Account WHERE Id =: accnt.Id];

         //validate the output - expected vs actual
        System.assertEquals(3, accnt.No_Of_Active_Contacts__c);
        System.assertNotEquals(4, accnt.No_Of_Active_Contacts__c);
    }

    @isTest
    private static void runBulkTestCases()
    {
        // Insert new account record   
        Account accnt = new Account(Name = 'Apex Test Class Demo',Active__c = 'Yes');
        insert accnt;   
        List<Contact> contactsData = new List<Contact>();
        Contact con;    
        //create bulk test data
        //Salesforce internally divides data into chunks of 200 records. 
        //In this case, Salesforce batches 200 records and executes the code in batch.
        for(integer i = 0; i < 300 ; i++)
        {
            con = new Contact(FirstName = 'Test' + i, LastName = 'Contact1', AccountId = accnt.Id);
            contactsData.add(con);
        }
        insert contactsData;
        //Validate the output
        accnt = [SELECT Id,No_Of_Active_Contacts__c FROM Account WHERE Id =: accnt.Id];

        System.AssertEquals(300, accnt.No_Of_Active_Contacts__c);
    }

    private static testMethod void runNegativeTestCases()
    {
        /**
         * In Test classes, to stimuate the test, this code is executing when new contact is inserted.
         * In order to insert Contact, we need Account record.
         * So, we need to create an Account first. Then create Contact against this Account
         * [KEY POINT] By Default existing orgs data isn't visible to test classes and methods. Hence we need to create locally the data for testing. 
         * This data is no commited in the database
         */
        //Insert new account record
        //This statement throws System.QueryException because We are retrieveing actual org data and not test data. 
        //Account accnt = [SELECT Id FROM Account LIMIT 1]; 

        // Insert new contact record
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact1');
        insert con;
    }
}
