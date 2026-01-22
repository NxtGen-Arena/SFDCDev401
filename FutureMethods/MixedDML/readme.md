🧠 Trigger-Based Mixed DML – Real Scenario

🏫 Training Institute Use Case

When a Trainer User is created:

1. Create a Trainer Profile record (Custom Object – NON-SETUP)
2. Assign Trainer Permission Set (SETUP Object)

⚠️ Trigger runs in single transaction → causes Mixed DML

❌ BAD DESIGN (For Explanation Only – Will Fail)

```
// ❌ DO NOT DO THIS – Mixed DML Error
trigger UserAfterInsert on User (after insert) {
    for(User u : Trigger.new) {
        insert new Trainer_Profile__c(
            Name = u.Name,
            Trainer_User__c = u.Id
        );

        // SETUP Object DML in same transaction ❌
        PermissionSetAssignment psa = new PermissionSetAssignment(
            AssigneeId = u.Id,
            PermissionSetId = '0PSXXXXXXXXXXXX'
        );
        insert psa;
    }
}
```
❌ Error:
DML operation on setup object is not permitted after you have updated a non-setup object

**Correct Trigger-Based Solution (Best Practice)**

**🧩 Architecture Pattern Used**

```
Trigger → Handler → Service → @future
```
