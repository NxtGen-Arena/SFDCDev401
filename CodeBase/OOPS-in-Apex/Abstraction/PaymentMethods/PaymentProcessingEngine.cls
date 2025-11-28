public abstract with sharing class PaymentProcessingEngine 
{
    //STep 1: Common mandaory validations - must be implemneted by sub-classes
    public abstract void validatePayment(Booking__c booking);

    //step 2: Mandatory payment processing - must be implemneted by sub-classes
    public abstract void processPayment(Booking__c booking); // definition of abstract method

    //ste 3:Templayte method - common to all sub-classes. Enforced for all.
    public void confirmBooking(Booking__c booking)
    {
        validatePayment(booking);
        processPayment(booking);

        if(booking.Payment_Status__c == 'Paid')
        {
            booking.Booking_Status__c = 'Confirmed';
            update booking;
        }
    }
}
