public class LuxuryHotel extends HotelRegistration {
    public LuxuryHotel(String hotelName, String location) {
        super(hotelName, location);
    }

    // Implement abstract method
    public override void registerHotel() {
        System.debug(hotelName + ' is registered as a Luxury Hotel.');
    }
}
