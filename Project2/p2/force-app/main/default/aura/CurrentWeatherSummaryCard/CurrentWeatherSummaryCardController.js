({
	handleHourlies : function(component, event, helper) {
        var listOfHourlies = event.getParam("hourlies");
        for (var i=0;i<6;i++) {
            let tagToCheck = "v.todayp"+i;
            component.set(tagToCheck,listOfHourlies[i]);
        }
        //helper(component,)
		//component.set("v.dailyForecastList",);
	},
    //Is this elegant? No. But I think that it will work
    day0 : function(component,event,helper) {
        console.log(component.get("v.todayp0"));
        if(component.get("v.todayp0"))
    	helper.createLineGraph(component,component.get("v.todayp0"));
    },
    day1 : function(component,event,helper) {
        if(component.get("v.todayp1"))
            helper.createLineGraph(component,component.get("v.todayp1"));
    },
    day2 : function(component,event,helper) {
        if(component.get("v.todayp2"))
            helper.createLineGraph(component,component.get("v.todayp2"));
    },
    day3 : function(component,event,helper) {
        if(component.get("v.todayp3"))
            helper.createLineGraph(component,component.get("v.todayp3"));
    },
    day4 : function(component,event,helper) {
        if(component.get("v.todayp4"))
            helper.createLineGraph(component,component.get("v.todayp4"));
    },
    day5 : function(component,event,helper) {
        if(component.get("v.todayp5"))
            helper.createLineGraph(component,component.get("v.todayp5"));
    }
})