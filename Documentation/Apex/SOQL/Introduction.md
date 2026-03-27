# SOQL in Salesforce

We need to retrive data for mulitple reasons - Data Backup, Data Validation, Data Cleanups, Analytics and many more. Data is heart of your business and in order to build the applications which can support this data and process it efficiently we need equally strong way to retrieve this data.

SOQL query enclosed in [] is an expression. Two possible return types are sobject and List<sObject>. The sObject and field names in a SOQL query use the same names you use in Apex.

SOQL allows developers to query (using user-defined selection criteria) data in the Salesforce database. SOQL queries can be performed:
* On an ad-hoc basis in tools such as the Developer Console.
* Within your Apex/API code.
* VS Code SOQL builder

![image](https://github.com/user-attachments/assets/e9890e04-9c2d-4ec1-a158-422d0377a710)

>[!Note]
>The API name of an object's field is the name used in Apex to refer to a field within an sObject.

## SQL vs SOQL

|SQL | SOQL|
|-----|------|
|Support statements for querying, CRUD,transaction control, schema definition,and more|Only supports query statements
|Support SELECT*|Does not support SELECT*
|Support joins, which are written using "left" and "right" keywords |Supports "relationship queries," which are written using parent-child syntax
|Do not support dot notation syntax to traverse foreign key relationships | Supports dot notation syntax to traverse object relationships
|Are not governed by limits |Is multi-tenant aware (therefore, governed by limits)

## Structure of the SOQL

Ask the questions:

1. Which fields are being fetched?
2. From which Object is data being fetched?
3. What condition do all fetched sObjects need to meet?

```
SELECT fieldl, field2, ...
FROM object
[WHERE conditionExpression]
[LIMIT numberOfRows]
[Other options, such as GROUP BY]
```

<img width="610" alt="image" src="https://github.com/user-attachments/assets/bdd38fd5-ec0f-4d36-ba00-8323841bff54" />


## Where can we execute SOQL?

1. Developer Console
2. Reports
3. Data Export Tools - Data Loader, Workbench
4. Visual Studio - SOQL Builder
5. Apex Classes

<h2> SELECT Clause</h2>

Reserved keyword used for SOQL. Mention the API names of the fields to be retrieved Comma separated. This is Required clause in SOQL.

| To Retrieve | Format | Example | Comments
|-------------|---------|-------|----|
| Selected fields | field1,field2...| SELECT Id,Name,Supported_Regions__c FROM Account| API Names to be used
| All Fields | FIELDS (ALL) | SELECT FIELDS(ALL) FROM Account | Unbound queries so may cause performance issues. supported only in bulk, rest, soap API. 
| Custom Fields ONly | FIELDS (CUSTOM) | SELECT FIELDS(CUSTOM) FROM Account | Unbound queries so may cause performance issues. supported only in bulk, rest, soap API.
| STANDARD Fields | FIELDS (ALL) | SELECT FIELDS(STANDARD) FROM Account | Unbound queries so may cause performance issues. supported only in bulk, rest, soap API.

>[!Note]
>You can try FIELDs using Rest Explorer in the Workbench
> Login to [Workbench](https://workbench.developerforce.com/) and login with developer account
>Go to utilities >Rest Explorer
> use below to execute
>/services/data/v62.0/query?q=SELECT+FIELDS(Custom)+from+account+limit+2

<h2> WHERE Clause</h2>
Filter the queries to fetch only records to be processes. Selective queries improves the performance.

| Field Type| Format | Example
|-----------|----------------------------------|--------------------------------|
|Date values | The Date format is: YYYY-MM-DD. | ... WHERE BirthDate = 1999-01-30 
| Date Values|DateTime field values are in the Coordinated Universal Time (UTС). You may need to offset DateTime values to your local time zone (ex: -08:00).| ... WHERE ClosedDate > 2005-10-08T10:15:03-08:00
| date literals. | No single quotes required. | ... WHERE ClosedDate !- LAST_N DAYS:365
| Boolean values| Can be used directly |... WHERE IsClosed = TRUE
| Multi-picklists| Use Includes/Excludes for contains. Use Equals for exact match | WHERE Supported_Regions__c INCLUDES ('EMEA')

# Operators for Filtering Data

|Type | Operator | Comments|
|------|---------|-------|
|Arithemtic Operator| Equals (=) | 
|| Not Equals (!=) | 
|| Less Than (<) | 
|| Greater Than (>) | 
|| Less Than or Equal to (<=) | 
|| Greater Than or Equal to(>=) | 
|Logical Operators| AND|
||OR|
||NOT|
|String Operators| LIKE - Starts With (%)| SELECT Id, Name FROM Account where Name LIKE '% test'
||LIKE - End with (%)|SELECT Id, Name FROM Account where Name LIKE 'test %'
||LIKE - contains (%txt%)| SELECT Id, Name FROM Account where Name LIKE '% test %'
||IN('','')|
||NOT IN ('','')|
|Multi-Picklist Operators|Includes/Excludes('','')

# Date Literals

We can filter by Date/DateTime fields using either:
* Exact dates (e.g., 2015-04-15 and 2015-04-15T08:40:15-08:00)
* Date Literals (e.g., TODAY, THIS_WEEK, NEXT_MONTH)
  
![image](https://github.com/user-attachments/assets/4a76de30-e11d-4d33-b462-b7bca16af63d)


<img width="516" alt="image" src="https://github.com/user-attachments/assets/68dbe107-add2-4e0e-98c0-0208f4467e9a" />


