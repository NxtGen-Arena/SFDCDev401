# Excepion handling in Apex

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

<h2>Exception Handling Mechanisms</h2>

* Try-Catch Block: Used to catch exceptions and handle them.
* Throw Statement: Used to explicitly throw exceptions.
* Finally Block: Used to execute code regardless of whether an exception was thrown or not.

<h2>Demo</h2>

```
public class ExceptionHandlingDemo {

    // Method to demonstrate system exception handling
    public static void systemExceptionDemo() {
        try {
            // Intentional divide by zero to throw an exception
            Integer result = 10 / 0;
        } catch (ArithmeticException e) {
            // Log the exception and display a message
            System.debug('ArithmeticException caught: ' + e.getMessage());
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
