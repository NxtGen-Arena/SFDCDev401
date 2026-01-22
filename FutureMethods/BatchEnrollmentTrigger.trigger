trigger BatchEnrollmentTrigger on Batch_Enrollment__c (after insert) {

    Set<Id> enrollmentIds = new Set<Id>();

    for (Batch_Enrollment__c be : Trigger.new) {
        enrollmentIds.add(be.Id);
    }

    EnrollmentFutureHandler.sendNotifications(enrollmentIds);
}
