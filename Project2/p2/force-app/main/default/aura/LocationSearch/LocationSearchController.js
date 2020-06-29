({
	retrieveTemp : function(component, event, helper) {
		var action = component.get("c.getAllHourlies");
        action.setParams({"city":component.get("v.city"),
                          "state":component.get("v.state"),
                          "country":component.get("v.country")});
        action.setCallback(this,function(response){
            if(response.getState()==="SUCCESS"){
                var balloon = component.getEvent("TempDataRetriever");
                balloon.setParams({"currentWeather":new Current_Weather__c(),
                                   "forecastEntries":response.getReturnValue()})
                var forecastEntry = response.getReturnValue()[0];
                component.set("v.temp",forecastEntry.Temperature__c);
            }
        })
        $A.enqueueAction(action);
	}
})