# Business Requirement Document

**Title**: Automating Account Contact Rollup

**Purpose**: To ensure the accurate tracking of the number of Contacts associated with each Account in the Salesforce system by automatically

**Background**:

Sales teams require real-time visibility into the total number of Contacts linked to each Account for effective account management and reporting. Manual updates to track these counts are error-prone and inefficient. Automating this process will enhance data accuracy and save time.

**Discovery Questions:**

1. Custom fields to track all these counts on the Account level.
2. Do we have record type "Instructor" on contact or is there any other way we identify the Contact as "Instructor"
3. Object to trigger the execution on: Contact
4.  When should the count updated:
     * New Contact is created
     * Contact is Updated - Existing Contact is updated to chnage the Account linked
     * Contact is deleted
5. What needs to be updated: Account. No_of_Contacts__c
6. Is it everytime or on certain conditions:
   * Contact has account populated
   * Account linked on contact is changed
   * When Contact is of type Instructo
7. DML Events
   * After Insert
   * After Update
   * After Delete
8. Is there any Large Data Volume of these reocrds being pushed from any other sources - manual data import, Integration, sync
9. If ans to 6 is yes. Do we need the execution immediately? or it can be scheduled?

**Scope**: 
Defined based on the discovery questions and then approved from client

* Automatically update the Contact_Count__c field on the Account object whenever a new Contact is inserted.
* Ensure the solution handles multiple Contact inserts in bulk efficiently.
* Count should be updated based on Contact addition or removal.

## Functional Requirements:

**When a Contact record is inserted:**

- If the Contact is associated with an Account, the Contact_Count__c field of the corresponding Account should increment by 1.
- If multiple Contact records are inserted in bulk, ensure the total count is updated accurately for each relevant Account.
- The solution should only update Accounts that are impacted by the new Contacts.

## Non-Functional Requirements:

- The implementation must comply with Salesforce governor limits (e.g., SOQL queries, DML operations).
- Bulk data processing must be supported, with no degradation in performance.
- Trigger logic should be separated from business logic to facilitate maintainability and scalability.

## Solution Design:

**Trigger**:
Create an after insert trigger on the Contact object to handle the event when a Contact is added.

**Handler Class:**

- Use an Apex handler class (ContactTriggerHandler) to process business logic:
- Gather impacted Account IDs and count the number of new Contact records per Account.
- Query relevant Accounts to fetch the current value of the Contact_Count__c field.
- Update the Contact_Count__c field with the new count.
- Perform a bulk DML update on the Account records.

**Data Model Impact:**

Custom Field to be created:

| Object |Field Name | Data Type| Description|
|---------|-----------|----------|------------|
| Account | Contact_Count__c | Number (2,0)|Tracks the total number of Contacts associated with the Account.|


## Assumptions and Constraints:

- All Contact records have a valid AccountId field if linked to an Account.
- No validation rules or triggers exist on the Account object that would conflict with this solution.

## Testing Plan:

**Unit Tests:**

- Insert a single Contact and verify the Contact_Count__c field on the associated Account is updated correctly.
- Insert multiple Contact records in bulk and verify accurate updates for all associated Accounts.

**Edge Cases:**

- Insert Contact records without an AccountId to ensure no unnecessary updates occur.
- Validate behavior with no impacted Accounts.

**Load Testing:**

Test with bulk inserts (up to Salesforce bulk limits) to ensure governor limits are respected.

**Benefits**:
- Improved data accuracy for reporting and analysis.
- Reduced manual effort for users.
- Scalable and maintainable architecture for future enhancements.

## Business Requirement:

To ensure the accurate tracking of number of Active, Inactive and Total Instructors aassociated with the Institute.

**Psuedo Logic:**

1. Retrieve all the contacts being inerted, updated,deleted
2. Check if the contact has linked account, or if the account linked on contact has been updated.
3. Account Ids related to these impacted contacts and Contact records per Account
4. Query relevant accounts to fetch the current value of the No_of_Contacts__c
5. Update the No_of_Contacts__c field with the new count
6. Perform bulk dml to update the account records
     
## Solution:

[ContactTrigger.Trigger](/CodeBase/Triggers/Contacttrigger.trigger) 

[ContacttriggerHandler.cls](/CodeBase/Triggers/ContacttriggerHandler.cls)

