trigger AccountBeforeInsert on Account (before insert,before update, after insert,after update, before delete, after delete, after undelete) {

    //DMl is not required in before insert.
    //As such we can do a simple for loop with no need for list iteration or indexing.
    //Ids are not generted in before insert so we can access each record by its id in the future. Ids are generated in after insert.
    if(Trigger.isBefore && Trigger.isInsert)
    {
        //loop through all the record which are part of this invokation
        for(Account accnt : Trigger.New)
        {
            //check if the industry is blank
            if(accnt.industry == null) 
            {
                accnt.Industry = 'Technology';

                //System.SObjectException: DML statement cannot operate on trigger.new or trigger.old
                //insert accnt;
            }
        }
    }

    if(Trigger.isBefore && Trigger.isUpdate)
    {
        //loop through all the record which are part of this invokation
        for(Account accnt : Trigger.New)
        {
            //check if the industry is blank
            if(accnt.industry == null) 
            {
                //add error method allows to display a custom error message for the record which triggered the event
                //prevents database transaction from happening, as well as allowing us to display the message in UI
                accnt.addError('Industry cannot be blank');  // adds error on record level in UI
                accnt.Industry.addError('Industry cannot be blank'); // adds error on field level in UI
            }
        }
    }

    if(Trigger.isBefore && trigger.isDelete)
    {
        //prevent deletion of any Account which has a related open opportunity record
        
        for(Account accnt : [SELECT Id FROM Account 
                            WHERE Id IN (SELECT AccountId FROM Opportunity WHERE StageName != 'Closed Won')
                                        AND Id IN :Trigger.old])
        {
            //AcountDeletion: Execution of Before Delete
            Trigger.oldMap.get(accnt.Id).addError('Cannot delete account with a related open opportunity');
        }
    }
}
