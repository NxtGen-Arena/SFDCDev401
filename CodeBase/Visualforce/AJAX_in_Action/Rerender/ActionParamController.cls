/**
 * Custom controller for understanding how to pass 
 * parameters to action methods
 * Updates a selected opportunity to closed -won based on a paramater passed to the controller.
 */
public with sharing class ActionParamController 
{
    //Id of the selected opportunity to mark closed-won
    public Id selectedOppId {get; set;}
    
    public ActionParamController() {

    }

    //Method to retrieve the opportunities
    public List<Opportunity> getOpps() 
    {
        return [SELECT Id,CaseSafe_Opp_Id__c, Name, CloseDate,Amount, StageName FROM Opportunity LIMIT 10];
    }

    //method to mark the selected opp as closed won
    public PageReference updateOpp() 
    {
        Opportunity opp = new Opportunity(Id=selectedOppId, StageName='Closed Won');
        update opp;

        return null; //post update stays on the same page
    }
}
