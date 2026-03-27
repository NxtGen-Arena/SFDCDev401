({
    //called when component is initialized
    doInit : function(component, event, helper) {
        helper.loadTrainees(component);
    },

    selectTrainee: function (component, event, helper) {
        var traineeId = event.getSource().get("v.value");
        console.error("traineeId in searchcontroller ", traineeId);
        //get the instance of the application event
        var appEvent = $A.get("e.c:traineeSelectedAppEvent");
        
        //set the traineeId
        appEvent.setParams({
            "traineeId": traineeId
        });

        //fire the application event
        appEvent.fire();
        console.error("appEvent fired");
    }
})
