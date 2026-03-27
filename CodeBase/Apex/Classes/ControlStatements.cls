/*
@Description: This class is used to demonstrate the various control statements in Apex
@Author: Sheetal Chougule
@Version: 1.0
*/
public with sharing class ControlStatements 
{
    /* 
    1. Conditional Statements: if, if-else,else and swtich-when
    2. Loops: for, while, do-while
    3. Break/Continue: To control loop execution and skip the remaining code.
    4. Apex Exceptions: try-catch, try-catch-finally, try-finally
    */

    /*
    Executes a block of code based on a condition.
    If the condition is true, then the block of code is executed
    If the condition is false, then the block of code is skipped.
    In Apex you can also have nested if-else conditionals.
    */
    public static void ifElsePrimitive()
    {
        Integer age = 20;

        //Simple if 
        if(age == 0)
        {
            System.debug('Please enter valid age');
        }

        //If-else
        if(age < 18)
        {
            System.debug('Age is less than 18');
        }
        else        
        {
            System.debug('Age is greater than 18');
        }

        //If-Else If - Chaining of if
        if(age < 10)
        {
            System.debug('Toddler');    
        }
        else if(age < 20)
        {
            System.debug('Child');
        }
        else if(age < 30)
        {
            System.debug('Young Adult');
        }
        else if(age < 40)
        {
            System.debug('Adult');
        }
        else
        {
            System.debug('Old person');
        }
    }

    public static void ifElseSOQL()
    {
        //Not preferred approach
        Account accRecord = [SELECT Id, Name,Type FROM Account LIMIT 1];

        if(accRecord.Type == 'Customer - Direct')
        {
            System.debug('Customer Direct');
        }
        else
        {
            System.debug('Customer not direct');
        }
    }

    //excpression matches one of the several values and branches accordingly
    //in Switch case expression, you can use only String, enum, and primitive data types.
    //String in Switch Case is case sensitive.
    //You cannot use custom objects or Salesforce standard objects.
    //If you have ID value, then you can only use primitive data types.
    public static void switchControl(String monthName)
    {
        //Switch control statement
        switch on monthName
        {
            when 'Jan','Feb','Mar','April'
            {
                System.debug('It is Winter');
            }   
            when 'May','June','July','Aug'
            {
                System.debug('It is Summer');
            }
            when 'Sep','Oct','Nov','Dec'
            {
                System.debug('It is Spring');
            }
            when null
            {
                System.debug('It is Holiday');
            }
            when else
            {
                System.debug('It is not a valid month');
            }
        }
    }

    //Method as a Switch Exprression
   /* public static void switchControlMethod()
    {
        //Switch control statement
        switch on returnCurrentMonth(monthName)
        {
            when 'Jan','Feb','Mar','April'
            {
                System.debug('It is Winter');
            }   
            when 'May','June','July','Aug'
            {
                System.debug('It is Summer');
            }
            when 'Sep','Oct','Nov','Dec'
            {
                System.debug('It is Spring');
            }
            when null
            {
                System.debug('It is Holiday');
            }
            when else
            {
                System.debug('It is not a valid month');
            }
        }
    }

    public static String returnCurrentMonth(String monthName)
    {
        return monthName;
    }
*/
    //code executes atleast once
    //do {statement} while (expression to evaluate)
    public static void doWhileLoop()
    {
        //Declaration and Initilization
        Integer iCount = 6;
        do
        {
            system.debug('value of iCount ' + iCount);
            iCount++;
        } while(iCount < 5 );    //execute till this condition is true
    }

    //code executes only if the criteria is matched
    //While (boolean condition to evaluate) statement to execute
    public static void whileLoop()
    {
        //Declaration and Initilization
        Integer iCount = 6;
        while(iCount < 5) //Condition to be evaluated and executed
        {  
            system.debug('value of iCount ' + iCount);
            iCount++;
        }
    }

    //Initialization;Condition;increment) 
    //Declaration & Intial assignment;condition;increment
   //1. Traditional for loop - for (initialization;condition;increment)
   //2. For each loop - for (variable:collecion)
   //3. SOQL for loop - for (variable:[soql query])
    public static void forLoop()
    {
        //Declaration and Initilization
        Integer iCount;
        for(iCount=0;iCount<8;iCount++)
        {
            if(iCount == 2 || iCount == 4 || iCount == 6)
            {
                continue; //skip the current iteration
            }
            if(iCount == 5)
            {
                break;  //exit the loop 
            }
            system.debug('value of iCount ' + iCount);
        }

        //traditional for loop
        for(Integer intCounter=0;intCounter<5;intCounter++)
        {
            system.debug('value of intCounter ' + intCounter);
        }

        //Advanced for loop - loop through list of record
        //For-each loop - loop through list of record
        List<Account> lstAccount = [SELECT Id,Name From Account limit 5]; // allocate a new memory for objAccount only when it is assigned with a value (initilization)
        for(Account objAccount:lstAccount)
        {
            system.debug('value of objAccount ' + objAccount.Name);
        }

        //SOQL for loop to avoids the performance issue and allows to process more than 50000 records
        //loop through list of record
        //Benefit: Avoid limit on heap size. Uses query and queryMore internally, batch of 200 records at a time
        //Downside:No performance improvement
        for(Account objAccount:[SELECT Id,Name From Account limit 5])
        {
            system.debug('value of objAccount ' + objAccount.Name);
        }
    }

}
