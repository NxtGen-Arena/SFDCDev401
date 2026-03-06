global class DeactivateContactsBatch implements Database.Batchable<sObject>, Database.Stateful
{
    global Integer updateCount = 0;
    
	//Step 1: start Method - Define the scope of the batch
	//Return types for Batch Start methd-  Database.QueryLocator or Iterable
	global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([
            							SELECT Id,Status__c FROM Contact WHERE Account.Active__c = 'No'
        								]);
    }
    
    //Step2: Execute - Process batch and perform operation
    global void execute(Database.BatchableContext bc, List<Contact> scope)
    {
        system.debug('Exceute batch ->>>>'+ Scope);
        for(Contact con : scope)
        {
            con.Status__c  = 'Inactive';
            updateCount++;
        }
        try
        {
        	//update scope; //allornone
            Database.saveResult[] updateContactResults = Database.update(scope,false); //partial update
            for(Integer iIndex = 0;iIndex <updateContactResults.size();iIndex++ )
            {
                if(!updateContactResults[iIndex].isSuccess())
                {
                    system.debug('Failed to update contact' + scope[iIndex].Id);
                }
            }
        }
        catch(Exception ex)
        {
            //Create new record in logger object
            Error_Logger__c logMessage = new Error_Logger__c();
            logMessage.Process_Type__c  = 'Batch Apex';
            logMessage.Process_Name__c = 'DeactivateContactsBatch';
            logMessage.Log_Details__c = 'Batch Failed ' + ex.getMessage();
            logMessage.Classification__c  = 'Exception';
            insert logMessage;
        }
    }
    
    //Step 3: FInish block - post processing
    global void finish(Database.BatchableContext bc)
    {
        //Send Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new string[]{'sheetu.chougule@gmail.com'});
        mail.setSubject('Batch for Contact Update Executed');
        mail.setPlainTextBody('Contacts are marked as inactive ');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
        
        //Create new record in logger object
        Error_Logger__c logMessage = new Error_Logger__c();
        logMessage.Process_Type__c  = 'Batch Apex';
        logMessage.Process_Name__c = 'DeactivateContactsBatch';
        logMessage.Log_Details__c = 'Batch Executed for # of records'+ updateCount;
        logMessage.Classification__c  = 'Log';
        insert logMessage;
        
        //Chain next batch job
        //Database.executeBatch(new opportunityUpdateBatch(), 100);
    }
}
