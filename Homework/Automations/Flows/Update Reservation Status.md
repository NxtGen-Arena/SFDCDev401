# Update Reservation Status for Guests 

## Challenge
RoyalSuite Hotel enables users and agents to create reservation request through external systems and internal booking portal. when a new reservation is made via an external system or an internal booking portal, they need the Reservation record in Salesforce to be updated with all the details recevied from external system.

## Solution
* Use Platform triggered flows where the external system will publish the creation or updation of the Reservation.
* Based on the event insert or update the Reservation in the system.

## Business Requirements

## Reservation Status Changes:
* when a new reservation is created or is confirmed through external systems, upddate the Reservation details on Salesforce as well.

**Technical Requirements**

Create all the required fields to build this automation. Consider the unique or external Ids needed to maintain data integrity.
  
| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Reservation|Reservation Id |Text| External Id (Unique)|
|Reservation|Guest Name |Guest|Lookup filter (Contact = guest)|
|Reservation|Check-in Date |Date|
|Reservation|Check-out Date |Date|
|Reservation|Room Type |Picklist|Standard, Deluxe, Suite|
|Reservation|Status |Picklist|Pending, Confirmed, Canceled|
|Reservation|Booking Staff |Lookup(Contact)|Lookup filter (Contact = Staff)|

| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Hotel_Reservation_Event__e|Reservation |Text| Stores reservation Id generated from external system.|
|Hotel_Reservation_Event__e|Guest Name |Text|Name of the guest booking the Hotel|
|Hotel_Reservation_Event__e|Guest Email |Text|Email for the guest|
|Hotel_Reservation_Event__e|Check-in Date |Date|
|Hotel_Reservation_Event__e|Check-out Date |Date|
|Hotel_Reservation_Event__e|Room Type |Picklist|Standard, Deluxe, Suite|
|Hotel_Reservation_Event__e|Status |Picklist|Pending, Confirmed, Canceled|
|Hotel_Reservation_Event__e|Hotel |Text|Hotel under which booking should be made|


| Object|Field Name|Data Type|Comments|
|-------|----------|---------|--------|
|Contact|Name|Text|
|Contact|Email|Email|

