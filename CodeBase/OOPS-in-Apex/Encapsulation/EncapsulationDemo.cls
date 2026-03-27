# While Saving the class use "BankAccount" as a name

public class BankAccount {
    // Private variables to achieve encapsulation and 
    // making sure they cannot be accessed or modified directly from outside the class.
    private String accountHolderName;
    private String accountNumber;
    private Decimal balance;

    // Constructor to initialize BankAccount
    public BankAccount(String accountHolderName, String accountNumber, Decimal initialBalance) {
        this.accountHolderName = accountHolderName;
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
    }

    //Getter and Setter Methods : control how the private variables are accessed or updated, adding a layer of validation or logic if needed.

    // Getter for accountHolderName
    public String getAccountHolderName() {
        return accountHolderName;
    }

    // Setter for accountHolderName
    public void setAccountHolderName(String accountHolderName) {
        this.accountHolderName = accountHolderName;
    }

    // Getter for accountNumber
    public String getAccountNumber() {
        return accountNumber;
    }

    // Note: No setter for accountNumber to make it read-only after initialization

    // Getter for balance
    public Decimal getBalance() {
        return balance;
    }

    //encapsulate the logic for modifying the balance, including validations to prevent invalid operations.
    // Method to deposit money into the account
    public void deposit(Decimal amount) {
        if (amount > 0) {
            balance += amount;
            System.debug('Deposit successful. New balance: ' + balance);
        } else {
            System.debug('Invalid deposit amount.');
        }
    }

    // Method to withdraw money from the account
    public void withdraw(Decimal amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.debug('Withdrawal successful. New balance: ' + balance);
        } else {
            System.debug('Invalid withdrawal amount or insufficient balance.');
        }
    }

    // Method to display account details (for demonstration purposes)
    public void displayAccountDetails() {
        System.debug('Account Holder: ' + accountHolderName);
        System.debug('Account Number: ' + accountNumber);
        System.debug('Current Balance: ' + balance);
    }
}
