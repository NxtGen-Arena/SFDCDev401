trigger AccountTrigger on Account (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        AccountHandler.updateTotalOpportunityAmount(Trigger.newMap.keySet());
    }
}
