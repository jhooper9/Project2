public class TemperatureDisplayController {
    
	@auraEnabled
    public static Forecast_Entry__c[] getEntry(String city,String state,String country){
        //WeatherCallout.fetchCurrentData(city,state,country,false);
        WeatherCallout.fetchCurrentData(city,'FL','US',false);
        
        
        return [SELECT Temperature__c,Hourly_Forecast__c,Air_Pressure__c,Amount_of_Precipitation__c,
                Chance_of_Precipitation__c,Cloud_Cover__c,Conditions__c,Date__c,Heat_Index__c,
                Humidity__c, Snow_Depth__c, Time__c, Wind_Chill__c, Wind_Gusts__c, Wind_Heading__c, 
                Wind_Speed__c FROM Forecast_Entry__c];
    }
}