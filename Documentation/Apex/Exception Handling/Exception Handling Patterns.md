# Exception Handling Patterns

<h2>Bulk Processing with Partial Failure Handling</h2>

In bulk operations, failing records should not impact successful ones. So, continue with the process even with failed records. Make sure to capture the failed records to process them later.

```
List<Booking__c> bookings = [SELECT Id FROM Booking__c WHERE Status__c = 'Pending'];
Database.SaveResult[] results = Database.insert(bookings, false); // Partial success allowed

for (Database.SaveResult sr : results) {
    if (!sr.isSuccess()) {
        for (Database.Error err : sr.getErrors()) {
            System.debug('Error inserting record: ' + err.getMessage());
        }
    }
}
```
<h2>Logging errors centrally ensures better debugging and monitoring.</h2>

Create a Custom object to track all the backend processing errors and successes. This is a very efficient monitoring mechanism and crucial from Architectural aspect.

```
public class ErrorLogger {
    public static void logError(Exception ex, String operation) {
        Error_Log__c log = new Error_Log__c(
            Operation__c = operation,
            Error_Message__c = ex.getMessage(),
            Stack_Trace__c = ex.getStackTraceString()
        );
        insert log;
    }
}

// Usage
try {
    BookingService.validateBooking(null);
} catch (BookingException e) {
    ErrorLogger.logError(e, 'Validate Booking');
}
```
