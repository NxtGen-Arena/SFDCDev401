({
    /* fetches the list of trainees from Apex*/
    loadTrainees: function (component) {
        var action = component.get('c.getTrainees');
        
        // Add callback method
        action.setCallback(this, function(response) {
            var state = response.getState();

            if (state === "SUCCESS") {
                component.set('v.trainees', response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });

        $A.enqueueAction(action);
    }
})
