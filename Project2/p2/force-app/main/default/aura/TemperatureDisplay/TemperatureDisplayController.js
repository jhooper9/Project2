({
	retrieveTemp : function(component, event, helper) {
		var action = component.get("c.getEntry");
        console.log(component.get("v.city"));
        action.setParams({"city":component.get("v.city")});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                var forecastEntry = response.getReturnValue();
                component.set("v.temp",forecastEntry.Temperature__c);
            }
        })
        $A.enqueueAction(action);
	}
})