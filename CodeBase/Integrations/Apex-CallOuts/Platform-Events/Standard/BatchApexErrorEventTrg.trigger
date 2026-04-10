trigger BatchApexErrorEventTrg on BatchApexErrorEvent (after insert) {
    // Actual processing is executed in the trigger handler
    BatchApexErrorEventHandler triggerHandler = new BatchApexErrorEventHandler();
    triggerHandler.onAfterInsert(Trigger.new);
}
