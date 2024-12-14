public class PolymorphismDemo {

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
