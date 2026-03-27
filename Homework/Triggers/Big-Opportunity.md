# Auto-Mark Opportunity as “Big Opportunity” 

## Business Challenge:
Currently Leaders are facinf challgenges with reporting on Cosed-Lost opportunities. They do not have full visibility into why the deal was lost and competitir in case we lost it to the competitor.

## Business Requirements:

Business wants to automatically flag and update any Opportunity as Big/Strategic, when:

- Amount ≥ 5,00,000 (INR/USD depending on org)
- Stage is “Proposal/Price Quote” OR beyond

When these conditions are met, update:
- Big_Opportunity__c = TRUE
- Priority__c = “High”
- Send for Review = TRUE (optional)
- If criteria later become false, set Big Opportunity back to FALSE.



## Data Model:

1. Create new field on the Opportunity Big_Opportunity__c.


## Psuedo Logic:

- Event - 
- Object for Trigger: Opportunity



## Demo Class and Trigger:

* [Opportunity.trigger](/CodeBase/Triggers/OpportunityTrigger.trigger)
* [OpportunityHandler.cls](/CodeBase/Triggers/OpportunityHandler.cls)
* [AccountDeletion.trigger](/CodeBase/Triggers/AccountDeletion.trigger)
