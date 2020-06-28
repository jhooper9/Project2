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
    public static void fetchCurrentData(String city, String state, String country, Boolean metric){
        if(city.containsWhitespace()) {city = city.replace(' ', '%20');}
        System.debug(city);
        String units = '';
        if(metric) {units='unitGroup=metric';}
        else {units='unitGroup=us';}
        String inputString = 'https://visual-crossing-weather.p.rapidapi.com/forecast?contentType=json'+
            '&shortColumnNames=false&' + units + '&location='+ city + '%2c' + state +
            '%2c' + country + '&aggregateHours=1';
        HttpResponse response =callSetup(inputString);
        String stringToReplace = city+','+state+','+country;
        String adjustedResponse = (response.getBody()).replaceAll(stringToReplace, 'city');
        testResponse wdResponse = (testResponse)JSON.deserialize(adjustedResponse, testResponse.class);
        System.debug(wdResponse.locations.city.values[0].humidity);
        /*
        Set<Date> activeDates = new Set<Date>();
        for(CurrentConditions c : wdResponse.valuesList){
            activeDates.add(c.datetimeStr.date());
        }
        List<Hourly_Forecast__c> existingForecasts = [SELECT Id FROM Hourly_Forecast__c WHERE
                                                      Date__c IN :activeDates AND
                                                      Location__r.Name=:wdResponse.address];
        //I don't want to preserve the old forecast entries, and a cascading delete is the easiest way to get rid of them
        DELETE existingForecasts;
        Hourly_Forecast__c currentForecast;
        List<Forecast_Entry__c> forecastEntries = new List<Forecast_Entry__c>();
        List<Hourly_Forecast__c> dailyForecasts = new List<Hourly_Forecast__c>();
        if(existingForecasts.size()!=0) {
            currentForecast = new Hourly_Forecast__c(Location__c=existingForecasts[0].Location__r.Id);
        } else {
            Location__c newLoc= new Location__c(Name=wdResponse.address);
            currentForecast = new Hourly_Forecast__c(Location__c=newLoc.Id);
            INSERT newLoc;
        }
        dailyForecasts.add(currentForecast);
        for(CurrentConditions c : wdResponse.valuesList) {
            if(c.datetimeStr.date()!=currentForecast.date__c) {
                currentForecast = new Hourly_Forecast__c(date__c=c.datetimeStr.date(),Location__c=currentForecast.Location__r.Id);
		        dailyForecasts.add(currentForecast);
            }
            forecastEntries.add(c.convertToEntry(currentForecast));
        }
        INSERT dailyForecasts;
        INSERT foreCastEntries;*/



        //return forecastEntries[0].id;
        /*
         *  if(existingForecasts.size()==0){
            //Just seeing if this exists
            List<Location__c> loc = [SELECT Id FROM Location__c WHERE Name=:wdResponse.address];
            if(loc.size()==0){
                loc.add(new Location__c(Name=wdResponse.address));
            }
            hour24 = new Hourly_Forecast__c(Location__c=loc[0].Id);
            
        }
*/
        
        //UPSERT fList;
        //forecastEntries.add(new Forecast_Entry__c());
    }
}