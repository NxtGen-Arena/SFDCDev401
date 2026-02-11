@IsTest
public class AccountTriggerHandlerTest {

    @IsTest
    static void testContactPhoneSync() {

        // Step 1: Create Account
        Account acc = new Account(
            Name = 'Test Account',
            Phone = '1111111111'
        );
        insert acc;

        // Step 2: Create related Contacts
        Contact con1 = new Contact(
            LastName = 'Test Contact 1',
            AccountId = acc.Id,
            Phone = '0000000000'
        );

        Contact con2 = new Contact(
            LastName = 'Test Contact 2',
            AccountId = acc.Id,
            Phone = '0000000000'
        );

        insert new List<Contact>{ con1, con2 };

        // Step 3: Update Account Phone
        acc.Phone = '9999999999';
        update acc;

        // Step 4: Verify Contacts updated
        List<Contact> updatedContacts = [
            SELECT Phone
            FROM Contact
            WHERE AccountId = :acc.Id
        ];

        for (Contact c : updatedContacts) {
            System.assertEquals(
                '9999999999',
                c.Phone,
                'Contact phone should match Account phone'
            );
        }
    }
}
