public class LocationSearchController {
    
	@auraEnabled
    public static Hourly_Forecast__c[] getAllHourlies(String city,String state,String country){
        System.debug(city);
        System.debug(state);
        System.debug(country);
        WeatherCallout.fetchCurrentData(city,state,country,false);
        
        //This is... a bit of a beast. It's mostly just because I have long field names though.
        //It's just a query for the 24 forecasts and all of their details including their related children.
        return [SELECT Chance_of_Precipitation__c,Date__c,Location__c,Sunrise__c,Sunset__c,
                               Temperature_High__c,Temperature_Low__c,
                                   (SELECT Temperature__c,Hourly_Forecast__c,Air_Pressure__c,Amount_of_Precipitation__c,
                                   Chance_of_Precipitation__c,Cloud_Cover__c,Conditions__c,Date__c,Heat_Index__c,
                                   Humidity__c, Snow_Depth__c, Time__c, Wind_Chill__c, Wind_Gusts__c, Wind_Heading__c, 
                                   Wind_Speed__c FROM Forecast__r) 
                               FROM Hourly_Forecast__c];
    }
}
//The original SOQL. Just in case.
/*Object[] returnList = [SELECT Temperature__c,Hourly_Forecast__c,Air_Pressure__c,Amount_of_Precipitation__c,
    Chance_of_Precipitation__c,Cloud_Cover__c,Conditions__c,Date__c,Heat_Index__c,
    Humidity__c, Snow_Depth__c, Time__c, Wind_Chill__c, Wind_Gusts__c, Wind_Heading__c, 
    Wind_Speed__c FROM Forecast_Entry__c];
returnList.add();*/