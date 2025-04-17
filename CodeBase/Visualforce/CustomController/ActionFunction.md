# Understanding Using ActionFunction in AJAX Calls

✅ Scenario:
Auto-populate a "Room Rate" when the user selects a "Room Type" from a dropdown on the Registration__c form — without refreshing the page.

📘 What is <apex:actionFunction>?
<apex:actionFunction> lets you define a server-side controller method that can be invoked from JavaScript asynchronously, i.e., without a full-page reload. It acts as a bridge between JavaScript and Apex controller methods, providing a seamless AJAX experience.

ActionFunction creates Javascript in backend and we do not need to write any code for tha

🔧 Use Case: Hotel Registration System
Object: Registration__c

Field 1: Room_Type__c (Picklist: Single, Double, Suite)

Field 2: Room_Rate__c (Currency - auto-filled based on Room Type)

🧠 When to Use <apex:actionFunction>?
Use <apex:actionFunction> :

* to trigger Apex logic from a client-side event (like onchange, onclick).
* for partial page refresh (like updating a section without reloading the whole page).
* to pass parameters from JavaScript to Apex.

✨ Visualforce Page Code:

``
<apex:page controller="HotelRegistrationController">
    <apex:form >
        <apex:pageBlock title="Create Reservation">

            <apex:pageMessages id="msgPanel" />

            <apex:actionStatus id="panelStatus" startText=" (invoking controller method...)" />
            
            <apex:pageBlockSection columns="2">

                <!-- Room Types-->
                <apex:inputField value="{!roomReserved.Room_Type__c}">
                    <apex:actionSupport event="onchange" action="{!updateRoomRate}" reRender="panelRoomDetails,msgPanel,panelStatus" oncomplete="console.log('rate updates');"/>
                </apex:inputField>

                <apex:outputField value="{!roomReserved.Room_Rate__c}" id="panelRoomDetails"/>
            </apex:pageBlockSection>

            <apex:pageBlockSection id="panelButton>
                <apex:commandButton value="Save Registration" />
            </apex:pageBlockSection>
            
        </apex:pageBlock>
    </apex:form>
</apex:page>


