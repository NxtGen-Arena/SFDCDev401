trigger contactTrigger on Contact (after insert) {

    //call the apex class to handle the logic
    if(Trigger.isAfter && Trigger.isInsert)
    {
        //Trigger logic should be separated from business logic to decouple and make the code more reusable and scalable
        //Trigger.new containts list of contacts being inserted
        ContactTriggerHandler.updateNoOfContacts(Trigger.new);
    }
}
