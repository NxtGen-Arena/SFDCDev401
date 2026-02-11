/**
 * Trigger Name : AccountTrigger
 * Object       : Account
 * Event        : After Update
 * Purpose      : If Account Phone is updated, sync it to related Contacts
 */
trigger AccountTrigger on Account (after update) {

    // Call handler class method
    AccountTriggerHandler.syncContactPhone(
        Trigger.new,
        Trigger.oldMap
    );
}
