/**
@Description: Count total number of Contacts updated
**/
global class ContactUpdateBatch implements Database.Batchable<SObject>, Database.Stateful {

    // Maintain state across batches
    global Integer totalUpdated = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Email FROM Contact WHERE Email = null
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            c.Email = 'default@example.com';
            totalUpdated++;
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('✅ Total Contacts Updated: ' + totalUpdated);
    }
}
