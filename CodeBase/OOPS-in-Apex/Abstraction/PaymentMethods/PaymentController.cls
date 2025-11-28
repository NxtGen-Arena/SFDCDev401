public with sharing class PaymentController {
    
    public static void processBookingPayment(Booking__c booking, String paymentGatway)
    {
        PaymentProcessingEngine paymentEngine;
        //Service layer classes
        if(paymentGatway == 'Credit Card')
        {
            paymentEngine = new CrediCardPayment();
        }
        else if(paymentGatway == 'UPI')
        {
            paymentEngine = new UPIPaymentServices();
        }

        //call to concrete method from core engine
        paymentEngine.confirmBooking(booking);
    }
}
