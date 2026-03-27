/**
 * Trigger Name : AccountTrigger
 * Object       : Account
 * Events       : After Update, Before Delete
 */
trigger AccountTrigger on Account (after update, before delete) {

    // Scenario 1: Sync Contact Phone when Account Phone changes
    if (Trigger.isAfter && Trigger.isUpdate) {
        AccountTriggerHandler.syncContactPhone(
            Trigger.new,
            Trigger.oldMap
        );
    }

    // Scenario 2: Prevent Account deletion if Contacts exist
    if (Trigger.isBefore && Trigger.isDelete) {
        AccountTriggerHandler.preventAccountDeletion(
            Trigger.old
        );
    }
}
