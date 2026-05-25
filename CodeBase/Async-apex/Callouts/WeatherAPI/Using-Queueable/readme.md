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

Step 1: Create an External Credential

Go to:

Setup → External Credentials

Click New

Fill Details
Field	Value
Label	OpenWeather External Credential
Name	OpenWeather_External_Cred
Authentication Protocol	No Authentication

Since OpenWeather API uses an API key in the URL, no OAuth is needed.

Click Save

Step 2: Create Named Credential

Go to:

Setup → Named Credentials

Click New

Fill Basic Information
Field	|Value
|--|---|
Label	|OpenWeather API
Name	|OpenWeather_API
URL	|https://api.openweathermap.org

Step 3: Configure Identity Type

In the same screen:
Field	|Value|
|--|--|
External Credential|	OpenWeather External Credential
Identity Type	|Named Principal
Authentication Protocol	|No Authentication

Step 4: Enable Required Options

Check:

✅ Generate Authorization Header → Unchecked
✅ Allow Formulas in HTTP Header → Optional
✅ Allow Merge Fields in HTTP Body → Optional

Click save

```

String apiKey = Weather_Config__mdt.getInstance('Default').API_Key__c;

req.setEndpoint(
    'callout:OpenWeather_API/data/2.5/weather?q='
    + EncodingUtil.urlEncode(city, 'UTF-8')
    + '&appid=' + apiKey
);
```


nstead of hardcoding the API key in Apex:

Add API Key as Custom Header

In Named Credential:

Go To:

Named Credential → Custom Headers → New

Header Name	Value
x-api-key	YOUR_API_KEY

But OpenWeather mainly expects:

appid=API_KEY


### Step 3 – Queueable Apex Callout & Wrppaer Class

Queueable is recommended because triggers should not perform synchronous callouts.

|Queuable class| WeatherQueueable.cls|
|---|---|
|Wrapper class|WeatherResponse.cls|


### Step 4 – Account Trigger
AccountTrigger.trigger

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
