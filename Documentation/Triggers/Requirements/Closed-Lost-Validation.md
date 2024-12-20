# Making fields conditionally required

## Business Challenge:
Currently Leaders are facinf challgenges with reporting on Cosed-Lost opportunities. They do not have full visibility into why the deal was lost and competitir in case we lost it to the competitor.

## Business Requirements:

- Business wants to capture Lost reason whenever Opportunity is marked a Closed-lost
- When the Reason is "Lost to Competitor", Sales rep needs to add name of the competitor on the Opportunity.


## Data Model:

1. Create new field on the Opportunity to capture Lost Reason.
2. Need a way to stop user from saving opportunity without the Reason and Competitor.

## Psuedo Logic:

- Event - Before update
- Object for Trigger: Opportunity

- Retrieve all the Opportunities being updated
- Iterate on the list of opportunities being updated, check the Stage of the Opportunity.
- Ignore all the opportunities not in stage "Closed-lost"
- If Opportunity being updated is in stage "Closed-lost", 
  * Check if Lost Reason field is populated. If not, throw an error to user asking him to populated the reason.
- If the Lost-Reason is "Lost to Competitor", check if the name of the competitiot is populated
  * If empty, throw an error
  * else save the Opportunity.

## Demo Class and Trigger:

* [Opportunity.trigger](/CodeBase/Triggers/OpportunityTrigger.trigger)
* [OpportunityHandler.cls](/CodeBase/Triggers/OpportunityHandler.cls)
