# While Saving the class use "BankAccount" as a name

public class BankAccount {
    // Private variables to achieve encapsulation
    private String accountHolderName;
    private String accountNumber;
    private Decimal balance;

    // Constructor to initialize BankAccount
    public BankAccount(String accountHolderName, String accountNumber, Decimal initialBalance) {
        this.accountHolderName = accountHolderName;
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
    }

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
