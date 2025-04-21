# Extending functionality using Extensions

<h2> Assignment 1: Update the AccountControllerPage </h2>

1. Use ApexPages.addMessage() for error messages.
2. Handle errors with try and catch blocks.
3. Add null checks.

<h2> Assignment 2: Setup Hotel Registration </h2>

🏨 Use Case Overview: Hotel Registration 

We want to allow hotel front desk staff to: 

* Search for a hotel and guest (Account & Contact).
* Create a new registration for the guest.
* Auto-populate today's check-in date.
* Validate required fields.

🛠️ Steps to Complete the Exercise

✅ Step 1: Create the Apex Controller Extension
**Class Name:** HotelRegistrationExtension

**Requirements**:
* Accept ApexPages.StandardController in constructor.
* Access the record using controller.getRecord().
* In the constructor:
  * Set the default CheckInDate__c to today if not already set.
* Add method public PageReference saveRegistration() that:
  * Validates: Check-out date must be after Check-in date.
  * Inserts the Registration__c record.
  * Calls sendConfirmationEmail() (a private method).
  * Redirects user to a confirmation page or same page with success message.

✉️ Email Requirements:
Send to the Guest__r.Email (from lookup).

Use a simple Messaging.SingleEmailMessage.

✅ Step 2: Create the Visualforce Page

**Page Name:** HotelRegistrationPage

**Requirements**:

* Use standardController="Registration__c" and extensions="HotelRegistrationExtension"
* Include input fields:
  * Hotel
  * Guest
  * Check-in Date
  * Check-out Date
  * Room Preference
* Add a Save button that calls saveRegistration().
* Display success or error messages with <apex:messages />.

✅ Step 3: Test the Page

Preview using URL: /apex/HotelRegistrationPage?id={record_id}
Use a Guest and Hotel already in the system.

Test with:
Valid dates (email should send)
Invalid dates (error should display)
Empty fields (should validate automatically)
