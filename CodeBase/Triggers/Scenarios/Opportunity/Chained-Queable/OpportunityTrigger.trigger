trigger OpportunityTrigger on Opportunity (
    after insert,
    after update,
    after delete,
    after undelete
) {
    if (Trigger.isAfter) {

        Set<Id> accountIds = new Set<Id>();

        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
            for (Opportunity opp : Trigger.new) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        if (Trigger.isDelete) {
            for (Opportunity opp : Trigger.old) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
        }

        if (!accountIds.isEmpty()) {
            System.enqueueJob(
                new OpportunityMinMaxChainedQueueable(
                    new List<Id>(accountIds),
                    0
                )
            );
        }
    }
}
