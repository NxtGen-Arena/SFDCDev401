/**
 * @Description: Handle and implement Standard exception handling
 * @Author: Sheetal Chougule
 * @References: <where is this being used>
 * @Revision History:
 * Created by Sheetal > New class fpr Exception handling in Triggers and Apex
 */

public class ExceptionHandlingDemo {

    /**
     * Types of exceptions: Standard or System Exceptions and Custom Exceptions
     * Exception handling Mechanism: 
     * 1. Try-Catch 
     * 2. Throw - explicitly throwing the execeptions
     * 3. Finally - execute code regardless of exception
     */
    
    /**
     * Exception Methods
     * getDMLId : returns the ID of the failed record
     * getNumDMl: # of failed records
     * getCause: cause of the exception
     * getLineNumber: line number from where exception was thrown
     * getmessage: error message displayed to the end user
     * getStacktraceString: returns entire stack trace for the exception
     * getTypeName: type of exception DmlException,ListException 
     */

     /**
      * @Description: Method to demo system exeption handling using try - catch block
      * @Params: None
      * @returns: void
      */
      public static void generericSystemExceptionHandlingWithTry()
      {
        //Generic exception handling
        try {  //block of code which may throw an error
            Integer iResult = 100/0;
        } catch (Exception ex) {  //since hte error was caught no error displayed on the UI for end users. You cn look in debug log to identify the error,
            system.debug('Exception occured with cause'+ ex.getCause() +'-Message::'+ex.getMessage());
             system.debug('Exception occured' + ex.getStackTraceString());
        }
     }

     /**
      * @Description: Method to demo system exeption handling
      * @Params: None
      * @returns: void
      */
      public static void specificSystemExceptionHandlingWithTry()
      {
        //Generic exception handling
        try {
            Account accNew = new Account();
            accNew.Name = 'Demo new account';
            //this will throw missing argument exception as ID is not avaialble.
            update accNew;

            Integer iResult = 100/0;
        } 
        catch(MathException aex){
            system.debug('MathException occured :'+aex.getMessage());
        }
        catch (Exception ex) {  //since the error was caught no error displayed on the UI for end users. You cn look in debug log to identify the error,
             system.debug('Exception occured :'+ex.getMessage());
        }
     }

     /**
      * @Description: Method to demo system exeption handling using try - catch-Finally block
      * @Params: None
      * @returns: void
      */
      public static void finallyExceptionDemo()
      {
        //Generic exception handling
        try {
            Integer iResult = 100/0;
        } catch(MathException aex){
            system.debug('MathException occured :'+aex.getMessage());
        }finally {  //executes even after the exception occurs
            system.debug('Finally block executed');
        }
        // This will be executed
        system.debug('Statement after the try-catch bl0ck');
     }

     /**
      * @Description: demonstrate the dml exception handling
      * @Params: None
      * @returns: void
      */
      public static void dmlExceptionHandling()
      {
        try {
            //insert an invalid account
            Account acc = new Account(); //missing required fields
            insert acc;
        }
        catch(DmlException ex)
        {
            system.debug('DML Exception occured :'+ex.getMessage());
        }
      }

      /**
      * @Description: demonstrate the dml exception handling
      * @Params: None
      * @returns: void
      */
      public static void queryExceptionHandling()
      {
        try {
            //insert an invalid account
            Account acc = [SELECT Id,Name FROM Account 
                            WHERE Name = 'Demo Apex Account']; //non exisitng account
        }
        catch(QueryException ex)
        {
            system.debug('Query Exception occured :'+ex.getMessage());
        }
      }

      public static void ListExceptionHandling()
      {
        try {
          List<String> employeeList;
           employeeList.add('Adam');
        }
        catch(ListException ex) //any exception related to list data type. Access data that deos not exist at index
        {
            system.debug('ListException  occured :'+ex.getMessage());
        }
        catch(NullPointerException ex)  //attempting operation on variables with null values
        {
            system.debug('NullPointerException  occured :'+ex.getMessage());
        }
      }
}
