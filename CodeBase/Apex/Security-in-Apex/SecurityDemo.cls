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
}
