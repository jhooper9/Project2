public class Utilities {
    public static Forecast_Entry__c convertToEntry(Hourly_Forecast__c hFore,
                                                   WeatherDataResponse.HourlyCondition hCon){
        return new Forecast_Entry__c(
            Hourly_Forecast__c = hFore.Id,
            Air_Pressure__c = hCon.sealevelpressure,
            Time__c = DateTime.parse(hCon.datetimeStr).time(),
            Date__c = DateTime.parse(hCon.datetimeStr).date(),
            Humidity__c = hCon.humidity,
            Temperature__c = hCon.temp,
            Wind_Heading__c = hCon.wdir,
            Wind_Speed__c = hCon.wspd		 
        );
	}
}