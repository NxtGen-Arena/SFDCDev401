# SOQL Fun Drive - Part 1

<h3> Retrieve all the Customers from Technology industry</h3>

<h4>Pseudo Code</h4>
1. **Action**: Retrieve - SOQL
2. **Records to be retrieved Data From:** Object to be queried- Account
3. **What needs to be queried?** : Fields to be retrieved - Id,Name,Industry
4. **Need all the Records?:** Filter - Industry = Technology

```
SELECT Id,Name,Industry FROM Account WHERE Industry = 'Tehchnology' 
```

<h3> Retrieve all Customers with Name 'United' </h3>

```
SELECT Id,Name FROM Account WHERE Name LIKE '% United %' // Contains United 

SELECT Id,Name FROM Account WHERE Name LIKE 'United %' //Starts with United

SELECT Id,Name FROM Account WHERE Name LIKE 'United %' // Ends with United
```

<h3> Identify Non-Selective Queries </h3>

```
1. SELECT Id,Name FROM Contact WHERE LastName = 'Smith'  //Selective
2. SELECT Id,Name FROM Contact WHERE CreatedDate = LAST_N_Days:30  //Selective
3. SELECT Id,Name FROM Contact WHERE LastName != NULL //Non-Selective 
4. SELECT Id,Name FROM Contact WHERE Email LIKE '%@gmail.com' //Non-Selective 
```
<h4>Answer</h4>
1. Selective 
2. Selective
3. Non-Selective : Will return all the records. Pay attention to fields which are required specifically.
4. Non-Selective : The LIKE '%@gmail.com' query is non-selective because it uses a leading wildcard (%), preventing Salesforce from using indexes efficiently.

>[!Note]
>A query is selective when one of the query filters is on an indexed field and the query filter reduces the resulting number of rows below a system-defined threshold. Developers will receive an error message when a non-selective query in a trigger executes against an object that contains more than 200,000 records.
> Standard Fields indexed:
>1. Primary Keys - Id,Name, Owner fields
>2. Foreign Keyss - lookup, M-D fields
>3. Audit fields - CreatedDate,LastModifiedDate
>4. Custom field- ExternalID, Unique

<h3> Retieve all Technogy Customers with related Contacts and Opportunities </h3>

<h4>Pseudo Code</h4>
1. **Action**: Retrieve - SOQL
2. **Records to be retrieved Data From:** Object to be queried- Account, Contact and Opportunity
3. **What needs to be queried?** : Fields to be retrieved - Id,Name,Industry
4. **Need all the Records?:** Filter - Industry = Technology

<h4> Explanation:</h4>

* Since we are Querying Contact and Opportunity records related to Account from Account, we need to use sub-queries.
* For related records, use the Child Relationship Names on the lookup fields.

```
SELECT Name,Id,(SELECT Name,ID FROM Contacts),(SELECT Name, Id FROM Opportunities) 
FROM Account
WHERE Industry = 'Technology'
```

>[!Note]
> Structuring your queries this query make them readable.

<h3> Retrieve Top 5 Opportunities with highest amount, displaying Name and Amount </h3>

<h4>Pseudo Code </h4> 
1. **Action**: Retrieve - SOQL
2. **Records to be retrieved Data From:** Object to be queried- Opportunity
3. **What needs to be queried?** : Fields to be retrieved - Id,Name,Industry
4. **Need all the Records?:** Filter - Industry = Technology

>[!Note]
>Default sort order is ASC

```
SELECT Name,Amount FROM Opportunity ORDER BY Amount DESC LIMIT 5
```

<h3> Querying a Junction Object </h3>

<h4>Requirement:</h4>

Consider a custom junction object "Project_Assignment__c" that links Project__c and Employee__c.
Write a SOQL query to get all Employees assigned to a Project named "Sales Cloud Implementation".

<h4>Sample Data:</h4>

Employee__c emp = new Employee__c (Name = 'Emp1',EmpId ='101')
Employee__c emp = new Employee__c (Name = 'Emp2',EmpId ='111') - ID = 011WU00000XeAfC
Project__c projSalesCloud = new Project__c(Name = 'Sales Cloud Implementation', Project_Id = 'PRJ101') - ID = 031WU00000XeAZT
Project_Assignment__c assShubh = new Project_Assignment__c(Employee__c='Emp1',Project__c='Sales Cloud Implementation')

```
//Lookups are stored as Ids so they will return Ids. Hence we need to use the relationship "__r" 
SELECT Employee__c,Project__c FROM Project_Assignment__c //011WU00000XeAfC;031WU00000XeAZT

//This query will return Emp1, Sales Cloud Implementation along with Project's start and end date
SELECT Employee__r.Name,Project__r.Name,Project__r.Start_Date__c,Project__r.End_Date__c FROM Project_Assignment__c

//This is the query which would solve our requirement.
SELECT Employee__r.Name,Project__r.Name,Project__r.Start_Date__c,Project__r.End_Date__c 
FROM Project_Assignment__c
WHERE Project__r.Name = 'Sales Cloud Implementation'



