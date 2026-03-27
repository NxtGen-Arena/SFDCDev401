({
    onInit: function (component, event, helper)
    {   
        // create a one-time use instance of the getContactDetails action in the server-side controller
        var action = component.get("c.getCourseList");
  
        /** Register callback to handle the server response
        ** sets a callback action that is invoked after the server-side action returns.
        ** The server-side action results are available in the response variable, which is the argument of the callback.
        **/
        action.setCallback(this, function (response) {
            // gets the state of the action returned from the server.
            var state = response.getState();
            if (state === "SUCCESS") {
            //response.getReturnValue() gets the value returned from the server
            component.set("v.courseList", response.getReturnValue());
            } else {
            var errors = response.getError();
            var message = errors && errors[0] && errors[0].message;
            component.set("v.errorMessage", "Error loading contact: " + message);
            console.error("Apex Error: ", message);
            }
        });
    
        // Send action to Apex queue
        $A.enqueueAction(action);

    }
})
