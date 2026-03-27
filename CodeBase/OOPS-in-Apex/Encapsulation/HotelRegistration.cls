public with sharing class HotelRegistration {

    //private varibles (encapsulation)
    //Private variables can be acessed only by the class that contains it
    private String customerName;
    private String roomType;
    private Decimal roomPrice;
    private Boolean isBooked;
    private String email;
    private Intger stayDuration;

    public String hotelName {get;set;}  //automatic property - read-write
    public Integer noOfNights {get;}  //Read only property
    public Integer noOfGuests {set;} //Write only propertyi


    //Traditional or standard getter and setter
    //explicitly define methods to get and set values of private fields
    public String getHotelName(){
        return hotelName;
    }
    public void setHotelName(String hotelName){
        this.hotelName = hotelName;
    }


    public String getCustomerName(){
        return this.customerName;
    }

    //custom getter to validate the data
    public String getEmail(){
        if(email == null)
            return 'Email not provided';
        return email;
    }

    //Custom setter to valiate the data
    //setter method to modify the customer name
    public void setCustomerName(String customerName){
        if(customerName != null && customerName.length() > 0)
            this.customerName = customerName;
        else 
            System.debug('customerName is Invalid');
    }

    //If property only has a get accessor, it's basically read-only.
    //If property only has a set accessor, write-only
    public String getRoomType() {
        return this.roomType;
   }

   public DEcimal getRoomPrice(){
       return this.roomPrice;
   }

   //expression body getter and setter - computed and concise
   public Integer StayDuration {
        get {return stayDuration;}
        set {
            if(value <=0){
                throw new IllegalArgumentException('Stay Duraiton must be postive');
            }
            stayDuration = value;
        }
   }
   // Lazy Loading getter (computed property)
   //This computes the total cost only when it ti accessed, optimizing perfromance
   public Decima getTotalCost(){
        if(totalCost == null && stayDuration != null && roomPrice != null){}
            totalCost = stayDuration * roomPrice;
         }
        return totalCost;
   }

   public Boolean getBookingStatus(){
       return this.isBooked;
   }

    //private methods - encapsulation
    private Decimal calculateRoomPrice(String roomType) {
        Decimal roomPrice;
        if(roomType == 'Standard'){
            roomPrice= 100.0;
        }
        else if(roomType == 'Deluxe'){
            roomPrice= 150.0;
        }
        else if(roomType == 'Suite'){
            roomPrice= 250.0;
        }
        else 
            roomPrice = 100.0;
        return roomPrice;
    } 

    public void cancelBooking(){
        this.isBooked = false;
        system.debug('Booking Cancelled for'+ customerName);
    }

    public String getBookingDetails(){
        return 'CustomerName:' + customerName + 'RoomType:' + roomType + 'Price:' + roomPrice + 'Booking Status:'+ (isBooked ? 'Confirmed'  : 'Cancelled');
    }

     //constructor
    public HotelRegistration(String customerName,String roomType) {

        this.customerName = customerName;
        this.roomType = roomType;
        this.roomPrice = calculateRoomPrice(roomType);  //private method for calculation of price
        this.isBooked = true;
    }
    
    public static void processBooking(IHotelRegistration booking,String guestName,String RoomType,Integer nights)
    {
        booking.registerGuest(guestName, RoomType);
        Decimal pricePerNight = booking.calculatePrice(nights);
    }
}
