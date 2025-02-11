//Operation: Insert, Update, Delete, Upsert
//Type:  Update - DML Operation - Creates records, Retrieves records, Updates records, Deletes records, Undeletes Records
//DML is used for write operations. It is also known as CRUD Operation


//Different actions in Apex DML
//1. Insert - adding new records
//2.Update - modify existing records
//3. Delete - removing records (hard delete)
//4. Undelete - retrieving deleted records (soft deleted records) - from recycle bin
//6. Merge - combining into one record (closely related to upsert. Merge is used when you move or copy data from one location to another.
//7. Upsert - add new records or update existing ones (combination)

//Governor limits: 150  DML statements per Apex Transactions
//AFter 150 DML's runtime exception which cannot be caught in try-catch block is thrown.
//The transaction is then rolled back and you can't perform any DML operations.

//Governor limits: Total # of row that can be processed by DML in SIngle transaction - 10000
public with sharing class DMLDemo 
{
    //DML can be performed on single sObject or list of sObjects.
    //Insert - Adding new records
    //Operation: Simple DML Statemen
    //Error Handling - thorwn runtime exception if record fails
    //Partial rollbacks not possible. 
    //Not many methods for error and success handling
    public static void insertRecords()
    {
        //insert single account
        Account accntRecord = new Account(Name='Single Account Creation', Phone='(415)555-1212', NumberOfEmployees=100);
        insert accntRecord;
        system.debug('InsertRecords::Single Record Id: '+accntRecord.Id);

        //another way to create the sobject record
        Account newAccount = New Account();
        newAccount.Name = 'Single Account New Creation';
        newAccount.Phone = '(415)555-1212';
        newAccount.NumberOfEmployees = 250;

        insert newAccount;

        //Creating a list of Accounts
        List<Account> accList = new List<Account>();
        //Populate the list with 3 records
        for(Integer i=0; i<3; i++)
        {
            //Create a new Account
            Account acc = new Account();
            acc.Name = 'Test Account'+i;
            //Add the account to the list
            accList.add(acc);

            //DML inside the for loop - governor limits are hit
            //insert accList; 
        }

        //Insert all the records from list in single DML statement
        //[Best Practice]  - Use collections and insert all the elements using one DML statement
        //This will reduce the number of DML calls and improve the performance of the application
        insert accList;

        //Print the result
        System.debug('Inserted Accounts: '+accList);
    }

    //Operation: Database DML Statemens
    //Error Handling - Allows partial success and failures and returns result object.
    //allOrNone - Parital or full rollbacks allowed
    //Providing more flecxibility in error handling, rollbacks and partial success.
    public static void databaseDMLOperations()
    {
        // Insert a list of Accounts
        List<Account> lstAccounts = new List<Account>();
        //add two accounts in the list
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');

        lstAccounts.add(acc1);
        lstAccounts.add(acc2);

        // DML Statement
        //Return type = Database.SaveResult
        //Param: List<sObject> - List of sObjects to be updated or inserted
        //AllorNone Flag = false: partial processing allowed. Continue with remaining records in case of failure
        //true:If any record fails, the entire transaction rolls back
        Database.SaveResult[] srList = Database.insert(lstAccounts, false);
        for(Database.SaveResult result : srList)
        {
            if(result.isSuccess())
            {
                System.debug('Successfully inserted account. Account ID: ' + result.getID()); //retrieves ID for successful record
            } else {
                for(Database.Error err : result.getErrors()) //collection of errors
                {
                    System.debug('The Error is: ' + err.getMessage());
                }
            }
        }
    }

    public static void updateRecords()
    {
        //retrieve the single record
        //Use only whe you ar certain about SOQL returning single record.
        Account acc = [Select ID, Name  from Account where Name = 'Account updated through apex' limit 1];
        System.debug('Account Record: ' + acc);

        acc.Name = 'Account Updated Today';
        acc.Type = 'Prospect';
        //persists the changes
        update acc;
        //Database.SaveResult[] srList = Database.update(acc, false);

        //The below query throws:
        //System.QueryException: List has no rows for assignment to SObject
        //acc = [Select ID, Name  from Account where Name = 'Single Account Creation' limit 1];
    }

    public static void deleteRecords()
    {
        //Delete a record
        //Use only when you are certain about SOQL returning single record.
        //If you get more than one record or no record, the the DML statement will fail
        Account acc = [Select ID, Name  from Account where Name = 'Account Updated Today' limit 1];
        System.debug('Account Record: ' + acc);

        delete acc;
        //System.debug('Account Record: ' + acc);
    }

    public static void undeleteRecords()
    {
        //UnDelete a record
        //Use only when you are certain about SOQL returning single record.
        //If you get more than one record or no record, the the DML statement will fail
        Account acc = [Select ID, Name  from Account where Name = 'Account Updated Today' limit 1];
        System.debug('Account Record: ' + acc);

        delete acc;
        //System.debug('Account Record: ' + acc);

        undelete acc;

        Account accNew = new Account(Name = 'Account for Undelete');
        insert accNew;
        System.debug('Account Record: ' + accNew);
        delete accNew;

        //All ROW - Retrive all the records for a 1) particular Object, 2) aggregared relationships records, 3) deleted records 4) archived records
      
        List<Account> accList = [Select ID, Name  from Account where Name = 'Account for Undelete' ALL ROWS];
        undelete accList;
    }

    public static void upsertRecords()
    {

        //Insert or Update record
        //Use when you are not sure about the Id exsistance
        Account acc = [Select ID, Name from Account where Name = 'Account Updated Today' limit 1];
        acc.Type = 'Customer';
        Account acc1 = new Account(Name = 'Account Upsert1');
        Account acc2 = new Account(Name = 'Account Upsert2');   
        Account[] accList = new List<Account>();
        accList.add(acc1); //inserted
        accList.add(acc2); // inserted
        accList.add(acc); // updated

        //Upsert Operation
        //RecordId is mandatory and is used to upsert the record in the system.
        //system.debug('Upsert Result: ' + Database.upsert(accList, false));
        upsert accList;

        //merge acc1 acc2; 
    }
}
