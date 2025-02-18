public class HotelRegistrationSystem {
    public static void processBooking(IHotelRegistration booking, String guestName, String roomType, Integer nights) {
        booking.registerGuest(guestName, roomType);
        Decimal price = booking.calculatePrice(nights);
        System.debug('Total Price for ' + guestName + ': $' + price);
    }
    
    public static void cancelGuestBooking(IHotelRegistration booking, String guestName) {
        booking.cancelBooking(guestName);
    }
    
    public static void fetchBookingDetails(IHotelRegistration booking, String guestName) {
        System.debug(booking.getBookingDetails(guestName));
    }
}
