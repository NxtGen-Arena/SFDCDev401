# Understanding Action Function for AJAX Calls

🎯 Use Case Recap
When a user selects a Room Type, we use JavaScript to trigger an actionFunction that calls an Apex method. This method calculates the Room Rate dynamically and updates the Visualforce page — without a full page reload.

🔍 Key Difference from actionSupport:

- actionFunction is defined once with a name.You call it explicitly using JavaScript (e.g., in an onchange handler).
- Allows you to set parameters dynamically and execute complex JS logic before the Apex call.

💻 Visualforce Page (with <apex:actionFunction>):



⚙️ Apex Controller


🎯 Narrative (What Just Happened?)

- We defined an <apex:actionFunction name="getRoomRate">.
- In JavaScript, when the user picks a Room Type, the onchange event fires.
- The JavaScript function getRoomRate(roomType) is called, which:
  - Passes the selected value to the Apex controller (selectedRoomType).
  - Triggers updateRoomRate() server-side.
  - Sets Room_Rate__c based on logic.
- Only updates the rateBlock via reRender.

✅ When to Prefer This Over actionSupport?

* custom HTML controls (<select>, <input>, etc.).
* need to call Apex methods programmatically from JavaScript.
* Want to pass multiple or dynamic parameters.
* Need to chain or delay logic.
