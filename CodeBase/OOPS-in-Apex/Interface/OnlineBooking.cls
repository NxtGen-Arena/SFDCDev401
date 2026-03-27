public class OnlineBooking implements IHotelRegistration {
    private Map<String, String> bookings = new Map<String, String>();
    
    public void registerGuest(String guestName, String roomType) {
        bookings.put(guestName, roomType);
        System.debug('Online Booking: Guest ' + guestName + ' registered for ' + roomType);
    }
    
    public Decimal calculatePrice(Integer nights) {
        return nights * 100; // Example: $100 per night
    }
    
    public void cancelBooking(String guestName) {
        if (bookings.containsKey(guestName)) {
            bookings.remove(guestName);
            System.debug('Online Booking: Booking canceled for ' + guestName);
        } else {
            System.debug('Online Booking: No booking found for ' + guestName);
        }
    }
    
    public String getBookingDetails(String guestName) {
        return bookings.containsKey(guestName) ? 'Online Booking details: ' + guestName + ' - ' + bookings.get(guestName) : 'No booking found for ' + guestName;
    }
}
