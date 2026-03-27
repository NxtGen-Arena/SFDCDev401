public class UpiPayment implements IPaymentProcessor {

    public void validate() {
        System.debug('Validating UPI ID format...');
    }

    public void processPayment() {
        System.debug('Invoking UPI Intent / Gateway...');
    }

    public void updateBooking(Id bookingId) {
        System.debug('Updating booking for UPI payment…');
    }
}
