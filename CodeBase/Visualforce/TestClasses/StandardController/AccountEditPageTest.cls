@isTest
private class AccountEditPageTest {

    @isTest
    static void testSaveAccount() {
        // 1. Data Setup
        Account testAccount = new Account(
            Name = 'Test Account for Edit',
            Phone = '123-456-7890',
            Industry = 'Technology',
            AnnualRevenue = 100000.00
        );
        insert testAccount;

        // 2. Simulate Page Context
        // Set the current page to the Visualforce page we're testing.
        PageReference pageRef = Page.AccountEditPage;
        pageRef.getParameters().put('id', testAccount.Id); // Pass the ID for edit mode
        Test.setCurrentPage(pageRef);

        // 3. Instantiate Standard Controller
        // Create an instance of the standard controller for the Account object.
        // The constructor takes the record instance.
        ApexPages.StandardController stdController = new ApexPages.StandardController(testAccount);

        // 4. Modify Record (mimicking user input)
        // Retrieve the Account record from the standard controller
        // and modify its fields as a user would.
        Account accountFromController = (Account)stdController.getRecord();
        accountFromController.Name = 'Updated Test Account Name';
        accountFromController.Phone = '987-654-3210';
        accountFromController.Industry = 'Healthcare';
        accountFromController.AnnualRevenue = 200000.00;

        // 5. Invoke Standard Controller Action (mimicking button click)
        // Use Test.startTest() and Test.stopTest() to ensure governor limits
        // are reset and asynchronous calls are processed.
        Test.startTest();
        PageReference resultPage = stdController.save();
        Test.stopTest();

        // 6. Assertions
        // Verify that the record was updated in the database.
        Account updatedAccount = [SELECT Name, Phone, Industry, AnnualRevenue FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Updated Test Account Name', updatedAccount.Name, 'Account name should be updated.');
        System.assertEquals('987-654-3210', updatedAccount.Phone, 'Account phone should be updated.');
        System.assertEquals('Healthcare', updatedAccount.Industry, 'Account industry should be updated.');
        System.assertEquals(200000.00, updatedAccount.AnnualRevenue, 'Account annual revenue should be updated.');

        // Verify that the save action returned the expected page (e.g., the view page).
        // For standard controllers, save typically redirects to the record's detail page.
        // The URL will look like /<recordId>/e.
        System.assert(resultPage != null, 'Save action should return a PageReference.');
        System.assertEquals('/' + updatedAccount.Id, resultPage.getUrl(), 'Save should redirect to the record detail page.');
    }

    @isTest
    static void testCancelAccount() {
        // 1. Data Setup
        Account testAccount = new Account(
            Name = 'Account for Cancel Test',
            Phone = '111-222-3333'
        );
        insert testAccount;

        // 2. Simulate Page Context
        PageReference pageRef = Page.AccountEditPage;
        pageRef.getParameters().put('id', testAccount.Id); // Pass the ID for edit mode
        Test.setCurrentPage(pageRef);

        // 3. Instantiate Standard Controller
        ApexPages.StandardController stdController = new ApexPages.StandardController(testAccount);

        // 4. Invoke Standard Controller Action (mimicking button click)
        Test.startTest();
        PageReference resultPage = stdController.cancel();
        Test.stopTest();

        // 5. Assertions
        // For standard controllers, cancel typically redirects to the record's detail page
        // without saving any changes.
        System.assert(resultPage != null, 'Cancel action should return a PageReference.');
        System.assertEquals('/' + testAccount.Id, resultPage.getUrl(), 'Cancel should redirect to the record detail page.');

        // Verify that the original record was NOT modified (if any changes were made before cancel)
        Account originalAccount = [SELECT Name, Phone FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals('Account for Cancel Test', originalAccount.Name, 'Account name should not be changed after cancel.');
        System.assertEquals('111-222-3333', originalAccount.Phone, 'Account phone should not be changed after cancel.');
    }
}
