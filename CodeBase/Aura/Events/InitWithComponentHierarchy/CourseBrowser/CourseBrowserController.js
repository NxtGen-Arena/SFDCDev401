({
    doInit : function(component, event, helper) {
        var action = component.get("c.retrieveCourses");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.courseList", response.getReturnValue());
            } else {
                console.error("Failed to load courses:", response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})
