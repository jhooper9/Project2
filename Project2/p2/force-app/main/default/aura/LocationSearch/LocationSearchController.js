({
	retrieveTemp : function(component, event, helper) {
		var action = component.get("c.getAllHourlies");
        action.setParams({"city":component.get("v.city"),
                          "state":component.get("v.state"),
                          "country":component.get("v.country")});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                var hourliesEvent = component.getEvent("hourlyRetrieverEvent");
                hourliesEvent.setParams({"hourlies":response.getReturnValue()});
                hourliesEvent.fire();
                //var forecastEntry = response.getReturnValue()[0];
                //component.set("v.temp",forecastEntry.Temperature__c);
            }
        })
        $A.enqueueAction(action);
	}
})