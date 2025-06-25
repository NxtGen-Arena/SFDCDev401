({
    fetchContactDetails: function(component) {
        var action = component.get("c.getContactDetails");

        // Set Apex method parameter
        action.setParams({
            contactId: component.get("v.recordId")
        });

        // Handle the callback
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var contact = response.getReturnValue();
                component.set("v.contact", contact);
            } else {
                var errors = response.getError();
                var message = errors && errors[0] && errors[0].message;
                component.set("v.errorMessage", "Error loading contact: " + message);
                console.error("Apex Error: ", message);
            }
        });

        // Enqueue the server-side action
        $A.enqueueAction(action);
    }
})
