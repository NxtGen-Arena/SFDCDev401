/**
*@Description: Demo for inherited sharing in apex classes
*@Invoked from: Account Trigger
*
**/
public without sharing class SecurityDemo {
    
    public static void enforceSharingRules(List<Account> lstAccounts) 
    {
        String strCount = InheritedSharingDemo.updateAccountAccessibleCount();
        for(Account acc : lstAccounts)
        {
            //check field level permission of Accounts Active__c field
            acc.Description = strCount;

            //check field level update permission of the Accounts Active field before updating it
            if(Schema.SObjectType.Account.fields.Active__c.isUpdateable()) //isCraeateable,isAccessible
                acc.Active__c = 'Yes';
          
            //Check object level permission for the Account object before deleting
            /*if(Schema.SObjectType.Account.isDeletable())
            {
                //not a good practice as this will exceed DML limits
                delete acc;
            }*/
        }
    }

     /**
     * Determines whether the code is running in system mode or user mode.
     */
    public static String getRunningContext() {
        return UserInfo.getUserType();
    }

    /**
     * Demonstrates how to enforce object and field-level security in SOQL queries.
     * Queries Account records only if the user has read access to the object and fields.
     */
    public static List<Account> getAccountsSecurely() {
        System.debug('Running Context: ' + getRunningContext());
        if (!Schema.sObjectType.Account.isAccessible()) {
            throw new SecurityException('Insufficient permissions to access Account records.');
        }
        
        return [SELECT Id, Name FROM Account WHERE Industry = 'Technology'];
    }

    /**
     * Demonstrates how to filter SOQL queries using WITH SECURITY_ENFORCED.
     * This ensures that only fields and records the user has access to are retrieved.
     */
    public static List<Account> getAccountsWithSecurityEnforced() {
        System.debug('Running Context: ' + getRunningContext());
        return [SELECT Id, Name FROM Account WHERE Industry = 'Technology' WITH SECURITY_ENFORCED];
    }

    /**
     * Demonstrates object and field-level security before performing DML.
     * Inserts a new Account record only if the user has create access.
     */
    public static void createAccountSecurely(String accName) {
        System.debug('Running Context: ' + getRunningContext());
        if (!Schema.sObjectType.Account.isCreateable()) {
            throw new SecurityException('Insufficient permissions to create Account records.');
        }
        
        Account acc = new Account(Name = accName);
        insert acc;
    }

    /**
     * Demonstrates field-level security by checking field accessibility before updating.
     */
    public static void updateAccountSecurely(Id accountId, String newName) {
        System.debug('Running Context: ' + getRunningContext());
        if (!Schema.sObjectType.Account.fields.Name.isUpdateable()) {
            throw new SecurityException('Insufficient permissions to update Account Name.');
        }
        
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId];
        acc.Name = newName;
        update acc;
    }

    /**
     * Demonstrates deletion security by verifying if the user has delete access to Account.
     */
    public static void deleteAccountSecurely(Id accountId) {
        System.debug('Running Context: ' + getRunningContext());
        if (!Schema.sObjectType.Account.isDeletable()) {
            throw new SecurityException('Insufficient permissions to delete Account records.');
        }
        
        Account acc = [SELECT Id FROM Account WHERE Id = :accountId];
        delete acc;
    }
}
