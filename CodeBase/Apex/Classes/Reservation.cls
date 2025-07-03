/**
*@Description: All the functionality related to Hotel Reservation System.
*@Author: Sheetal Chougule
*@Version: 1.0
**/
public class HotelReservation {
    // Private member variables encapsulation
    private String guestName;
    private Integer roomNumber;
    private Date checkInDate;
    private Date checkOutDate;
    private Decimal totalCost;
    
    // Static variable to keep track of total reservations (Demonstrates Static keyword)
    private static Integer totalReservations = 0;
    
    // Constructor to initialize reservation details
    public HotelReservation(String guestName, Integer roomNumber, Date checkInDate, Date checkOutDate, Decimal totalCost) {
        this.guestName = guestName;
        this.roomNumber = roomNumber;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.totalCost = totalCost;
        totalReservations++; // Increment total reservations count
    }
    
    // Public method to get reservation details (Encapsulation)
    public String getReservationDetails() {
        return 'Guest: ' + guestName + ', Room: ' + roomNumber + ', Check-in: ' + checkInDate + ', Check-out: ' + checkOutDate + ', Cost: $' + totalCost;
    }
    
    // Public method to modify check-out date and recalculate cost (Demonstrates Abstraction)
    public void modifyReservation(Date newCheckOutDate, Decimal newCost) {
        this.checkOutDate = newCheckOutDate;
        this.totalCost = newCost;
    }
    
    // Static method to get total reservations (Demonstrates Static method usage)
    public static Integer getTotalReservations() {
        return totalReservations;
    }
    
    // Method Overloading Example (Polymorphism) - Different ways to cancel reservation
    public void cancelReservation() {
        this.guestName = null;
        this.roomNumber = null;
        this.checkInDate = null;
        this.checkOutDate = null;
        this.totalCost = null;
        totalReservations--;
    }

    /**
    *@Description: Method for cancelling reservation
    *@Params: Reason for cancellation
    *@Returns: void
    **/
    public void cancelReservation(String reason) {
        cancelReservation(); // Call the original method
        System.debug('Reservation canceled due to: ' + reason);
    }
    
    // Demonstrating Inheritance
    public virtual void displayMessage() {
        System.debug('Thank you for choosing our hotel!');
    }
}

// Child class demonstrating Inheritance and Method Overriding
public class VIPReservation extends HotelReservation {
    private String vipBenefits;
    
    // Constructor using Super keyword
    public VIPReservation(String guestName, Integer roomNumber, Date checkInDate, Date checkOutDate, Decimal totalCost, String vipBenefits) {
        super(guestName, roomNumber, checkInDate, checkOutDate, totalCost);
        this.vipBenefits = vipBenefits;
    }
    
    // Overriding displayMessage method (Demonstrates Polymorphism - Method Overriding)
    public override void displayMessage() {
        System.debug('Welcome, VIP Guest! Enjoy your exclusive benefits: ' + vipBenefits);
    }
}


Explanation:
Encapsulation: Member variables are private, accessed through public methods.
Abstraction: modifyReservation abstracts reservation modification logic.
Inheritance: VIPReservation extends HotelReservation, reusing its properties and methods.
Polymorphism: Method Overloading (cancelReservation) and Method Overriding (displayMessage in VIPReservation).
Static Members: totalReservations keeps track of all reservations.
