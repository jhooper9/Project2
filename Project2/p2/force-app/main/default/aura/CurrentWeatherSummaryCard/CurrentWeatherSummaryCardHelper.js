({
    numberSort : function (a,b) {
        return a - b;
    },
    createLineGraph : function(component, input) {
        
        
        var traversableArray = input["Forecast__r"];
        
        var labels = [];
        var displayValues = [];
        var mapObject = [];
        for(let i=0;i<traversableArray.length;i++){
            mapObject[(traversableArray[i]["Time__c"])/3600000] = traversableArray[i]["Temperature__c"];
        }
        const mapKeys = [...Object.keys(mapObject)];
        labels = mapKeys.sort(this.numberSort);
        for (let key of labels){
            displayValues.push(mapObject[key]);  
        }
        console.log(labels);
        console.log(displayValues);
        var lineChartElement = component.find('lineChart').getElement();
        var lcContext = lineChartElement.getContext('2d');
        new Chart(lcContext, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Temperature in F',
                    data: displayValues,
                    backgroundColor: "rgba(53,195,151,0.4)"
                }]
            },
            options : {
                scales: {
                    yAxes: [{
                        display: true,
                        ticks: {
                            suggestedMin: Math.min(...displayValues) - 2,
            				suggestedMax: Math.max(...displayValues) +2
                        }
					}]
                  }
                  }
                  });
        
    }
    
})