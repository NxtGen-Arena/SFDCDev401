## Business Scenario

Create a field on Account and Opportunity -- Minimum And Max Date ,
Once an Opportunity is delete insert update Account Min And Max Date from the All Opportunity

1️⃣ Field Design
🔹 Account Object (Custom Fields)

Create these Date fields on Account:

Field Label	API Name
Minimum Opportunity Date	Min_Opportunity_Date__c
Maximum Opportunity Date	Max_Opportunity_Date__c

👉 These will store earliest & latest Opportunity dates

🔹 Opportunity Object

We’ll use standard CloseDate
(no extra field needed unless your requirement explicitly wants custom date fields)

2️⃣ Business Rule Recap

Whenever an Opportunity is Inserted / Updated / Deleted / Undeleted:

Recalculate MIN & MAX CloseDate

Update the parent Account

⚠️ Especially important on delete → values must be recalculated from remaining Opportunities.
