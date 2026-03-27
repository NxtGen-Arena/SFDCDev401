public class VoucherPayment implements IPaymentProcessor {

    public void validate() {
        System.debug('Checking voucher code validity and expiry...');
    }

    public void processPayment() {
        System.debug('Reducing corporate wallet balance...');
    }

    public void updateBooking(Id bookingId) {
        System.debug('Updating booking using Voucher…');
    }
}
