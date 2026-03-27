# Service Ticket Management System 

## Company Background
XYZ Tech Solutions is a medium-sized IT support and solutions provider. The company offers various services, including network setup, hardware troubleshooting, software installation, and cybersecurity. The company has a growing client base and a dedicated team of IT support engineers. 

## **Business Requirements **
XYZ Tech Solutions needs a robust Service Ticket Management System to streamline the process of handling IT support requests from clients. The system should automate various tasks, including ticket assignment, status updates, SLA tracking, email notifications, and reporting. 

**Note: **
Validate the requirements and create the custom objects, fields as needed for implementation. Document the changes. 

### Use Case Scenarios

| Scenario|Triggering Event|Flow actions|Comments|
|-------|----------|---------|--------|
| New Service Ticket Creation and Assignment |Status = new                    |1. Update Same Record: Set the initial status of the ticket to "New."                                |Calculate and set the expected resolution date based on the SLA for the client's service level. 
|                                            |                                |2. Create New Record: Create a related task for the IT support engineer to review the ticket details.|
|                                            |                                |3. Update Existing Records: Update the client’s record to reflect the new ticket creation.           |
|                                            |                                |4. Send Email Notification: Send an email to the assigned support engineer with ticket details.      |
| Ticket Status Update                       | status = "In Progress." |1.Update Same Record: Set the timestamp for when the ticket was moved to "In Progress."          |Calculate the remaining time to meet the SLA and update the ticket record. 
|                                            |                                |2. Update Existing Records: Update the assigned support engineer's record to reflect the current ticket assignment. |
|                                            |                                |3. Send Email Notification: Notify the client that their ticket is being worked on.          |
|                                            |                                |4. Send Email Notification: Send an email to the assigned support engineer with ticket details.      |
| Ticket Resolution and Closure              |status = "Resolved."            |1. Set the timestamp for when the ticket was resolved and change the status to "Closed" after 24 hours. |Calculate and log the total time taken to resolve the ticket. 
|                                            |                                |2. Log a case closure report in the client's record. |
|                                            |                                |3. Update the support engineer's performance metrics.          |
|                                            |                                |4. Send a resolution email to the client, including a feedback form.      |
| SLA Breach Alert                           |SLA Breach Time < 2 days, < 5 days |1. Flag the ticket as "At Risk" for SLA breach.  |Calculate and log the total time taken to resolve the ticket. |Calculate the potential penalty for the SLA breach and log it in the ticket record.
|                                            |                                |2. Update the client and support engineer records with an SLA breach warning.  |
|                                            |                                |3. Send a high-priority email to the support engineer and their manager.          |


### Formulas

* Expected Resolution Date = Current Date + SLA Duration
* SLA Duration (days) = Calculate based on the Status (Critical (1 day), High (2 day), Medium (3 days), low (5days))


SLA Compliance: Helps ensure tickets are resolved within the agreed service levels, improving client satisfaction. 

Performance Tracking: Enables performance tracking and reporting for support engineers, fostering accountability and continuous improvement. 

 
