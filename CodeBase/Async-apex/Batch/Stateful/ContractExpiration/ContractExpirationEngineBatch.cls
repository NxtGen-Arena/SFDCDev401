global class ContractExpirationEngineBatch implements Database.Batchable<sObject>,Database.stateful
{
    global Integer recordCount = 0;
    
    //define the scope for your batch
    //which records to be processed
	global Database.QueryLocator start(Database.BatchableContext batchContext)
    {
        return Database.getQueryLocator([
            						SELECT Id,RecordtypeId,Contract_Due_for_Expiration_in_Days__c,Notification_Sent__c,Owner.Email 
            						FROM Account
            						WHERE Notification_Sent__c = False
        ]);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope)
    {
        List<Messaging.SingleEmailMessage> lstEmails = new List<Messaging.SingleEmailMessage>();
		for(Account accnt : scope)
        {
            accnt.Notification_Sent__c = true;
            Messaging.SingleEmailMessage newEmail = new Messaging.SingleEmailMessage();
            newEmail.setToAddresses(new string[]{accnt.Owner.Email});
            newEmail.setSubject('Contract due for Expiry in next 7 days');
            newEmail.setPlainTextBody('Vendor contract is de tof renewal. pLease cotact for Account Manager.');
            lstEmails.add(newEmail);
            
            recordCount++;
        }
        
        List<Error_Logger__c> lstErrors = new List<Error_Logger__c>();
        try
        {
            Messaging.sendEmail(lstEmails);
            Database.saveresult[] updateAccountResults = Database.update(scope,false); //false = partial update
            
            for(Integer iIndex = 0; iIndex < updateAccountResults.size();iIndex++)
            {
                if(!updateAccountResults[iIndex].isSuccess())
                {
                    Error_Logger__c errorLog = new Error_Logger__c();
                    errorLog.Classification__c = 'Error';
                    errorLog.Process_Type__c = 'Batch Apex';
                    errorLog.Process_Name__c = 'ContractExpirationEngineBatch';
                    errorLog.Log_Details__c = 'Error occurred in JOb: '+ bc.getJobId() + '-'+ bc.getChildJobId()+ ' for record:: ' + updateAccountResults[iIndex].Id;
                    lstErrors.add(errorLog);
                }
            }
            if(!lstErrors.isEmpty())
            {
                insert lstErrors;
            }
        }
        catch(Exception ex)
        {
            Error_Logger__c errorLog = new Error_Logger__c();
            errorLog.Classification__c = 'Error';
            errorLog.Process_Type__c = 'Batch Apex';
            errorLog.Process_Name__c = 'ContractExpirationEngineBatch';
            errorLog.Log_Details__c = 'Error occurred:>> '+ ex.getMessage();
            insert errorLog;
        }
    }
    
    global void finish(Database.BatchableContext bc)
    {
		Error_Logger__c errorLog = new Error_Logger__c();
        errorLog.Classification__c = 'Log';
        errorLog.Process_Type__c = 'BatchApex';
        errorLog.Process_Name__c = 'ContractExpirationEngineBatch';
        errorLog.Log_Details__c = 'Batch completed for records '+ recordCount;
        insert errorLog;       
    }
}
