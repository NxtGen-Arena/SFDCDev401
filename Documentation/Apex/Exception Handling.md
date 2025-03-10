# Exception handling in Apex

## What is an Exception?
An exception is an event that occurs during the execution of a program, indicating that something unexpected or erroneous has happened. Exceptions can be caught and handled by the code, allowing the program to continue executing or to gracefully exit.

There are several built-in exception classes in Apex, such as System.Exception, System.DmlException, System.QueryException, and more. These built-in exception classes cover most common scenarios, but sometimes you need to create custom exceptions to handle specific situations or to provide more meaningful error messages.

You can also create your own execption class. To use a custom exception, you can create an instance of the custom exception class and use the throw keyword to throw the exception. 

>[!note]
>Governor limits exceptions are runtime exceptions and are not caught through Try Catch block

<h2> Why we need Execption Handling?</h2>

1. Validation Before Update:
   In Salesforce, data quality is critical, especially when working with key objects like Account.
   
2. Custom Exceptions for Specific Errors:
   Using AccountValidationException ensures that any validation issues are clearly identified and handled in a structured way.
   
3. Scalability:
   The validateAccount method can be expanded with additional rules (e.g., industry type restrictions or contact validation).
   
4. Error Isolation:
   By catching custom exceptions separately, you can provide more meaningful error handling or display user-friendly error messages.

<h2>Types of Exceptions in Salesforce</h2>

1. **System Exceptions:** Built-in exceptions thrown by Salesforce when a governor limit is exceeded or a Salesforce-specific error occurs. Examples include NullPointerException, DMLException, QueryException, etc.
2. **Custom Exceptions:** User-defined exceptions that allow developers to handle application-specific errors in a custom way.

|Type|Description|Execption Category|Details|
|----|----------|---------------|--------|
|DML Exception|These occur during insert, update, delete, or undelete operations.| DMLException|DML Fails due to required field missing or similar reasons.
|||MixedDmlOperationException| Occurs when you try to mix setup and non-setup objects in the same transaction.
|Governor Limit Exceptions |These occur when Salesforce limits are exceeded.|LimitException|Triggered when execution limits allocated (e.g., SOQL queries, CPU time) are exceeded.
|System Exceptions|These are runtime exceptions due to system-level errors.|NullPointerException|Attempting to access a null variable.
|||QueryException|Issues with SOQL queries, such as retrieving multiple records when only one is expected.
|||TypeException|Occurs when incompatible data types are used.
|Callout Exceptions|These occur when external system integrations fail.|CalloutException| Raised when an HTTP request fails or times out.
|Custom Exceptions|These are custom-defined exceptions that enforce specific business rules.|BookingException|enforce constraints in the booking system.


<h2>Exception Handling Mechanisms</h2>

* Try-Catch Block: Used to catch exceptions and handle them.
* Throw Statement: Used to explicitly throw exceptions.
* Finally Block: Used to execute code regardless of whether an exception was thrown or not.

<h2>Try-Catch-Finally</h2>

Apex provides the standard try-catch-finally block to handle exceptions. Handle specific exceptions and then add a generic exception block to cature any errors which are not caught by other catch blocks.

* try: Contains the main business logic that may throw an exception.
* catch: Handles the exception and defines actions to take when an error occurs.
* finally: Contains code that executes regardless of whether an exception occurred.The finally block is useful for cleanup activities like closing resources, logging, or resetting variables.


```
try {
    // Fetching booking details
    Booking__c booking = [SELECT Id FROM Booking__c WHERE Guest_Name__c = 'John Doe' LIMIT 1];
    booking.Room_Type__c = null;
    update booking;
} catch (QueryException qe) {
    System.debug('SOQL Query failed: ' + qe.getMessage());
} catch (DmlException de) {
    System.debug('DML Operation failed: ' + de.getMessage());
} catch (Exception e) {
    System.debug('Unexpected error: ' + e.getMessage());
} finally {
    System.debug('Booking operation completed.');
}
```


<h2>Demo</h2>

```
public class ExceptionHandlingDemo {

    // Method to demonstrate system exception handling
    public static void systemExceptionDemo() {
        try {
            // Intentional divide by zero to throw an exception
            Integer result = 10 / 0;
        } catch (MathException e) {
            // Log the exception and display a message
            System.debug('Math Exception caught: ' + e.getMessage());
        } finally {
            System.debug('Finally block executed: System Exception Demo');
        }
    }

    // Method to demonstrate DML exception handling
    public static void dmlExceptionDemo() {
        try {
            // Attempting to insert an invalid account
            Account acc = new Account(); // Missing required fields
            insert acc;
        } catch (DmlException e) {
            // Log the exception and display a message
            System.debug('DMLException caught: ' + e.getMessage());
        } finally {
            System.debug('Finally block executed: DML Exception Demo');
        }
    }

    // Method to demonstrate SOQL query exception handling
    public static void queryExceptionDemo() {
        try {
            // Incorrect query syntax to throw an exception
            Account acc = [SELECT Name FROM Account WHERE Id = '123']; // Non-existent record
        } catch (QueryException e) {
            // Log the exception and display a message
            System.debug('QueryException caught: ' + e.getMessage());
        } finally {
            System.debug('Finally block executed: Query Exception Demo');
        }
    }

    // Custom exception definition
    public class CustomBusinessException extends Exception {}

    // Method to demonstrate custom exception handling
    public static void customExceptionDemo(String input) {
        try {
            if (String.isEmpty(input)) {
                // Throw a custom exception
                throw new CustomBusinessException('Input cannot be empty');
            } else {
                System.debug('Input is valid: ' + input);
            }
        } catch (CustomBusinessException e) {
            // Log the exception and display a message
            System.debug('CustomBusinessException caught: ' + e.getMessage());
        } finally {
            System.debug('Finally block executed: Custom Exception Demo');
        }
    }
}

```

You can execute the methods in the ExceptionHandlingDemo class in the Developer Console or via anonymous Apex:

```
ExceptionHandlingDemo.systemExceptionDemo();
ExceptionHandlingDemo.dmlExceptionDemo();
ExceptionHandlingDemo.queryExceptionDemo();
ExceptionHandlingDemo.customExceptionDemo('');
ExceptionHandlingDemo.customExceptionDemo('Valid Input');

```

### Explanation of Code

* System Exception Demo:Demonstrates handling of an ArithmeticException caused by division by zero.
* DML Exception Demo:Demonstrates handling of a DmlException caused by attempting to insert an invalid record.
* Query Exception Demo:Demonstrates handling of a QueryException when a query fails to find a record.
* Custom Exception Demo: Shows how to define and handle a user-defined CustomBusinessException.

<h2>Best Practices</h2>

- Specific Exception Handling: Catch specific exceptions whenever possible to handle them appropriately.
- Avoid Empty Catch Blocks: Always include code to handle exceptions; empty catch blocks can lead to silent failures.
- Logging: Use system debug logs or custom logging mechanisms to log exception details for debugging purposes.
