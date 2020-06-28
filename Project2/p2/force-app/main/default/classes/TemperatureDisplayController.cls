public class TemperatureDisplayController {
    
	@auraEnabled
    public static Forecast_Entry__c getEntry(String city,String state,String country){
        WeatherCallout.fetchCurrentData(city,state,country,false);
        
        return [SELECT Temperature__c,Id FROM Forecast_Entry__c];
    }
}