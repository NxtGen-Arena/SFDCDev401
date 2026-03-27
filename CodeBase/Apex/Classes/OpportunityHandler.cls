public with sharing class OpportunityHandler 
{
    public class InvalidAmountException extends Exception {}

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

    public static Boolean setAmount(Id oppId,Decimal amount){
        Boolean updateSuccessful = null;
        try{
            Opportunity opp = [SELECT Amount FROM Opportunity WHERE Id =: oppId];
            if(amount > 0){
                opp.Amount = amount;
                update opp;
                updateSuccessful = true;
            } else if(amount == 0)
            {
                throw new InvalidAmountException('Amount cannot be 0');
            } else if(amount < 0)
            {
                throw new InvalidAmountException('Amount cannot be less than 0');
            }
        }catch(Exception ex){
            system.debug(('Exception occurred '+ex.getMessage() + ' for record'+ oppId));
            updateSuccessful = false;
        }
        return updateSuccessful;
    }
}
