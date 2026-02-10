
### Create an Apex trigger for Account that checks if Account Industry is blank and set the “Technology” as default.

### If the Vendor Account has open opportunities, account should not be deactivated.

### If the Account BillingAddress is updated, update the contacts MailingAddress. Admin also needs a way out to exclude contacts from this update.

### Create an Apex trigger “ClosedOpportunityTrigger” for Opportunity that adds a task to any opportunity set to 'Closed Won’. if an opportunity is inserted or updated with a stage of 'Closed Won', it will have a task created with the subject 'Follow Up Test Task'.

### Marking Contact as Primary
A)  Only one contact should be Primary. 
B) When Contact is marked as Primary, update the “Primary Contact” field on Account.
C) If the Is Primary flag is unchecked on Contact, clear the value from “Primary Contact” field on the Account.
D) If the value from “Primary Contact” field on the Account is cleared, uncheck the “Is Primary” flag from respective contact.

### Rollup Contacts on Accounts 
If new contact is added/removed on the Account, count should be updated.


