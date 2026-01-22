/**
 * Trigger Name : UserAfterInsertTrigger
 * Purpose      : Detect new Trainer Users and delegate logic
 */
trigger UserAfterInsertTrigger on User (after insert) {

    // Avoid recursion / bulk-safe handling
    UserTriggerHandler.handleAfterInsert(Trigger.new);
}
