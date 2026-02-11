/**
 * Class Name : AccountTriggerHandler
 * Purpose    : Business logic for Account trigger
 */
public class AccountTriggerHandler {

    /**
     * Sync Contact Phone with updated Account Phone
     *
     * @param newAccounts   List of updated Account records
     * @param oldAccountMap Old values of Account records
     */
    public static void syncContactPhone(
        List<Account> newAccounts,
        Map<Id, Account> oldAccountMap
    ) {

        // Store Account Ids where Phone has changed
        Set<Id> accountIdsToProcess = new Set<Id>();
        Map<Id, String> accountIdToNewPhone = new Map<Id, String>();

        for (Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);

            // Compare old vs new Phone (null-safe)
            if (acc.Phone != oldAcc.Phone) {
                accountIdsToProcess.add(acc.Id);
                accountIdToNewPhone.put(acc.Id, acc.Phone);
            }
        }

        // Exit if no Account phone changes
        if (accountIdsToProcess.isEmpty()) {
            return;
        }

        // Fetch related Contacts
        List<Contact> contactsToUpdate = [
            SELECT Id, Phone, AccountId
            FROM Contact
            WHERE AccountId IN :accountIdsToProcess
        ];

        // Update Contact Phone using NEW Account Phone
        for (Contact con : contactsToUpdate) {
            con.Phone = accountIdToNewPhone.get(con.AccountId);
        }

        // Single DML operation
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}
