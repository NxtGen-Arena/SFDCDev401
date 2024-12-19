## Business Requirement:

To ensure the accurate tracking of number of Active, Inactive and Total Instructors aassociated with the Institute.

**Discovery Questions:**

1. Custom fields to track all these counts on the Account level.
2. Do we have record type "Instructor" on contact or is there any other way we identify the Contact as "Instructor'

## Technical Challenges

Account and contact has special relationship. So, even though they are M-D , rollup-summary fields are not allowed on the Account. 

Approach 1: Use Flows
Approach 2: Apex Code

1. Object to trigger the execution on: Contact
2. When should the count updated:
   * New Contact is created
   * Contact is Updated - Existing Contact is updated to chnage the Account linked
   * Contact is deleted
     
3.What needs to be updated: Account. No_of_Contacts__c 
4. Is it everytime or on certain conditions:
   * Contact has account populated
   * Account linked on contact is changed
   * When Contact is of type Instructor
5. Event
   * After Insert
   * After Update
   * After Delete
6. Is there any LDV of these reocrds being pushed from any other sources - manual data import, Integration, sync
7. If ans to 6 is yes. Do we need the execution immediately? or it can be scheduled?

Psuedo Logic:

1. Retrieve all the contacts being inerted, updated,deleted
2. Check if the contact has linked account, or if the account linked on contact has been updated.
3. Account Ids related to these impacted contacts and Contact records per Account
4. Query relevant accounts to fetch the current value of the No_of_Contacts__c
5. Update the No_of_Contacts__c field with the new count
6. Perform bulk dml to update the account records
     

  
