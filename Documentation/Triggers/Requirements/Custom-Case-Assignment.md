Scenario — Custom Case Assignment Matrix
Business Requirement

## Business Case

A Training Institute Support Center wants to assign Cases dynamically based on multiple parameters:

- Inquiry Type (Course / Vendor / Student Support)
- Course Category (Admin / Developer / Integration)
- Customer Tier (Standard / Premium)
- Region (APAC / EMEA / US)
- Case Priority

Because assignment depends on multiple combined conditions, the business wants an Assignment Matrix table that admins can update without changing rules.

## Why Standard Assignment Rules Are Not Enough

**Standard Assignment Rules limitations:**

* Limitation	Impact
* Hard-coded rule entries	Hard to maintain
* No dynamic lookup from table	Cannot use matrix logic
* Complex multi-criteria logic difficult	Rules become very long
* Admin changes require rule restructuring	Maintenance heavy

Therefore organizations implement:

Custom Assignment Matrix Object + Apex Trigger

<h2>Solution Design</h2>

## Step 1 — Create Custom Object

<h3> Case_Assignment_Matrix__c</h3>

Fields:

|Field|	Type|
|-----|-----|
|Inquiry_Type__c|Picklist
|Course_Category__c	|Picklist
|Customer_Tier__c	|Picklist
|Region__c	|Picklist
|Priority__c|	Picklist
|Assigned_Queue_Id__c	|Text / Lookup Queue

Admins maintain routing rows like:

|Inquiry|Category	|Tier	|Region|	Priority	|Queue
|-------|-------|-----|-----|------|-----|
|Course	|Developer	|Premium	|APAC	|High|	L2 Dev Queue

## Step 2 — Trigger Logic

When Case is created:

- Read Case attributes
- Find matching matrix row
- Assign case owner to mapped queue

## Implementation

Apex Trigger Example
Trigger

```
trigger CaseAssignmentTrigger on Case (before insert) {
    CaseAssignmentHandler.assignCases(Trigger.new);
}
```

Handler Class

```
public class CaseAssignmentHandler {

    public static void assignCases(List<Case> caseList){

        Set<String> inquiryTypes = new Set<String>();
        Set<String> regions = new Set<String>();

        for(Case c : caseList){
            if(c.Inquiry_Type__c != null)
                inquiryTypes.add(c.Inquiry_Type__c);

            if(c.Region__c != null)
                regions.add(c.Region__c);
        }

        if(inquiryTypes.isEmpty() || regions.isEmpty()){
            return;
        }

        // Query Assignment Matrix once
        List<Case_Assignment_Matrix__c> matrixList =
            [SELECT Id, Inquiry_Type__c, Region__c, Assigned_Queue_Id__c
             FROM Case_Assignment_Matrix__c
             WHERE Inquiry_Type__c IN :inquiryTypes
             AND Region__c IN :regions];

        Map<String, Id> assignmentMap = new Map<String, Id>();

        for(Case_Assignment_Matrix__c m : matrixList){
            String key = m.Inquiry_Type__c + '-' + m.Region__c;
            assignmentMap.put(key, m.Assigned_Queue_Id__c);
        }

        // Assign owner dynamically
        for(Case c : caseList){
            String key = c.Inquiry_Type__c + '-' + c.Region__c;

            if(assignmentMap.containsKey(key)){
                c.OwnerId = assignmentMap.get(key);
            }
        }
    }
}
```

<h2> Solution 2</h2>

### Create CMDT:

Case_Assignment_Matrix__mdt

Fields:

|Field|	Type
|-----|-----
|Inquiry_Type__c|	Picklist/Text
|Region__c|	Text
|Assigned_Queue_Id__c|	Text(18)

### Updated Bulk-Safe Handler Using CMDT

Key difference:

- Uses Case_Assignment_Matrix__mdt.getAll()
- No SOQL required

```
public class CaseAssignmentHandler {

    public static void assignCases(List<Case> caseList){

        // Load CMDT into memory (cached)
        Map<String, Case_Assignment_Matrix__mdt> matrixMap =
            Case_Assignment_Matrix__mdt.getAll();

        // Build routing lookup map
        Map<String, Id> routingMap = new Map<String, Id>();

        for(Case_Assignment_Matrix__mdt m : matrixMap.values()){
            String key = m.Inquiry_Type__c + '-' + m.Region__c;
            routingMap.put(key, (Id)m.Assigned_Queue_Id__c);
        }

        // Assign cases
        for(Case c : caseList){
            if(c.Inquiry_Type__c == null || c.Region__c == null)
                continue;

            String key = c.Inquiry_Type__c + '-' + c.Region__c;

            if(routingMap.containsKey(key)){
                c.OwnerId = routingMap.get(key);
            }
        }
    }
}
```

### Test Class (CMDT-based)

In tests, CMDT records can be created directly.

```
@isTest
public class CaseAssignmentCMDTTest {

    @isTest
    static void testAssignment(){

        // Create Queue
        Group q = new Group(Name='CMDT Queue', Type='Queue');
        insert q;

        // Create CMDT routing row
        Case_Assignment_Matrix__mdt cmdt =
            new Case_Assignment_Matrix__mdt(
                DeveloperName = 'Course_APAC',
                MasterLabel = 'Course APAC',
                Inquiry_Type__c = 'Course',
                Region__c = 'APAC',
                Assigned_Queue_Id__c = q.Id
            );
        insert cmdt;

        Case c = new Case(
            Subject='Test Case',
            Inquiry_Type__c='Course',
            Region__c='APAC'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case insertedCase =
            [SELECT OwnerId FROM Case WHERE Id=:c.Id];

        System.assertEquals(q.Id, insertedCase.OwnerId);
    }
}
```

## Why CMDT Version Is Better (Enterprise Reason)

Custom Object Matrix	| CMDT Matrix
|-------|-----|
|Requires SOQL query|	Cached, faster
|Data changes require data migration |	Deployable metadata
|Counts against governor limits|	Does not
|Slower for large routing tables	|Optimized for routing frameworks

This is the standard architecture used in large global support routing frameworks.

[NOTE] Very Important Senior-Developer Insight

Large implementations usually combine:
- CMDT Assignment Matrix
- Trigger/Flow routing
- Omni-Channel queue routing
- Priority fallback routing to build metadata-driven routing engines that require zero code changes when routing logic changes.
