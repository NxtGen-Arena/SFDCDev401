public class CreditCardPayment implements IPaymentProcessor {

    public void validate() {
        System.debug('Validating credit card number, CVV, expiry date…');
    }

    public void processPayment() {
        System.debug('Calling VISA/MASTERCARD gateway API…');
    }

    public void updateBooking(Id bookingId) {
        System.debug('Updating booking status via Credit Card payment…');
    }
}
