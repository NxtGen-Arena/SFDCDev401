global class ContactUpdateBatchChained implements Database.Batchable<SObject>, Database.Stateful {

    global Integer updatedCount = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Email FROM Contact WHERE Email = null]);
    }

    global void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            c.Email = 'auto@domain.com';
            updatedCount++;
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Contacts updated: ' + updatedCount);

        // Chain to next batch job
        Database.executeBatch(new UpdateAccountIndustryBatch(), 100);
    }
}
