/**
 * DataTypesAndOperatorsDemo
 * ------------------------------------------------------------
 * Purpose:
 *  - Beginner-friendly Apex class demonstrating common data types and operators
 *  - Uses realistic Generic CRM examples: Accounts, Contacts, Leads, Opportunities
 *  - Adheres to naming conventions:
 *      * Classes/Enums: PascalCase
 *      * Variables/parameters/methods: camelCase
 *      * Constants: UPPER_SNAKE_CASE
 *
 * How to run:
 *  - Developer Console > Debug > Open Execute Anonymous:
 *      DataTypesAndOperatorsDemo.runAll();
 *  - Or Salesforce CLI:
 *      sf apex run --apex-code "DataTypesAndOperatorsDemo.runAll();"
 */

 /**
* @Description: This class is used to demonstrate the various data types in Apex
* @Test Class: DataTypesAndOperatorsDemoTest
* @Used In:
* @Author: Sheetal Chougule
* @Version History:
    Modified by | Changes Made  | US #
    Sheetal Chougule | Updated the comments to reflect the changes made to the class. | WBS-1
*/
public with sharing class DataTypeAndOperators 
{
    private static void runAll() 
    { 
        primitivesDemo(); 
        dateTimeDemo(); 
        idAndSObjectDemo();
        operatorsAndStringsDemo();
        booleansAndConditionalsDemo();
        demonstrateStandardFunctions();
        demonstrateDateFunctions();     
    }

    /**
     * Primiives are passed by value.
     */
    private static void primitivesDemo() 
    { 
        System.debug('> Primitives Demo with realistic names'); 

        // Example: Lead scoring context 
        Integer leadScore = 78; // aggregate lead score 
        Long totalEmailOpens = 10000000000L; // large counters fit in Long 
        Decimal opportunityBudget = 125000.50; // currency-like precision 
        Double contactEngagementRatio = 22.0 / 7.0; // floating point, not for currency 
        Boolean isQualifiedLead = true; //true, false, null
        String welcomeMessage = 'Welcome to Apex learning for CRM!'; 

        System.debug(LoggingLevel.INFO, 'leadScore=' + leadScore); 
        System.debug(LoggingLevel.INFO, 'totalEmailOpens=' + totalEmailOpens); 
        System.debug(LoggingLevel.INFO, 'opportunityBudget=' + opportunityBudget); 
        System.debug(LoggingLevel.INFO, 'contactEngagementRatio=' + contactEngagementRatio); 
        System.debug(LoggingLevel.INFO, 'isQualifiedLead=' + isQualifiedLead); 
        System.debug(LoggingLevel.INFO, 'welcomeMessage=' + welcomeMessage); 

    }
    // ---------------  DATE, DATETIME, TIME ----------------- 
    private static void dateTimeDemo() 
    { 
        System.debug('> Date/Datetime/Time Demo (scheduling outreach)'); 

        Date campaignStartDate = Date.today(); // left hand side Date = data type while right hand side Date.today() = class.method
        Date startDate = Date.newInstance(2023, 10, 30);
        Datetime nextFollowUpAt = Datetime.now().addDays(2); // next follow-up 
        Time dailyCallWindowStart = Time.newInstance(9, 0, 0, 0); // 9:00 AM local 

        // Calculate an arbitrary review date at month end (approx) 
        Date approximateReviewDate = Date.newInstance(campaignStartDate.year(), campaignStartDate.month(), 28).addDays(3); 

        System.debug('campaignStartDate=' + campaignStartDate); 
        System.debug('nextFollowUpAt=' + nextFollowUpAt); 
        System.debug('dailyCallWindowStart=' + dailyCallWindowStart); 
        System.debug('approximateReviewDate=' + approximateReviewDate); 

    } 

    // --------------- ID AND SOBJECTS ----------------- 
    private static void idAndSObjectDemo() 
    { 
        System.debug('> Id and sObject Demo (Account context)'); 

        //SObject - A sObject is a generic Salesforce object that can contain a variety of data. Salesforce is tightly integrated with the database.
        //Use Case = When you need to perform dynamic queries that can return a mix of different Salesforce objects.
        //[NOTE]: Every recrod in Salesfoce is natively represented as sObject
        //sObject abstract data type representing any std or custom object record
        sObject acnt = new Account();
        acnt.put('Name', 'My Account Name'); //put - is used to add values to the object

        // Fetch a sample Account safely
        Account sampleAccount = [SELECT Id, Name, Type FROM Account LIMIT 1];

        //00112345678900f 00112345678900F - different records. 15 digits id are case sensitive
        //00112345678900fACD 00112345678900FBHY - different records. 18 digits id are not case sensitive
        Id sampleAccountId = sampleAccount == null ? null : sampleAccount.Id;

        System.debug('sampleAccountId=' + sampleAccountId);
        System.debug('sampleAccount.Name=' + (sampleAccount == null ? null : sampleAccount.Name)); 

        // sObject can hold any record; instanceof checks runtime type
        sObject genericRecord = sampleAccount;

        System.debug('genericRecord.getSObjectType()=' + genericRecord.getSObjectType()); 
        System.debug('genericRecord instanceof Account? ' + (genericRecord instanceof Account)); 

        //Blob stores the binary data  in a variable
        Blob blobTest = Blob.valueOf('Test data');
        system.debug('blobTest = ' + blobTest);

    }

    private static void operatorsAndStringsDemo() 
    { 
        System.debug('> Operators and Strings Demo (Opportunity math)'); 

        // Arithmetic  
        Decimal opportunitySubtotal = 20000; 
        Decimal promotionalDiscountRate = 0.15; // 15% promo 
        Decimal discountAmount = opportunitySubtotal * promotionalDiscountRate; 
        Decimal opportunityNetAmount = opportunitySubtotal - discountAmount; 

        System.debug('discountAmount=' + discountAmount); 
        System.debug('opportunityNetAmount=' + opportunityNetAmount); 
        
        // Relational operators 
        Decimal approvalThreshold = 10000; 
        Boolean requiresVPApproval = opportunityNetAmount > approvalThreshold; 

        System.debug('requiresVPApproval=' + requiresVPApproval); 

        // Assignment operators 
        Integer remainingTasks = 10; 
        remainingTasks -= 3; // completed 3 tasks 
        System.debug('remainingTasks=' + remainingTasks); 

        Integer iCount = 0;
        iCount = iCount + 10;
        iCount += 10;

        // Strings: composing a message to display in a component 
        String greetingPrefix = 'Hello'; 
        String userFirstName = 'Alex';
        //For strings we can use the + operator to concatenate strings
        //String greetingMessage = greetingPrefix + ', ' + userFirstName + '!';
        String dashboardMessage = greetingPrefix + ', ' + userFirstName + '! You have ' + remainingTasks + ' tasks left.'; 

        System.debug('dashboardMessage=' + dashboardMessage); 

        // Useful String methods 
        System.debug('message length=' + dashboardMessage.length()); 
        System.debug('upper=' + dashboardMessage.toUpperCase()); 
        System.debug('contains "tasks"? ' + dashboardMessage.contains('tasks')); 
        System.debug('first 5 chars=' + dashboardMessage.substring(0, 5)); 

        // instanceof and null-safe navigation 
        Object anyValue = dashboardMessage; 
        System.debug('anyValue instanceof String? ' + (anyValue instanceof String)); 

        Account maybeNullAccount = null; 
        String safeAccountType = maybeNullAccount?.Type; // safe navigation returns null when left side is null 

        System.debug('safeAccountType (should be null)=' + safeAccountType); 

        // Null-coalescing pattern using ternary 
        String assignedOwner = null; 
        String displayOwner = assignedOwner != null ? assignedOwner : 'Unassigned'; 

        System.debug('displayOwner=' + displayOwner); 

        Integer a = 10, b = 5;
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

    // --------------- BOOLEANS AND CONDITIONALS ----------------- 
    private static void booleansAndConditionalsDemo() 
    { 
        System.debug('> Booleans and Conditionals Demo (Access checks)'); 

        Boolean isPortalUser = true; 
        Boolean hasManageLeadsPerm = false; 

        // Logical operators: && (AND), || (OR), ! (NOT) 
        Boolean canConvertLead = isPortalUser && hasManageLeadsPerm; 
        Boolean canViewLeads = isPortalUser || hasManageLeadsPerm; 
        Boolean isInternalOnly = !isPortalUser; 

        System.debug('canConvertLead=' + canConvertLead); 
        System.debug('canViewLeads=' + canViewLeads); 
        System.debug('isInternalOnly=' + isInternalOnly); 


        // Ternary operator for quick label selection 
        Integer openCases = 12; 
        String workloadLabel = openCases >= 10 ? 'High workload' : 'Normal workload'; 
        System.debug('workloadLabel=' + workloadLabel); 
    }
}
