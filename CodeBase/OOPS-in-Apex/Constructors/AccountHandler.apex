/**
*@Description: Class demonstrating the Constructor overloading and chaining.
*
**/
public class AccountHandler {
    public Account acc; // Instance variable to hold Account record

    // **1. Default Constructor**
    public AccountHandler() {
        this('Default Account', 'General'); // Calls another constructor
        System.debug('Default constructor executed.');
    }

    // **2. Parameterized Constructor (Single Parameter)**
    public AccountHandler(String name) {
        this(name, 'Technology'); // Calls the next constructor with default industry
        System.debug('Constructor with Name parameter executed.');
    }

    // **3. Parameterized Constructor (Multiple Parameters)**
    public AccountHandler(String name, String industry) {
        this.acc = new Account(Name = name, Industry = industry);
        System.debug('Constructor with Name and Industry executed.');
    }

    // **4. Insert the Account**
    public void insertAccount() {
        if (acc != null) {
            insert acc;
            System.debug('Account inserted: ' + acc);
        } else {
            System.debug('No account to insert.');
        }
    }

    // **5. Test the Constructors**
    public static void testConstructors() {
        // Using Default Constructor (Chained to Multiple Parameter Constructor)
        AccountHandler defaultHandler = new AccountHandler();
        defaultHandler.insertAccount();

        // Using Single Parameter Constructor (Chained to Multiple Parameter Constructor)
        AccountHandler nameOnlyHandler = new AccountHandler('Salesforce Ltd');
        nameOnlyHandler.insertAccount();

        // Using Fully Parameterized Constructor
        AccountHandler customHandler = new AccountHandler('Tech Corp', 'IT Services');
        customHandler.insertAccount();
    }
}
