({
    fireRegistrationEvent : function(component, event, helper) {

        //get the registered event
        var regTraineeEvent = component.getEvent("onTraineeRegister");
        
        regTraineeEvent.setParams({
            traineeName: component.get("v.traineeName"),
            traineeEmail: component.get("v.traineeEmail"),
            courseId: component.get("v.courseId")
        });

        console.log("Firing event for ",component.get("v.traineeName"));
        //fire the registered event to bubble up
        regTraineeEvent.fire();
    }
})
