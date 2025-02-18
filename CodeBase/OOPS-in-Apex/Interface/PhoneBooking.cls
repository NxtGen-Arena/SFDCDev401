public class PhoneBooking implements IHotelRegistration {
    private Map<String, String> bookings = new Map<String, String>();
    
    public void registerGuest(String guestName, String roomType) {
        bookings.put(guestName, roomType);
        System.debug('Phone Booking: Guest ' + guestName + ' registered for ' + roomType);
    }
    
    public Decimal calculatePrice(Integer nights) {
        return nights * 120; // Example: $120 per night for phone reservations
    }
    
    public void cancelBooking(String guestName) {
        if (bookings.containsKey(guestName)) {
            bookings.remove(guestName);
            System.debug('Phone Booking: Booking canceled for ' + guestName);
        } else {
            System.debug('Phone Booking: No booking found for ' + guestName);
        }
    }
    
    public String getBookingDetails(String guestName) {
        return bookings.containsKey(guestName) ? 'Phone Booking details: ' + guestName + ' - ' + bookings.get(guestName) : 'No booking found for ' + guestName;
    }
}
