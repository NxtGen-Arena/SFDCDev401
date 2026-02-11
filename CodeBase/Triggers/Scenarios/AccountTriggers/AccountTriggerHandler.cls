/**
 * Class Name : AccountTriggerHandler
 * Purpose    : Contains business logic for Account Trigger
 */
public class AccountTriggerHandler {

    /**
     * Sync Contact Phone with Account Phone
     *
     * @param newAccounts - List of updated Account records
     * @param oldAccountMap - Map of old Account records
     */
    public static void syncContactPhone(
        List<Account> newAccounts,
        Map<Id, Account> oldAccountMap
    ) {

        // Collect Account Ids where Phone has changed
        Set<Id> accountIdsWithPhoneChange = new Set<Id>();

        for (Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);

            // Check if Phone value is changed
            if (acc.Phone != oldAcc.Phone) {
                accountIdsWithPhoneChange.add(acc.Id);
            }
        }

        // Exit early if no relevant changes
        if (accountIdsWithPhoneChange.isEmpty()) {
            return;
        }

        // Query related Contacts
        List<Contact> contactsToUpdate = [
            SELECT Id, Phone, AccountId
            FROM Contact
            WHERE AccountId IN :accountIdsWithPhoneChange
        ];

        // Update Contact Phone to Account Phone
        for (Contact con : contactsToUpdate) {
            con.Phone = oldAccountMap.get(con.AccountId).Phone;
        }

        // Perform single DML operation
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}
