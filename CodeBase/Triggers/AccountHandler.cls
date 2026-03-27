public with sharing class AccountTriggerHandler 
{
    public static void handleBeforeInsert(List<Account> lstAccounts)
    {
        //Before insert
       /* for (Account accnt : (List<Account>)Trigger.new)
        {
            if(accnt.industry == null) 
            {
                accnt.Industry = 'Technology';
            }
        }*/

        for (Account accnt : lstAccounts)
        {
            if(accnt.industry == null) 
            {
                accnt.Industry = 'Technology';
            }
        }
    }
}
