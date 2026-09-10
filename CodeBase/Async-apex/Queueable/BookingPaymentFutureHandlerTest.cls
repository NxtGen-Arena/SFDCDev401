@isTest
private class BookingPaymentFutureHandlerTest {

    @isTest
    static void testCapturePaymentSuccess() {
        Booking__c booking = new Booking__c(
            Status__c      = 'Pending',
            Amount__c      = 5000,
            Guest_Email__c = 'guest@stayease.com'
        );
        insert booking;

        Test.setMock(HttpCalloutMock.class, new PaymentGatewayMockSuccess());

        Test.startTest();
        booking.Status__c = 'Confirmed';
        update booking;
        Test.stopTest(); // future method executes here

        Booking__c updated = [SELECT Payment_Status__c FROM Booking__c WHERE Id = :booking.Id];
        System.assertEquals('Captured', updated.Payment_Status__c);
    }

    @isTest
    static void testCapturePaymentFailure() {
        Booking__c booking = new Booking__c(
            Status__c      = 'Pending',
            Amount__c      = 5000,
            Guest_Email__c = 'guest@stayease.com'
        );
        insert booking;

        Test.setMock(HttpCalloutMock.class, new PaymentGatewayMockFailure());

        Test.startTest();
        booking.Status__c = 'Confirmed';
        update booking;
        Test.stopTest();

        Booking__c updated = [SELECT Payment_Status__c FROM Booking__c WHERE Id = :booking.Id];
        System.assertEquals('Failed', updated.Payment_Status__c);
    }
}
