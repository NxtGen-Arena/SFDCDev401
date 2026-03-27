<h2>🔹 What is actionStatus in Visualforce?</h2>
  
<apex:actionStatus> is a Visualforce component used to provide user feedback during asynchronous operations (such as <apex:actionFunction> or <apex:commandButton> with action and reRender). It defines what to show while an action is processing (start) and what to display once it is complete (stop).

<h3>🔹 How Does <apex:actionStatus> Work?</h3>
It works by linking to an asynchronous component (like commandButton, commandLink, or actionFunction) via the status attribute. When the action is triggered:

The start facet content is shown. Once the server response is received, the stop facet content is displayed (typically restoring the UI to normal).

<h3> ✅ Benefits in Salesforce </h3>

|Benefit|	Description|
|-------|------------|
|🌀 User Experience|	Shows loading spinners or messages so users know the system is processing.|
|⏱️ Reduces Confusion	|Prevents users from clicking multiple times or wondering if anything is happening.|
|🎯 Better Control	|Allows customization of what users see during long-running operations.|
|📦 Lightweight|	No need for external JavaScript or spinners—declarative and fast.|

<h3> 🔸 Common Use Cases </h3>

|Use Case	|Description	|Feedback Example|
|---------|-------------|-----------------|
|Form Submission |	Indicate processing after form submit	| "Submitting..." message|
|Data Lookup	|Show loading during data retrieval	| Spinner or "Loading..."|
|Dependent Picklists|	Load related options dynamically |	"Fetching options..."|

<h3> 🔸 Syntax </h3>

1. Define the actionStatus element

```
  <!-- action status to inform users about the asynchronous processing - request in progress-->
  <apex:actionStatus startText="Please wait...." id="actionStatusmsg" />
```

2. On the action component, define which status to be displayed
```
    <!-- button to update the opp stage to closed won- passes the selected oppId to Controller-->
      <apex:commandButton value="Mark Close" action="{!updateOpp}" rerender="opps_pb" rendered="{!opp.StageName != 'Closed Won'}"
          status="actionStatusmsg" />
```
