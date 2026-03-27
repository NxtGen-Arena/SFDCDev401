public class BudgetHotel extends HotelRegistration {
    public BudgetHotel(String hotelName, String location) {
        super(hotelName, location);
    }

    // Implement abstract method
    public override void registerHotel() {
        System.debug(hotelName + ' is registered as a Budget Hotel.');
    }
}
