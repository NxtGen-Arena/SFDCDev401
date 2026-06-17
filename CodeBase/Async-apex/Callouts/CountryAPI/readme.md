🌍 Batch Apex Callout Example: REST Countries API

## Use Case:

Customer is maitaining country codes in a custom object Country__c with a field AlphaCode__c.They want to enrich it with the country name from the REST Countries API using its 2-letter code (e.g., "IN", "US").

### Step 1: Create Custom Object and Fields

|Object	|Field	|API Name|	Type
|----|----|----|---|
|Country__c	|Alpha Code|	AlphaCode__c|	Text(2)
|Country Name|	CountryName__c	|Text(100)

### Step 2: Create Batch Apex Class

### Step 3: Remote Site Setting

**Why Do We Need Remote Site Settings?**

Salesforce blocks external callouts by default for security.To allow callouts (HTTP request to another domain), we must whitelist the domain using Remote Site Settings.

* Go to Setup → Remote Site Settings → New
* Remote Site Name: RESTCountriesAPI
* URL: https://restcountries.com
* Check “Active”

💡 Notes:

Only needed for external HTTP callouts.For internal Salesforce URLs (like callouts to Salesforce Sites), Named Credentials is preferred in newer implementations.

## Step 4: Mock Callout for Tests

| Component   | Description                                   |
| ----------- | --------------------------------------------- |
| Batch Class | Makes GET call to REST Countries API          |
| API Used    | `https://restcountries.com/v3.1/alpha/{code}` |
| Mock Class  | Simulates API response for test               |
| Remote Site | Required for `restcountries.com`              |


<img width="1366" height="1020" alt="image" src="https://github.com/user-attachments/assets/5e703cab-4571-47dd-b63f-8ae52d783d12" />

##Step 5: Implement schedulable class

```
global class CountryBatchScheduler
implements Schedulable {

    global void execute(
        SchedulableContext sc
    ) {

        Database.executeBatch(
            new CountryAPICalloutBatch(),
            50
        );
    }
}
```

##step 6: schedule a class

### Schedule From UI
Setup
 → Apex Classes
 → Schedule Apex

Select:

Job Name: Country API Sync

Class: CountryBatchScheduler

Frequency: Daily

Time:01:00 AM

### Schedule Using Apex

```
String cronExp =
'0 0 1 * * ?';

System.schedule(
    'Country API Sync',
    cronExp,
    new CountryBatchScheduler()
);
```

### Execute Manually

Anonymous Apex:

```
Database.executeBatch(
    new CountryAPICalloutBatch(),
    50
);
```

