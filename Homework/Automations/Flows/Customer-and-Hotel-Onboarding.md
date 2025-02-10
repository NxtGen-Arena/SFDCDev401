# Screen flow for Quick Create of Hotel and Customer

## Challenge
RoyalSuite Hotel needs an easy way to Create New Customers and Staff Members under Hotel. Each need different data to be captured and sometimes it;s a time consuming process.

## Solution
* Implement the flow to automate the actions to be performed manually.
* Use Custom Metadata to select the email notification to be sent. 
* Create Lightning email templates for notifications.
* Handle errors gracefully.
* Select the appropriate flow types. and justify why you choose the specific flow type.

## Business Requirements

Identify the key fields. Mark then required based on your assumptions.

## New Customer Onboarding:

* Capture customer details - Name, Email and Phone.
* Check for duplicate customers (based on email & phone). If existing customer display details and ask if any updates required. 
* If record does not exist, create new Customer and display link to the newly created Account. Update later to redirect to created record.
* Create a new text template for informing customer.
* Create new sub-flow to process flow errors. Use them in all the flow fault elements. Customize error category and message
* Store whome to notify in the custom metadata.
  
## New Staff Onboarding:

* Search for Hotel based on Name and Branch Location. Display hotel details. 
* Capture staff details - Name, Email, Address, Emergency Contact.
* Assign roles & permission sets.
* Allocate to a specific hotel branch.
* Display # of Active staff members on Hotel.

## Object Data Model

Hotel (Contains hotel information)

| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Account|Hotel Id|Auto-Generated|
|Account|Hotel Name|Name|
|Account|Email |Email|
|Account|Branch |Picklist|Region Values
|Account|Phone |Number|
|Account|Address|Shipping Address|
|Account|No of Rooms |Number|
|Account|No of Staff |Number|

Customer (Stores guest details)

| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Contact|Customer Id|Auto-Generated|
|Contact|First Name|FirstName|
|Contact|Last Name |LastName|
|Contact|Email |Email|
|Contact|Phone |Number|
|Contact|Address|MailingAddress|
|Contact|Is VIP?|Checkbox|
|Contact|Preferred Hotel|lookup|

Staff (Stores employee details)

| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Contact|Staff Id|Auto-Generated|
|Contact|First Name|FirstName|
|Contact|Last Name |LastName|
|Contact|Email |Email|
|Contact|Phone |Number|
|Contact|Address|Checkbox|
|Contact|Role|Picklist|Receptionist, Manager, Housekeeping
|Contact|Hotel|lookup|
|Contact|Emergency Contact|lookup


## Capture Customer Information

**Screen Components:**

**Customer Info Screen:**

1. Input fields for First Name, Last Name, Email, Phone, Address. Click "Next" button
2. Check for Duplicates (Decision Element + Lookup Component)
3. Use Lookup Component to search the Customer Object
4. Check if Email or Phone already exists
5. If duplicate found: Show a warning message and allow the user to update existing details
6. If no duplicate: Proceed to hotel selection

**Search & Select Hotel (Data Table & Lookup Component)**
1. Search Filters: Hotel Name & Location
2. Use a Data Table to display matching hotels
3. Select a hotel and store its Hotel ID
