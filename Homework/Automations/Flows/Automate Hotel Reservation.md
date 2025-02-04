# Automate Hotel Reservation Confirmation Using Flows in Salesforce

## Challenge
RoyalSuite Hotel has recently started using Salesforce to manage their room reservations. Currently, entire process is manual and time consuming. They are looking for automation to support their new reservations, cancellations, check in and check out process. 

## Solution
* Implement the flow to automte the actions to be performed manually.
* Use Custom Metadata to select the email notification to be sent. 
* Create Lightning email templates for notifications.
* Handle errors gracefully.
* Select the appropriate flow types. and justify why you choose the specific flow type.

## Business Requirements

## New Reservation Confirmed:
* when a new reservation is created and is confirmed, send a confirmation email to the guest with their booking details.
* The email should include the guest’s name, check-in date, check-out date, and room type.

## Reminder Email One Day Before Check-in
Send Email reminding the guest about their upcoming stay one day before check-in date.

## Cancellation Notification
Send a cancellation email to the guest.

## VIP Guest Special Services
if the Guest is a VIP, trigger an internal email to the hotel staff to prepare special arrangements.

## Post Check-Out Feedback Request
Send an email to the guest with a link to a customer satisfaction survey.

## Room Upgrade Suggestion
If the reservation is for more than 7 days, send an email suggesting a room upgrade.

**Technical Requirements**

Create all the required fields to build this automation.
  
| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Reservation|Reservation Name |Auto-number| Booking-0000|
|Reservation|Guest Name |Guest|Lookup filter (Contact = guest)|
|Reservation|Check-in Date |Date|
|Reservation|Check-out Date |Date|
|Reservation|Room |Lookup(Room)|Assigned room.|
|Reservation|Status |Picklist|Pending, Confirmed, Canceled|
|Reservation|Booking Staff |Lookup(Contact)|Lookup filter (Contact = Staff)|


| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Contact|Name|Text|
|Contact|Email|Email|
|Contact|Is VIP?|Checkbox|

| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Room|Room Type |Picklist|Standard, Deluxe, Suite|
|Room|Room Rate |Currency|Cost per Night|
|Room|Is Available? |Checkbox|Confim if the room is still available|
