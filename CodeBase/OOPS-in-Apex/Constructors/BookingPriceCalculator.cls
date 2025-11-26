public with sharing class BookingPriceCalculator 
{
    //Define the variables
    private Decimal basePrice;
    private Decimal guestCount;
    private String discountCode;
    private Boolean includeBreakfast;
    private Boolean includePickup;

    //Constants
    private static final Decimal BREAKFAST_PRICE = 100.0;
    private static final Decimal PICKUP_PRICE = 750.0;
    private static final Decimal TAX_RATE = 0.18;

    /**
     * Default constructor
     */
    public BookingPriceCalculator()
    {
        //safe initialization
        this.basePrice = 250.0;
        this.guestCount = 1;
        this.discountCode = null;
        this.includeBreakfast = true;
        this.includePickup = false;
    }

    /**
     * Paramterized constrctor
     */
    public BookingPriceCalculator(Decimal basePrice, Integer guestCount, String discountCode, Boolean includeBreakfast, Boolean includePickup)
    {
        this.basePrice = basePrice;
        this.guestCount = guestCount;
        this.discountCode = discountCode;
        this.includeBreakfast = includeBreakfast;
        this.includePickup = includePickup;
    }

    public BookingPriceCalculator(Boolean includeBreakfast, Boolean includePickup)
    {
        this(); // default constructor
        this.includeBreakfast = includeBreakfast;
        this.includePickup = includePickup;
    }

    /**
     * @Description: Constructor is initializing values based on booking record
     */
    public BookingPriceCalculator(Booking__c booking)
    {
        this.basePrice = booking.Room_Price__c;
        this.guestCount = booking.Number_of_Guests__c;
        this.discountCode = booking.Discount_Code__c;
        this.includeBreakfast = booking.Include_Breakfast__c;
        this.includePickup = booking.Include_Pickup__c;
    }

    /**
     * @Description: Method to calculate the total price of the booking
     */
    public Decimal calculateTotalPrice()
    {
        Decimal totalBookingAmount = this.basePrice;

        if(this.includeBreakfast)
        {
            totalBookingAmount += this.guestCount * BREAKFAST_PRICE;
        }

        if(this.includePickup)
        {
            totalBookingAmount += PICKUP_PRICE;
        }

        totalBookingAmount = calculateDiscount(totalBookingAmount);

        return totalBookingAmount; 
    }

    /**
     * Private helper method to calculate the discount based on the discount code
     * @param discountCode
     * @return
     */
     private Decimal calculateDiscount(Decimal amount )
     {
         if (discountCode == 'FESTIVE10') {
            return amount * 0.90; // 10%
        } else if (discountCode == 'CORPORATE20') {
            return amount * 0.80; // 20%
        }
        return amount;
     }

}
