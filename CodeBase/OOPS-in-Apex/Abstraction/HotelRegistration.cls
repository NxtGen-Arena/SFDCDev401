/**
*@Description: This abstract class defines the template for hotel registration.
* It includes both implemented and abstract methods (methods without a body must be implemented by subclasses).
**/
public abstract class HotelRegistration {
    public String hotelName;
    public String location;
    
    // Constructor
    public HotelRegistration(String hotelName, String location) {
        this.hotelName = hotelName;
        this.location = location;
    }

    // Abstract method (must be implemented in subclasses)
    public abstract void registerHotel();

    // Common method (Implemented here, used by subclasses)
    public void displayHotelDetails() {
        System.debug('Hotel Name: ' + hotelName);
        System.debug('Location: ' + location);
    }
}
