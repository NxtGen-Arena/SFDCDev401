/**
* Use Stnadard and custom controller using Extnesions. 
* Extensions can be multiple, while StnadardController and CustomController will be only one.
**/
public with sharing class AccountControllerExtension 
{
    Account accRecord;
    /**
     * Extension controller has reference to the main controller passed as an argument to constructor
     */
    public AccountControllerExtension(ApexPages.StandardController std) {

        //set an instance varibale to the account record we need to 
        //getrecord() - retrieves the ID from URL passed as paramater (apexPage/pageName?id={recordId})
        accRecord = (Account)std.getRecord();
    }

    /**
     * @Description: getter Property to retrieve the Child Opportunities for Account
     * Input Params : None
     * Returns: list of opportunities related to account
     */
    public List<Opportunity> getchildOpps()
    {
        return [SELECT Name,Amount,StageName,CloseDate,IsClosed,IsWon,OwnerId
                FROM Opportunity
                WHERE AccountId =: accRecord.Id
                and (IsWon = true Or IsClosed = false)];
    }

    private void createTaskOnOpportunities()
    {
        List<Task> tasksToInsert = new List<Task> ();

        for(Opportunity opp : getchildOpps())
        {
            if(!opp.IsClosed){
                tasksToInsert.add(
                    new Task(
                        WhatId = opp.Id,
                        OwnerId = opp.OwnerId,
                        ActivityDate = Date.today() + 3,
                        Status = 'Not Started',
                        Subject = 'Send Follo-up email to primary contact'
                    )
                );
            }
        }

        if(!tasksToInsert.isEmpty())
        {
            insert tasksToInsert;
        }
    }

    /**
     * @Description: By default, save button click invokes Save action for standardController
     * We need to invoke a new method to overried the save function implementing additional logic
     * Make sure to use the same name
     */
    public PageReference save()
    {
        if(accRecord.Rating == 'Hot')
        {
            createTaskOnOpportunities();
        }
        update accRecord;
        return new PageReference('/'+accRecord.Id);
    }
}
