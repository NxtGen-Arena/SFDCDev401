({
    handleTraineeRegistration: function (component, event, helper) {
        //get the event data
        var traineeName = event.getParam("traineeName");
        var traineeEmail = event.getParam("traineeEmail");  
        var courseId = event.getParam("courseId");

        var list = component.get("v.registeredList");
     /*  list.push({
            traineeName: traineeName,
            traineeEmail: traineeEmail,
            courseId: courseId
        });*/

        list.push(traineeName + "(" + traineeEmail + ") - Course:" + courseId);

        //set the registered event data to bubble up)
        component.set("v.registeredList", list);

        console.log("Firing event for ",traineeName);
    }
})
