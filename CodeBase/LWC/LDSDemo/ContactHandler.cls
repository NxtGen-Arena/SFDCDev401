public with sharing class ContactHandler {

    /*
    Update the No_Of_Active_Contacts__c field on the Account with the number of related Contacts

    @param: newContactList - List of the new versions of the Contact records
    @param: oldContactList - List of the old versions of the Contact records
    @param: contactMap - Map of the old Contact records mapped by the Contact record Id
    @References: ContactTriggerHandlerTest.cls
    */

    public static void updateNoOfContacts(List<Contact> newContactList) {
        // Retrieve Id and No_of_Contacts__c field values of the Account records

        //map to store the Account Ids and their corresponding contact count
        Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();

        //Iterate throught the new contacts list to ppopulate the map
        for(Contact contactRecord : newContactList) 
        {
            //Increment the value of the Account Id to the map if the contact is associated with the Account
            if(contactRecord.AccountId != null) {
                //Check if the map contains the Account Id or not
                if(accountContactCountMap.containsKey(contactRecord.AccountId)) 
                {
                    //If the map contains the Account Id, increment the value by 1
                   /* Integer iCount = 0;
                    iCount = accountContactCountMap.get(contactRecord.AccountId);
                    icount += 1;
                    //put the new incremented value back against the key in the map
                    accountContactCountMap.put(contactRecord.AccountId, iCount);*/

                    accountContactCountMap.put(contactRecord.AccountId, accountContactCountMap.get(contactRecord.AccountId) + 1);
                } else {
                    //If the map doesn't contain the Account Id, put the Account Id as key and value as 1
                    accountContactCountMap.put(contactRecord.AccountId, 1);
                }
            }
        }

        //Query the existing accounts to retrieve the No_of_Contacts__c for each of the accounts in scope

        //Map to store the accounts Ids and the No_of_Contacts__c field value
        //Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, No_Of_Active_Contacts__c FROM Account WHERE Id IN :accountContactCountMap.keySet()]);

        //The Ids of the accounts to be updated are already populated and stored in the keys of accountContactCountMap
        //[BEST PRACTICE] Retrive only the fields you need for update.
        List<Account> accountsToUpdate = [SELECT Id, No_Of_Active_Contacts__c 
                                             FROM Account 
                                             WHERE Id IN :accountContactCountMap.keySet()];

        //Iterate through the accounts to update the No_Of_Active_Contacts__c field
        for(Account accountRecord : accountsToUpdate) {
            //update the No_Of_Active_Contacts__c field for each account
            //accountRecord.No_Of_Active_Contacts__c = accountRecord.No_Of_Active_Contacts__c + accountContactCountMap.get(accountRecord.Id);
            
            //ternary operator
            accountRecord.No_Of_Active_Contacts__c = (accountRecord.No_Of_Active_Contacts__c == null ? 0 : accountRecord.No_Of_Active_Contacts__c) + accountContactCountMap.get(accountRecord.Id);

            //[BAD CODE]DML statements should never be insied the for loop
            //update accountRecord; 
        }

        //perform the dml operation
        //[BEST PRACTICE] DML statements should never be insied the for loop
        if(!accountsToUpdate.isEmpty())
            update accountsToUpdate;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, Email FROM Contact];
    }

    @AuraEnabled(cacheable=false)
    public static List<Contact> getContactsForAccount(Id accountId) {
        if (String.isBlank(accountId)) {
            throw new AuraHandledException('Account Id is required');
        }

        return [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        system.debug('@this is the search key :: ' + searchKey);
        String key = '%' + searchKey + '%';
        try {
            system.debug('@this is the search key :: ' + searchKey);
            return [
                SELECT Id, Name, Phone
                FROM Account
                WHERE Name LIKE :key 
                LIMIT 10
            ];
        } catch(Exception ex) {
            System.debug(ex.getMessage() + ex.getLineNumber());
            return null;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String accountId) {
        return [
            SELECT Id, LastName, Title, Phone, Email
            FROM Contact
            WHERE AccountId = :accountId 
            LIMIT 10
        ];
    }
}