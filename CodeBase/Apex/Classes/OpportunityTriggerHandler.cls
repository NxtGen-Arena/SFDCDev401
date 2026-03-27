public with sharing class OpportunityTriggerHandler extends TriggerHandler
 {
    public OpportunityTriggerHandler() {
        this.setMaxLoopCount(1);
    }

    public override void beforeUpdate()
    {
       OpportunityHandler.validateOpportunityData(Trigger.new);
       
    }

    public override void afterUpdate(){
        List<Opportunity> opps = [SELECT ID FROM Opportunity WHERE ID IN :Trigger.newMap.keyset()];
        update opps;
    }
}
