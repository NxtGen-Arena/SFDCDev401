public with sharing class UPIPaymentServices 
{
     public void doPayment(Booking__c booking)
    {
        //validate cc
        //check if cc numer is blank and expiry is not in past
        if(!String.isBlank(booking.UPI_ID__c))
        {
            //process payment
            //call payment gateway
            //update booking status to paid
            booking.Payment_Status__c = 'Paid';
            booking.Booking_Status__c = 'Confirmed';
            update booking;
        }
    }    
}
