# Business Requirement Document

**Title**: Vendor account with active opportunities should not be deactivated.

**Purpose**: For not losing on the opportunities to win. Revenue loss would incurr in these cases.

**Discovery Questions:**

1. How do you idneitfy the vendor accounts?
2. Do we have a field to deactivate the account? or we need new field?
3. Which opportunitiy status is considered as "Open"


## Functional Requirements:

**When an Account is being deactivated :**

- Check if there are opportunities associated.
- If yes, check the stage values which are considered Open
- Add an error

## Non-Functional Requirements:

- The implementation must comply with Salesforce governor limits (e.g., SOQL queries, DML operations).
- Bulk data processing must be supported, with no degradation in performance.
- Trigger logic should be separated from business logic to facilitate maintainability and scalability.

## Solution Design:

**Trigger**:

Events: Before Update


**Handler Class:**

- Use an Apex handler class (ContactTriggerHandler) to process business logic:
- Gather impacted Account IDs and count the number of new Contact records per Account.
- Query relevant Accounts to fetch the current value of the Contact_Count__c field.
- Update the Contact_Count__c field with the new count.
- Perform a bulk DML update on the Account records.


**Psuedo Logic:**

1. Retrieve all the Accounts being updated
2. Iterate over the accounts list
3. Retrieve opportunities for the account being updated. Vendor account with Active__C = false and prior Active__c = true
4. Check if there is any opportunity with open stage
5. Add error

   
## Solution:

[ContactTrigger.Trigger](/CodeBase/Triggers/Contacttrigger.trigger) 

[ContacttriggerHandler.cls](/CodeBase/Triggers/ContacttriggerHandler.cls)
