# Student Registration to Course

> [Scenario]
We have a studentTile component showing student details with a "Register" button. When clicked, it fires a component event that bubbles up to the parent courseRegistration component, which adds the student to the registered list.

<h2>✅ COMPONENTS</h2>

|Component|Purpose|
|--------|-------|
|traineeRegisterEvent| component level event
|traineeTile|Registers & Fires the Event in Child
|courseRegistration|Handles the Event in the Parent|

<h2>🔶 How to Test the Component</h2>

1. In the "courseRegistration" component, add - "implements="force:appHostable,flexipage:availableForAllPageTypes". THis enables the component to be exposed in a record page and tabs
   
 ![image](https://github.com/user-attachments/assets/91f38d44-1c4c-465a-be36-fc6d0b7c1bcc)

3. Create custom lightning tab with the "courseRegistration" component.


<h2>🔶 Code Explanation</h2>

- traineeRegisterEvent.evt => This .evt file is our custom event definition. It uses type="COMPONENT" meaning it is designed to bubble up from a child component to its parent. We define three attributes—these act as the payload the event will carry: traineeName, traineeEmail, and courseId. Think of it like a custom envelope holding our data.
- In the child component "traineeTile" =>
  - we register this event using <aura:registerEvent>. The name onStudentRegister is a label we’ll use in our JavaScript controller to reference this event. The type must match the .evt file we created."
  - We also have a button that triggers fireRegistrationEvent() in the controller when clicked.
  - The controller retrieves the registered event using getEvent("onStudentRegister") and then populate the parameters using setParams() from the component's current attributes. Finally, we fire the event
    so it can bubble up to any parent component that is listening 
- In the Parent component,"courseRegistration"=>
  - Use <aura:handler> to listen to the custom event. The name matches the child’s registered name. The event is the full event name, and action is the controller method to invoke.
    ![image](https://github.com/user-attachments/assets/f6e9cc78-3131-4234-8f4c-163582da7f0f)


  - define an attribute registeredList that stores all registered students. and display them using an <aura:iteration>.
  - When the 'Register' button is clicked on either, the event bubbles up and triggers the parent handler.
 
[IMPORTANT] Always verify that:

* The event is being fired (in the child)
* The handler is configured correctly (in the parent)
* The parameters are not null or undefined"

<h2> 🎯 Recap Talking Points</h2>

✅ Component Events are bubbled from child to parent
✅ You must define, register, fire, and handle the event
✅ Ideal for child-to-parent data communication
✅ Always check console logs and handlers when debugging
✅ Keep event payloads simple and meaningful
