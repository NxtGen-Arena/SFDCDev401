/*Polymorphism is a key concept in object-oriented programming (OOP), where a single method can perform
different tasks depending on the inputs. 
In Salesforce's Apex, method overloading is achieved by creating methods with the same name but different parameter lists (different number of parameters, or parameters with different types). 
However, unlike in some other object-oriented languages, Apex does not support polymorphism through method overriding in the strict sense.
Apex primarily uses method overloading for polymorphism. 
This is particularly useful when you want a method to handle different types of data or varying numbers of inputs in a flexible way.
*/
public class NotificationMessage {

    // Method overloading by changing the number of parameters
    public void displayMessage() {
        System.debug('Display message: No parameters');
    }

    public void displayMessage(String message) {
        System.debug('Display message: ' + message);
    }

    public void displayMessage(String message, Integer count) {
        System.debug('Display message ' + count + ' times: ' + message);
        for (Integer i = 1; i <= count; i++) {
            System.debug(message);
        }
    }

    // Method overloading by changing the type of parameters
    public void displayMessage(Integer number) {
        System.debug('Display number: ' + number);
    }

    public void displayMessage(Boolean flag) {
        if (flag) {
            System.debug('Display message: The flag is true.');
        } else {
            System.debug('Display message: The flag is false.');
        }
    }

    // Static method overloading example
    public static void staticDisplayMessage(String message) {
        System.debug('Static Display: ' + message);
    }

    public static void staticDisplayMessage(String message, Integer number) {
        System.debug('Static Display: ' + message + ' with number ' + number);
    }
}
