public interface IPaymentProcessor {
    void validate();
    void processPayment();
    void updateBooking(Id bookingId);
}
