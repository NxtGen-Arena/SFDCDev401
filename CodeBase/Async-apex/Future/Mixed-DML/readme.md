## Use Case

When a new Trainee (Contact) is created:

- Create a User login for the trainee
- Assign a Permission Set
- Update the Contact record with User details

This causes Mixed DML because:
* User, PermissionSetAssignment → Setup objects
* Contact → Non-setup object

## Solution: Use @future Method

- Do non-setup DML first
- Move setup object DML to a @future method
- Salesforce runs it in a separate transaction
