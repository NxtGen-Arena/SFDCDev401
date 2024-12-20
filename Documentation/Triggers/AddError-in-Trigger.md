# Prevent Database Transaction using Triggers

The addError method in Apex is used to display an error message on a specific field or on the record as a whole. This is particularly useful in trigger, controller, or validation logic when you want to prevent a transaction from completing due to some custom business rules.

## Usage

* On a Specific Field: You can attach the error message to a specific field of a record. This highlights the field in the UI with the provided error message.
* On the Record Level: You can add the error message to the entire record. This is useful when the error isn't specific to a single field.

## Syntax

```
record.<fieldName>.addError('Error message');
record.addError('Error message');

```
## Examples

**1. Adding Error to a Field**

This example prevents an Opportunity from being saved if the Amount field is less than or equal to zero:

```
trigger ValidateOpportunity on Opportunity (before insert, before update) {
    for (Opportunity opp : Trigger.new) {
        if (opp.Amount <= 0) {
            opp.Amount.addError('Amount must be greater than zero.');
        }
    }
}

```
**2. Adding Error to the Record**

This example prevents an Account from being saved if there are duplicate Account Names:

```
trigger CheckDuplicateAccount on Account (before insert, before update) {
    Set<String> accountNames = new Set<String>();
    for (Account acc : Trigger.new) {
        accountNames.add(acc.Name);
    }
    
    Map<String, Account> existingAccounts = new Map<String, Account>(
        [SELECT Name FROM Account WHERE Name IN :accountNames]
    );

    for (Account acc : Trigger.new) {
        if (existingAccounts.containsKey(acc.Name)) {
            acc.addError('An account with this name already exists.');
        }
    }
}
```

> [!IMPORTANT] **Key Notes**

> - addError prevents the record from being saved to the database.
> - It rolls back any DML operations that were part of the same transaction.
> - Error messages added using addError are displayed in the Salesforce UI when using standard pages. For custom UIs, you may need to explicitly handle the errors.
