# Relationship Queries

<h2>Child to Parent</h2>

A Parent-child relationship allows to retrieve the related record’s data from Child record. Lookup and M-D both can be leveraged in this relationship.
Relationship fields (created on child side) store the related record as an ID (reference) only. So, when you query the relationship field you will get the Id of the record.
We use the “dot” notation for navigating from Child to Parent. In case of the custom fields, we replace “__c” with “__r” and use the DOT notation. 
From Child to Parent, we can traverse up to 20 levels up.

For Standard fields, verify the field API names for retrieving Id and related fields data. Often you can see these differ. For e.g: On Contact object – 
* to retrieve the Account Id we use “AccountId” 
* to retrieve the related account’s fields we use – Account.fieldAPIName (Account.Name)

<img width="380" alt="image" src="https://github.com/user-attachments/assets/5c69bae5-b10c-4078-b64b-92b1315c86dd" />

<img width="835" alt="image" src="https://github.com/user-attachments/assets/9cc9f3eb-67b7-4797-aac7-b7f55ed6e608" />

<h2>Parent to Child : Sub-Queries</h2>

* Retrieve the related child records from Parent record.
* In this query results are always multiple since the relationship is 1-Many type. So, for standard Parent to Child use the Plural labels for the relationship names.
* In Case of the Custom fields, check on the field the “Child Relationship Name” and replace the ”__c” with “__r”
* You can combine multiple sub queries within main query.

<img width="482" alt="image" src="https://github.com/user-attachments/assets/9af9cf06-a496-4603-8ebb-1a05368f3c86" />

## Finding the relationship name

<img width="539" alt="image" src="https://github.com/user-attachments/assets/1521eb21-b73b-4445-b577-697573c8f8c1" />


