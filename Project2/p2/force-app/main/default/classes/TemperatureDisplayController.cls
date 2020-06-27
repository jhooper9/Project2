public class TemperatureDisplayController {
	@auraEnabled
    public static Forecast_Entry__c getEntry(String city){
        String idString = WeatherCallout.fetchCurrentData(city,'US',false);
        return [SELECT Temperature__c,Id FROM Forecast_Entry__c WHERE id=:idString];
    }
}