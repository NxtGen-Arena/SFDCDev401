({
    loadEnrollments: function (component, traineeId) {

        var action = component.get("c.getEnrollmentsByTraineeId");
        action.setParams({
            "traineeId": traineeId
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.enrollments", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });

        $A.enqueueAction(action);
    }
})
