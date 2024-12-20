public with sharing class OpportunityHandler 
{
    public static void validateOpportunityData(List<Opportunity> newOpportunityList)
    {
        //handle only close lost opportunities
        for(Opportunity opp : newOpportunityList)
        {
            if(opp.StageName == 'Closed Lost')
            {
                //throw an error if no reason is provided
                if(opp.Lost_Reason__c == null)
                {
                    //add error on recod level
                   // opp.addError('Please provide a reason for closing the Opportunity');

                    //add error on field level
                    opp.Lost_Reason__c.addError('Please provide a reason for closing the Opportunity');
                }
                else if(opp.Lost_Reason__c == 'Lost to Competitor' && opp.MainCompetitors__c == null)
                {
                    opp.MainCompetitors__c.addError('Please provide a Main Competitor');
                }
            }
        }
    }
}
