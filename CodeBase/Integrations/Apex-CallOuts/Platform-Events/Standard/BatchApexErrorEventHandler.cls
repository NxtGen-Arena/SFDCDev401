public with sharing class BatchApexErrorEventHandler {
    private Map<Id, AsyncApexJob> jobMap;
    private Map<Id, ApexClass> classMap;

    public void onAfterInsert(List<BatchApexErrorEvent> newList){
        // Get Apex class name
        getClassInfo(newList);
        // Error handling
        errorHandler(newList);
    }

    private void getClassInfo(List<BatchApexErrorEvent> errorEventList){
        Set<Id> asyncApexJobIds = new Set<Id>();
        for(BatchApexErrorEvent evt : errorEventList){
            asyncApexJobIds.add(evt.AsyncApexJobId);
        }
        jobMap = new Map<Id, AsyncApexJob>([SELECT Id, ApexClassID FROM AsyncApexJob WHERE Id IN :asyncApexJobIds]);
        Set<Id> classIds = new Set<Id>();
        for(AsyncApexJob job : jobMap.values()){
            classIds.add(job.ApexClassID);
        }
        classMap = new Map<Id, ApexClass>([SELECT Id, Name FROM ApexClass WHERE Id IN :classIds]);
    }

    private void errorHandler(List<BatchApexErrorEvent> errorEventList) {
        // Perform arbitrary error handling
        // Batch error log list for insert
        List<ErrorLog__c> errLogList = new List<ErrorLog__c>();
        for (BatchApexErrorEvent errorEvent: errorEventList) {
            ErrorLog__c errLog = new ErrorLog__c();
            // Apex job ID
            errLog.AsyncApexJobId__c = errorEvent.AsyncApexJobId;
            // Apex class name
            errLog.ApexClassName__c = classMap.get(jobMap.get(errorEvent.AsyncApexJobId).ApexClassID).Name;
            // Exception species alias
            errLog.ExceptionType__c = errorEvent.ExceptionType;
            // Scope
            errLog.JobScope__c = errorEvent.JobScope;
            // Error message
            errLog.ErrMessage__c = errorEvent.Message;
            // Development phase
            errLog.Phase__c = errorEvent.Phase;
            // Replay ID
            errLog.ReplayId__c = errorEvent.ReplayId;
            // Stack trace
            errLog.StackTrace__c = errorEvent.StackTrace;
            // Store in list for insert
            errLogList.add(errLog);
        }
        // insert
        if (errLogList.size() > 0) {
            insert errLogList;
        }
    }
}
