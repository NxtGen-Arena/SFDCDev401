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
