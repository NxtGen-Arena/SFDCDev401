trigger AccountTrigger on Account (after update) 
{
    //AccountServiceWS.addAccountDescription(trigger.new);
    
    for(Account acc : Trigger.new)
    {
        if(acc.BillingCity != null)
        {
            System.enqueueJob(new WeatherServicesEngineQueuable(acc.Id,acc.BillingCity));
        }
    }
}
