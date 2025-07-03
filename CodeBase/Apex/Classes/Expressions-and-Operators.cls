public class ExpressionsAndOperators {
    public static void demonstrateOperators() {
        /* Arithmetic Operators: Perform mathematical operations */
        Integer a = 10, b = 5;
        System.debug('Addition: ' + (a + b)); // Adds a and b
        System.debug('Subtraction: ' + (a - b)); // Subtracts b from a
        System.debug('Multiplication: ' + (a * b)); // Multiplies a and b
        System.debug('Division: ' + (a / b)); // Divides a by b
        
        /* Comparison Operators: Compare values and return boolean results */
        System.debug('Equal to (==): ' + (a == b)); // Checks if a equals b
        System.debug('Not equal to (!=): ' + (a != b)); // Checks if a is not equal to b
        System.debug('Greater than: ' + (a > b)); // Checks if a is greater than b
        System.debug('Less than: ' + (a < b)); // Checks if a is less than b
        System.debug('Greater than or equal to: ' + (a >= b));
        System.debug('Less than or equal to: ' + (a <= b));
        
        /* Logical Operators: Used to combine boolean values */
        Boolean x = true, y = false;
        System.debug('Logical AND (&&): ' + (x && y)); // Returns true if both x and y are true
        System.debug('Logical OR (||): ' + (x || y)); // Returns true if either x or y is true
        System.debug('Logical NOT (!): ' + (!x)); // Returns the opposite boolean value of x
        
        /* Bitwise Operators: Perform bitwise operations on integers */
        Integer m = 6, n = 3; // 6 = 110 in binary, 3 = 011 in binary
        System.debug('Bitwise AND (&): ' + (m & n)); // Performs AND operation on each bit
        System.debug('Bitwise OR (|): ' + (m | n)); // Performs OR operation on each bit
        System.debug('Bitwise XOR (^): ' + (m ^ n)); // Performs XOR operation on each bit
        
        /* Ternary Operator: Short-hand for if-else condition */
        Integer max = (a > b) ? a : b; // If a > b, return a; otherwise, return b
        System.debug('Max value using ternary operator: ' + max);
        
        /* Null Safe Operator: Prevents null pointer exceptions */
        String str = null;
        System.debug('Null safe operator example: ' + (str?.length())); // Returns null if str is null
        
        /* == vs === Operator: Difference in checking value and type */
        Object obj1 = 10;
        Object obj2 = 10;
        System.debug('Equality (==) checks value: ' + (obj1 == obj2)); // Compares values
        System.debug('Strict equality (===) checks value & type: ' + (obj1 === obj2)); // Compares both value and type
        
        // Demonstrate standard functions
        demonstrateStandardFunctions();
        
        // Demonstrate Date functions
        demonstrateDateFunctions();
    }
    
    public static void demonstrateStandardFunctions() {
        /* Demonstrating standard String functions */
        String sampleText = '   Hello Apex!   ';
        System.debug('Original String: "' + sampleText + '"');
        System.debug('Trimmed String: "' + sampleText.trim() + '"'); // Removes leading and trailing spaces
        System.debug('Uppercase: ' + sampleText.toUpperCase()); // Converts to uppercase
        System.debug('Lowercase: ' + sampleText.toLowerCase()); // Converts to lowercase
        System.debug('String Length: ' + sampleText.length()); // Returns the number of characters
        System.debug('Substring (0, 5): ' + sampleText.substring(0, 5)); // Extracts substring from index 0 to 5
        
        /* Demonstrating standard Math functions */
        System.debug('Absolute value of -10: ' + Math.abs(-10)); // Returns absolute value
        System.debug('Random number: ' + Math.random()); // Generates a random number
        System.debug('Square root of 25: ' + Math.sqrt(25)); // Calculates square root
        System.debug('Power (2^3): ' + Math.pow(2, 3)); // Calculates power of numbers
    }
    
    public static void demonstrateDateFunctions() {
        /* Demonstrating commonly used Date functions */
        Date today = Date.today();
        System.debug('Today\'s Date: ' + today);
        System.debug('Year: ' + today.year()); // Retrieves current year
        System.debug('Month: ' + today.month()); // Retrieves current month
        System.debug('Day: ' + today.day()); // Retrieves day of the month
        
        // Adding and subtracting days from the current date
        System.debug('Date after 10 days: ' + today.addDays(10));
        System.debug('Date before 10 days: ' + today.addDays(-10));
        
        /* Working with DateTime */
        Datetime now = Datetime.now();
        System.debug('Current Datetime: ' + now);
        System.debug('Hour: ' + now.hour()); // Retrieves current hour
        System.debug('Minute: ' + now.minute()); // Retrieves current minute
        System.debug('Second: ' + now.second()); // Retrieves current second
    }
}
