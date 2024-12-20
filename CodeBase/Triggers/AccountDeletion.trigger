trigger AccountDeletion on Account (before delete) {

    //prevent deletion of account is there are realated opportunity records
    for(Account accnt : [SELECT id FROM Account 
                         WHERE id 
                         IN (select accountId from Opportunity) and Id in :Trigger.old]){
        
       // AccountDeletion: execution of BeforeDelete
        //caused by: System.FinalException: SObject row does not allow errors
       // accnt.addError('Cannot delete account with related opportunities');

        Trigger.oldMap.get(accnt.id).addError('Cannot delete account with related opportunities');
    }
}
