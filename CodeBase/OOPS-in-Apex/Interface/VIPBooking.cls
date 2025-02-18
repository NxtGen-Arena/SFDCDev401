public class VIPBooking implements IHotelRegistration {
    private Map<String, String> bookings = new Map<String, String>();
    
    public void registerGuest(String guestName, String roomType) {
        bookings.put(guestName, roomType);
        System.debug('VIP Booking: Guest ' + guestName + ' registered with VIP benefits for ' + roomType);
    }
    
    public Decimal calculatePrice(Integer nights) {
        return nights * 150; // VIP guests pay $150 per night with added perks
    }
    
    public void cancelBooking(String guestName) {
        if (bookings.containsKey(guestName)) {
            bookings.remove(guestName);
            System.debug('VIP Booking: Booking canceled for ' + guestName);
        } else {
            System.debug('VIP Booking: No booking found for ' + guestName);
        }
    }
    
    public String getBookingDetails(String guestName) {
        return bookings.containsKey(guestName) ? 'VIP Booking details: ' + guestName + ' - ' + bookings.get(guestName) : 'No booking found for ' + guestName;
    }
}
