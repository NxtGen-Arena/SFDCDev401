/**
 * Class Name : AccountTriggerHandler
 * Purpose    : Business logic for Account trigger
 */
public class AccountTriggerHandler {

    /* ---------------------------------------------------------
     * Scenario 1: Sync Contact Phone on Account Phone change
     * ---------------------------------------------------------
     */
    public static void syncContactPhone(
        List<Account> newAccounts,
        Map<Id, Account> oldAccountMap
    ) {

        Set<Id> accountIdsToProcess = new Set<Id>();
        Map<Id, String> accountIdToNewPhone = new Map<Id, String>();

        for (Account acc : newAccounts) {
            if (acc.Phone != oldAccountMap.get(acc.Id).Phone) {
                accountIdsToProcess.add(acc.Id);
                accountIdToNewPhone.put(acc.Id, acc.Phone);
            }
        }

        if (accountIdsToProcess.isEmpty()) return;

        List<Contact> contactsToUpdate = [
            SELECT Id, AccountId
            FROM Contact
            WHERE AccountId IN :accountIdsToProcess
        ];

        for (Contact con : contactsToUpdate) {
            con.Phone = accountIdToNewPhone.get(con.AccountId);
        }

        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    /* ---------------------------------------------------------
     * Scenario 2: Prevent Account Deletion if Contacts Exist
     * ---------------------------------------------------------
     */
    public static void preventAccountDeletion(List<Account> accountsToDelete) {

        // Collect Account Ids being deleted
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : accountsToDelete) {
            accountIds.add(acc.Id);
        }

        // Query Contacts linked to these Accounts
        Map<Id, Integer> accountToContactCount = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) cnt
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accountToContactCount.put(
                (Id) ar.get('accId'),
                (Integer) ar.get('cnt')
            );
        }

        // Add error to Accounts having Contacts
        for (Account acc : accountsToDelete) {
            if (accountToContactCount.containsKey(acc.Id)) {
                acc.addError(
                    'Account with associated Contacts cannot be deleted.'
                );
            }
        }
    }
}
