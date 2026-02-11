global class UpdateAccountIndustryBatch implements Database.Batchable<SObject> {

    // STEP 1: Start Method - Define the scope of records to be processed
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Query accounts with no Industry set
        return Database.getQueryLocator([
            SELECT Id, Name, Industry FROM Account WHERE Industry = null
        ]);
    }

    // STEP 2: Execute Method - Process each batch of records
    global void execute(Database.BatchableContext bc, List<Account> scope) {
        for (Account acc : scope) {
            acc.Industry = 'Technology';
        }
        // Update records in the database
        update scope;
    }

    // STEP 3: Finish Method - Run logic after all batches are processed
    global void finish(Database.BatchableContext bc) {
        // Example: Send email notification after batch completion
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { 'admin@example.com' });
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('The UpdateAccountIndustryBatch job has completed successfully.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
