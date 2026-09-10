public class BookingPaymentFutureHandler {

    @future(callout=true)
    public static void capturePayment(Id bookingId) {
        Booking__c booking = [
            SELECT Id, Amount__c, Guest_Email__c
            FROM Booking__c
            WHERE Id = :bookingId
        ];

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:StayEase_PaymentGateway/capture');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(new Map<String, Object>{
            'bookingId' => booking.Id,
            'amount'    => booking.Amount__c,
            'email'     => booking.Guest_Email__c
        }));

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            booking.Payment_Status__c = 'Captured';
        } else {
            booking.Payment_Status__c = 'Failed';
        }
        update booking;
    }
}
