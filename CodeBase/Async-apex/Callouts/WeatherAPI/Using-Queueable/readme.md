# Account Weather Integration

## Business Case:
complete end-to-end demo flow for the Weather API integration using Account Billing City.

End-to-End Demo: Account Weather Integration
Business Flow
```
Account Created/Updated
        │
        ▼
     Trigger
        │
        ▼
   Queueable Apex
 (Allows Callout)
        │
        ▼
  Named Credential
        │
        ▼
   Weather API
        │
        ▼
   JSON Response
        │
        ▼
Account Updated
(Temperature, Weather)
```

### Step 1 – Create Custom Fields on Account

Object: Account

Create fields:

|Field Label	|API Name	|Type
|----|----|---|
|Temperature	|Temperature__c|Number (5,2)
|Weather Condition |	Weather_Condition__c	|Text (50)
|Humidity	|Humidity__c	|Number

These fields will store API data.

### Step 2 – Create Named Credential

Go to:
Setup → Named Credentials → New

Example:

Label | Weather API
|---|--|
Name| Weather_API
URL| https://api.openweathermap.org
Identity Type| Named Principal
Authentication| No Authentication (demo)

Save.

Step 3 – Queueable Apex Callout

Queueable is recommended because triggers should not perform synchronous callouts.

WeatherQueueable.cls


### Step 4 – Account Trigger
AccountTrigger.trigger
trigger AccountTrigger on A


### Step 5 – Mock Callout Class
WeatherMock.cls



### Step 6 – Test Class
WeatherQueueableTest.cls



## Process:

1️⃣ Trigger fires
2️⃣ Queueable executes callout
3️⃣ Weather API returns data
4️⃣ Account updated

Result:

|Field	|Value|
|----|---|
|Temperature	|29
|Weather Condition|	Cloudy
|Humidity	|70
