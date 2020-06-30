({
	doInit : function(component, event, helper) {
        var dayList = [];
        var date = new Date();
        let day = 0;
        let month=0;
        for(let i=0;i<6;i++){
            /*
            switch(expression) {
                case x:
                    // code block
                    break;
                case y:
                    // code block
                    break;
                default:
                    // code block
            }*/
            month=date.getMonth();
            day=date.getDate()
            dayList.push(month.toString()+"/"+day.toString());
			date.setDate(date.getDate() + 1);
            
        }
        component.set("v.nextFewDays",dayList);
	}
})