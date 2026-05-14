@IsTest
private with sharing class UpdateContactAddressesTest {
  @TestSetup
  static void setup() {
    List<Account> accounts = new List<Account>();
    List<Contact> contacts = new List<Contact>();
    // insert 10 accounts
    for (Integer i = 0; i < 10; i++) {
      accounts.add(
        new Account(
          name = 'Account ' + i,
          billingcity = 'New York',
          billingcountry = 'USA'
        )
      );
    }
    insert as user accounts;
    // find the account just inserted. add contact for each
    for (Account account : [SELECT id FROM account WITH USER_MODE]) {
      contacts.add(
        new Contact(
          firstname = 'first',
          lastname = 'last',
          accountId = account.id
        )
      );
    }
    insert as user contacts;
  }
  @IsTest
  static void test() {
    Test.startTest();
    UpdateContactAddresses uca = new UpdateContactAddresses();
    Id batchId = Database.executeBatch(uca);
    Test.stopTest();
    // after the testing stops, assert records were updated properly
    Assert.areEqual(
      10,
      [
        SELECT COUNT()
        FROM contact
        WHERE MailingCity = 'New York'
        WITH USER_MODE
      ]
    );
  }
}
