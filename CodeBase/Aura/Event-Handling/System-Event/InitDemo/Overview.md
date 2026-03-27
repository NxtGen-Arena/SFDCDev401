# Component Structure

|File|	Purpose|
|----|-------|
|ContactInitDemo.cmp	|Defines component UI, handlers, and binds attributes
|ContactInitDemoController.js	|Contains doInit() method triggered on init
|ContactInitDemoHelper.js	|Handles server call logic and response processing
|ContactInitDemoController.apxc	|Apex class returning Contact details
|ContactInitDemo.design	|Enables component on Lightning Record Page in App Builder


<h2>💡 Notes</h2>

* implements="force:hasRecordId" — needed to retrieve recordId.
* init handler triggers doInit() automatically — no user action.
* Use of <aura:if> and <aura:set> creates dynamic UX: loading placeholder until data appears.
* Separation between data (JS/Apex) and presentation (markup) for clarity.

<h2>Code Walkthrough</h2>

- cmp.get("v.attributeName") returns the value of the attributeName attribute.
- cmp.set("v.attributeName", "attribute value") sets the value of the attributeName attribute.

<h2>Key Concepts</h2>

|Code|	Purpose|
|----|-------|
|action = component.get("c.methodName") | References the Apex method getContactDetails.|
|setParams()| Passes data to the Apex method.
|setCallback(this, callbackFn)| Registers asynchronous return handler.
|Hnadling States| state = "SUCCESS", "ERROR", "INCOMPLETE": SUCCESS: assign data to component attribute. ERROR: extract error message and set errorMessage.
|$A.enqueueAction(action)|Queues request in Aura’s action queue for server execution. Always required to send the action.|
