trigger OpportunityTrigger on Opportunity (
    after insert,
    after update,
    after delete,
    after undelete
) {
    if (Trigger.isAfter) {
        OpportunityHandler.updateAccountTotal(Trigger.new, Trigger.oldMap);
    }
}
