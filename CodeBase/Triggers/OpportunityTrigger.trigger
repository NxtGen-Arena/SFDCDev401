trigger OpportunityTrigger on Opportunity (before update) {

    //invoking handler class to business execution
    if(Trigger.isBefore && Trigger.isUpdate)
        OpportunityHandler.validateOpportunityData(Trigger.new);

}
