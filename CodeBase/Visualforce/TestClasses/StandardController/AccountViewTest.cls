@isTest
Public with sharing class AccountViewTest 
{
    @isTest
    static void testAccountPageController()
    {
        //Step 1: Create a test account record
        Account testAccount = new Account();
         testAccount.Name = 'TestAccont111';
         testAccount.Industry = 'Education';
         insert testAccount;
        System.debug('Account testAccount '+testAccount);

        //Step 2: Instantiate the standard controller with the account record
        ApexPages.StandardController sc = new ApexPages.StandardController(testAccount); // mimics how th equerystring paramter is passed to the controlller in case of stdcontroller

        //Step 3: Assert the Name of the account to ensure data is correctly passed
        //getRecord : returns the SObject instance currently in the controller
        SYstem.assertEquals('TestAccont111', ((Account)sc.getRecord()).Name);

        Test.startTest();
        //Step 4: simulate the page reference
        PageReference pageRef = Page.AccountView; // simulate the page navigation.
        pageRef.getParameters().put('id', testAccount.Id); //pssing paramaters as a querytring param to the vf page
        Test.setCurrentPageReference(pageRef); // treat this page as the curent request during test execution
        Test.stopTest();
    }
}
