trigger AccountTrigger on Account (before insert) {

    //DMl is not required in before insert.
    //As such we can do a simple for loop with no need for list iteration or indexing.
    //Ids are not generted in before insert so we can access each record by its id in the future. Ids are generated in after insert.
    if(Trigger.isBefore && Trigger.isInsert)
    {
        //Invoke the apex class method
        //Refactoring : Logicless triggers : logic is moved into an Apex class
        AccountTriggerHandler.handleBeforeInsert(Trigger.New);
    }
}
