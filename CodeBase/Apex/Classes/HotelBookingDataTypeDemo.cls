//===========================================================
// DEMO: Variables and Data Types in Apex (Hotel Booking)
// PURPOSE: Understand how variables store and handle different data types
//===========================================================

public class HotelBookingDataTypeDemo {

    public static void demoDataTypes() {
        // ------------------------------
        // 🔹 STRING (Text Data)
        // ------------------------------
        // Used to store textual information
        String guestName = 'John Smith';
        String roomType = 'Deluxe Suite';
        
        // You can join strings using '+' operator
        String bookingMessage = 'Booking created for ' + guestName + ' in ' + roomType;
        System.debug(bookingMessage);  // Output: Booking created for John Smith in Deluxe Suite


        // ------------------------------
        // 🔹 INTEGER (Whole Numbers)
        // ------------------------------
        // Used for numeric values without decimals
        Integer numberOfGuests = 2;
        Integer numberOfNights = 3;

        // Arithmetic operations
        Integer totalGuests = numberOfGuests + 1;     // Addition
        Integer remainingRooms = 10 - numberOfGuests; // Subtraction
        System.debug('Total Guests: ' + totalGuests);
        System.debug('Remaining Rooms: ' + remainingRooms);


        // ------------------------------
        // 🔹 DECIMAL (Currency or precise values)
        // ------------------------------
        // Used for money or fractional values
        Decimal roomRate = 4500.75;
        Decimal totalAmount = roomRate * numberOfNights; // Multiplication
        System.debug('Total Room Amount: ₹' + totalAmount);

        // Division and rounding
        Decimal averageRate = totalAmount / numberOfNights;
        System.debug('Average Rate per Night: ₹' + averageRate.setScale(2));


        // ------------------------------
        // 🔹 BOOLEAN (True/False values)
        // ------------------------------
        Boolean includesBreakfast = true;
        Boolean isLoyalCustomer = false;

        // Logical operations
        Boolean giveDiscount = includesBreakfast && isLoyalCustomer; // AND operator
        System.debug('Give Discount? ' + giveDiscount);

        // OR operator example
        Boolean allowEarlyCheckIn = includesBreakfast || isLoyalCustomer;
        System.debug('Allow Early Check-In? ' + allowEarlyCheckIn);


        // ------------------------------
        // 🔹 DATE (Stores only date)
        // ------------------------------
        Date checkInDate = Date.newInstance(2025, 10, 18);  // yyyy, mm, dd
        Date checkOutDate = checkInDate.addDays(numberOfNights);
        System.debug('Check-In: ' + checkInDate + ', Check-Out: ' + checkOutDate);

        // Date comparison
        Boolean isFutureDate = checkInDate > Date.today();
        System.debug('Check-in is in the future? ' + isFutureDate);


        // ------------------------------
        // 🔹 DATETIME (Stores date + time)
        // ------------------------------
        Datetime bookingDateTime = Datetime.now();  // Current system date & time
        System.debug('Booking Created On: ' + bookingDateTime);

        // Add time duration
        Datetime checkInDateTime = bookingDateTime.addDays(1).addHours(12); // Tomorrow at 12 PM
        System.debug('Planned Check-In Time: ' + checkInDateTime.format());

        // Calculate hours difference between two datetimes
        Long hoursUntilCheckIn = checkInDateTime.getTime() - bookingDateTime.getTime();
        System.debug('Milliseconds until check-in: ' + hoursUntilCheckIn);


        // ------------------------------
        // 🔹 BLOB (Binary Large Object)
        // ------------------------------
        // Used to store binary data like images or files
        Blob bookingConfirmation = Blob.valueOf('This is a digital booking receipt');
        System.debug('Blob Value (as String): ' + bookingConfirmation.toString());

        // You can encode or decode Blob data
        String base64Encoded = EncodingUtil.base64Encode(bookingConfirmation);
        System.debug('Base64 Encoded Blob: ' + base64Encoded);
    }
}
