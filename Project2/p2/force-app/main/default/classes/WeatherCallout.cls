public class WeatherCallout {
    private static HttpResponse callSetup(String endpoint){
        Http httpController = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('x-rapidapi-host', 'visual-crossing-weather.p.rapidapi.com');
        request.setHeader('x-rapidapi-key', 'abc224bcd8mshea53e7a216e28cep148300jsn3fcaea9545fd');
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        return httpController.send(request);
        
    }
    public static String fetchCurrentData(String city, String country, Boolean metric){
        String state='';
        if(city.containsWhitespace()) {city = city.replace(' ', '%20');}
        System.debug(city);
        String units = '';
        if(metric) {units='unitGroup=metric';}
        else {units='unitGroup=us';}
        String inputString = 'https://visual-crossing-weather.p.rapidapi.com/forecast?contentType=json'+
            '&shortColumnNames=false&' + units + '&location='+ city + '%2c' + state +
            '%2c' + country + '&aggregateHours=1';
        HttpResponse response =callSetup(inputString);
        WeatherDataResponse wdResponse = (WeatherDataResponse)JSON.deserialize(response.getBody(), 
                                                                               WeatherDataResponse.class);
        Set<Date> activeDates = new Set<Date>();
        for(CurrentConditions c : wdResponse.valuesList){
            activeDates.add(DateTime.parse(c.datetimeStr).date());
        }
        Hourly_Forecast__c hour24;
        List<Forecast_Entry__c> forecastEntries = new List<Forecast_Entry__c>();
        List<Hourly_Forecast__c> existingForecasts = [SELECT Id FROM Hourly_Forecast__c WHERE
                                                      Date__c IN :activeDates AND
                                                      Location__r.Name=:wdResponse.address];
        if(existingForecasts.size()==0){
            //Just seeing if this exists
            List<Location__c> loc = [SELECT Id FROM Location__c WHERE Name=:wdResponse.address];
            if(loc.size()==0){
                loc.add(new Location__c(Name=wdResponse.address));
            }
            hour24 = new Hourly_Forecast__c(Location__c=loc[0].Id);
            
        }
        /*
*/
        
        //UPSERT fList;
        forecastEntries.add(new Forecast_Entry__c());
        return forecastEntries[0].id;
    }
}