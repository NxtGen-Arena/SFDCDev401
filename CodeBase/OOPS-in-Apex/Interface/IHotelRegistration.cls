public interface IHotelRegistration {
    void registerGuest(String guestName, String roomType);
    Decimal calculatePrice(Integer nights);
    void cancelBooking(String guestName);
    String getBookingDetails(String guestName);
}
