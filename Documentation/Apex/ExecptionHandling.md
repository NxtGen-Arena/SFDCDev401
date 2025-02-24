# Excepion handling in Apex

## What is an Exception?
An exception is an event that occurs during the execution of a program, indicating that something unexpected or erroneous has happened. Exceptions can be caught and handled by the code, allowing the program to continue executing or to gracefully exit.

There are several built-in exception classes in Apex, such as System.Exception, System.DmlException, System.QueryException, and more. These built-in exception classes cover most common scenarios, but sometimes you need to create custom exceptions to handle specific situations or to provide more meaningful error messages.

You can also create your own execption class. To use a custom exception, you can create an instance of the custom exception class and use the throw keyword to throw the exception. 

>[!note]
>Governor limits exceptions are runtime exceptions and are not caught through Try Catch block

## Exception Handling using Try,Catch and Finally



## Custom Exception Declaration and Handling


<h2>Best Practices</h2>

- Specific Exception Handling: Catch specific exceptions whenever possible to handle them appropriately.
- Avoid Empty Catch Blocks: Always include code to handle exceptions; empty catch blocks can lead to silent failures.
- Logging: Use system debug logs or custom logging mechanisms to log exception details for debugging purposes.
