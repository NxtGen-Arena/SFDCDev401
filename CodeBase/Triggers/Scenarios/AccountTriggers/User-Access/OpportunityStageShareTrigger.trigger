trigger OpportunityStageShareTrigger on Opportunity (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        OpportunityShareHelper.shareOnClosedWon(
            Trigger.new,
            Trigger.oldMap
        );
    }
}
