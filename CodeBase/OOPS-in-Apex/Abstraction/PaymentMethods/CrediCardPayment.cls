public with sharing class CrediCardPayment extends PaymentProcessingEngine
{
    //Sub class provides implementation for abstract method
    public override void validatePayment(Booking__c booking)
    {
       //validate cc
        //check if cc numer is blank and expiry is not in past
        if(booking.Credit_Card_Number__c != null)
        {
            //process payment
            //call payment gateway
            //update booking status to paid
            booking.Payment_Status__c = 'Paid';
        }
    }
}
