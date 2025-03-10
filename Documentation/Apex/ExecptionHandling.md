# Excepion handling in Apex

## What is an Exception?
An exception is an event that occurs during the execution of a program, indicating that something unexpected or erroneous has happened. Exceptions can be caught and handled by the code, allowing the program to continue executing or to gracefully exit.

There are several built-in exception classes in Apex, such as System.Exception, System.DmlException, System.QueryException, and more. These built-in exception classes cover most common scenarios, but sometimes you need to create custom exceptions to handle specific situations or to provide more meaningful error messages.

You can also create your own execption class. To use a custom exception, you can create an instance of the custom exception class and use the throw keyword to throw the exception. 

>[!note]
>Governor limits exceptions are runtime exceptions and are not caught through Try Catch block

<h2>Types of Exceptions in Salesforce</h2>

1. **System Exceptions: ** Built-in exceptions thrown by Salesforce when a governor limit is exceeded or a Salesforce-specific error occurs. Examples include NullPointerException, DMLException, QueryException, etc.
2. **Custom Exceptions:** User-defined exceptions that allow developers to handle application-specific errors in a custom way.

<h2>Exception Handling Mechanisms</h2>

* Try-Catch Block: Used to catch exceptions and handle them.
* Throw Statement: Used to explicitly throw exceptions.
* Finally Block: Used to execute code regardless of whether an exception was thrown or not.


<h2>Best Practices</h2>

- Specific Exception Handling: Catch specific exceptions whenever possible to handle them appropriately.
- Avoid Empty Catch Blocks: Always include code to handle exceptions; empty catch blocks can lead to silent failures.
- Logging: Use system debug logs or custom logging mechanisms to log exception details for debugging purposes.
