trigger BookingTrigger on Booking__c (after update) {
    for (Booking__c b : Trigger.new) {
        Booking__c oldB = Trigger.oldMap.get(b.Id);
        if (b.Status__c == 'Confirmed' && oldB.Status__c != 'Confirmed') {
            BookingPaymentFutureHandler.capturePayment(b.Id);
        }
    }
}
