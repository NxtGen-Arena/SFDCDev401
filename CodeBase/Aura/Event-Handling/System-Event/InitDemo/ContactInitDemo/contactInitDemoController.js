({
    doInit: function(component, event, helper) {
        // Log the recordId to ensure context is available
        console.log('Contact Record Page Loaded. Record Id:', component.get("v.recordId"));
        helper.fetchContactDetails(component);
    }
})
