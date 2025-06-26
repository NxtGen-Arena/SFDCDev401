({
    handleTraineeSelected: function (component, event, helper) {
        //retieve the traineeId from application event
        var traineeId = event.getParam("traineeId");

        //set the trainee Id received from application event
        component.set("v.traineeId", traineeId);

        helper.loadEnrollments(component,traineeId);
    }
})
