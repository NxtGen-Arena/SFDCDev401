# DML in Apex

## What is DML?
Apex is tightly integrated with the Lightning Platform persistence layer. Records in the database can be inserted and manipulated through Apex directly using simple statements. Database Manipulation Language (DML) operations in Apex are fundamental for interacting with data within Salesforce. 

In contrast to the SOQL language, which is used for read operations (querying records), DML is used for write operations.

## Why we need DML Operations in Apex:
![image](https://github.com/user-attachments/assets/e9890e04-9c2d-4ec1-a158-422d0377a710)

## How to use DML in Apex?

1. Standalone DML
   Single or collections can be inserted but if either of the records fail all records DML is rolled back.
   List<Account> lstAccounts = [SELECT Id,Name FROM Account];
   
2. Database Methods
   Allows to partially perform DML on records. Developers can track success and failures of the records. Partial processing only processed when 
   the AllOrNone falg is set as false.

## Transaction Boundaries

* In Apex, each DML operation is executed within a transaction boundary.
* A transaction represents a series of operations that are executed as a single unit of work.
* Transactions ensure that either all DML operations within the transaction are completed successfully or none of them are.
* This atomicity guarantees data consistency and prevents partial data modifications.

  ## DML Operations in Apex:

|DML Operation| Details |syntax
|-----------|---------|--------|
|Insert | Adds one or more new records to the database. | Account acc = new Account(Name ='test'); insert acc;
|Update | Modifies one or more existing records in the database. Id required.| Account acc = [SELECT Id,Name FROM Account LIMIT 1]; acc.Type = 'Customer'; Update acc;
|Delete |Removes one or more records from the database. |Account acc = [SELECT Id,Name FROM Account LIMIT 1]; Delete acc;
|Upsert | Inserts records if they are new or updates them if they exist. Uses the “External Id” marked as unique for custom objects. If no other External Id is defined “Record Id” is used as matching key. If the record ID is null the sObject will be inserted, otherwise an update will be performed.
|Undelete | Restores records that were previously deleted and are in the Recycle Bin.
|Merge |Combines up to three records of the same object into one record.
| ConvertLead | Programmatically convert lead into Account, Contact and Opportunity.


>[!TIP]
>ALL ROWS keyword in SOQL allows to retrieve the deleted records.
>List<Account> lstAccounts = [SELECT Id, Name FROM Account ALL ROWS];

> [!IMPORTANT]
> After a successful insert, the variable that holds the SObject instance is updated with Id.

<h2> Best Practices</h2>
   
1. Don't run DML statements on null elements. Always check using _.isEmpty_ on collections to check if the list contains elements
2. Bulkification: Perform DML operations on collections of records to optimize performance and avoid hitting governor limits.
3. Error Handling: When performing DML operations in Apex, it’s essential to handle potential errors gracefully. Common errors include DML exceptions due to validation rules, duplicate record errors, or governor limit exceptions. Utilize try-catch blocks to capture and handle exceptions appropriately, providing meaningful error messages to users and logging errors for troubleshooting purposes.
4. Governor Limits: Be mindful of Salesforce governor limits and design your code to stay within those limits
      
</Details>

