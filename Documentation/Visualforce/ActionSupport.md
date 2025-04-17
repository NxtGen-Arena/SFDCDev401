# Understanding Using ActionSupport in AJAX Calls

✅ Scenario:
Auto-populate a "Room Rate" when the user selects a "Room Type" from a dropdown on the Registration__c form — without refreshing the page.

📘 What is <apex:actionFunction>?

<apex:actionFunction> lets you define a server-side controller method that can be invoked from JavaScript asynchronously, i.e., without a full-page reload. It acts as a bridge between JavaScript and Apex controller methods, providing a seamless AJAX experience.

ActionFunction creates Javascript in backend and we do not need to write any code for tha

🔧 Use Case: Hotel Registration System

Object: Room__c
Field: Room_Type__c (Picklist: Single, Double, Suite)
Field 2: Room_Rate__c (Currency - auto-filled based on Room Type)

Object: Room_Type__c

🧠 When to Use <apex:actionFunction>?

Use <apex:actionFunction> :
* to trigger Apex logic from a client-side event (like onchange, onclick).
* for partial page refresh (like updating a section without reloading the whole page).
* to pass parameters from JavaScript to Apex.

✨ Visualforce Page Code:

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


👨‍💻 Apex Controller: HotelRegistrationController

    public with sharing class HotelRegistrationController 
    {
        public Reservation__c reservation {get;set;}
        public Room__c roomReserved {get;set;}
    
        public HotelRegistrationController() {
            reservation = new Reservation__c();
            roomReserved = new Room__c();
        }

        //action method to execute
        public pagereference updateRoomRate()
        {
            String roomType = roomReserved.Room_Type__c; //binding exisitng selection
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Inside the updateRoomRate'));
            
            if(roomType == 'Single')
            {
                roomReserved.Room_Rate__c = 3000;
            }
            else if(roomType == 'Double')
            {
                roomReserved.Room_Rate__c = 3975;
            }
            else if (roomType == 'Suite')
            {
                roomReserved.Room_Rate__c = 4500;
            }
            else {
                roomReserved.Room_Rate__c = 0;
            }
            return null;
        }

        //Save the reservation
        public PageReference saveReservation()
        {
            try
            {
                //Link the room with reservation
                //roomReserved.Reserved_Room__c = 
                
                //Save the reservation 
                insert reservation;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Resitration Successful! Thank you for booking with us!'));
    
                //reset the form for nex restration
                 reservation = new Reservation__c();
            }
            catch(Exception ex)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            }
            return null;
        }
    }


💡 How it Works 

* The Room_Type__c field uses <apex:actionSupport> to listen for changes.
* When a new room type is selected, updateRoomRate() is called without refreshing the page.
* The controller logic sets the correct Room_Rate__c based on the selected type.
* The rateBlock (containing the Room Rate output) is partially refreshed using reRender.

This gives a dynamic user experience similar to modern web apps — without needing Lightning or external JavaScript frameworks.


