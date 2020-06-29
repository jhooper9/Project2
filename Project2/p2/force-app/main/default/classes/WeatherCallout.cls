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
        System.debug(city+' ' +state+ ' '+country);
        String units = '';
        if(metric) {units='unitGroup=metric';}
        else {units='unitGroup=us';}
        String inputString = 'https://visual-crossing-weather.p.rapidapi.com/forecast?contentType=json'+
            '&shortColumnNames=false&' + units + '&location='+ city + '%2c' + state +
            '%2c' + country + '&aggregateHours=1';
        HttpResponse response =callSetup(inputString);
        String stringToReplace = city+','+state+','+country;
        String adjustedResponse = (response.getBody()).replaceAll(stringToReplace, 'city');
        WeatherDataResponse wdResponse = (WeatherDataResponse)JSON.deserialize(adjustedResponse, WeatherDataResponse.class);
        Set<Date> activeDates = new Set<Date>();
        //The API says that it returns 7 days, but the loop here only gives back 6
        //Playing it safe and adding a 7th one manually, besides, it's a set so if it's in there it doesn't matter
        //activeDates.add(Date.today().addDays(6));
        for(WeatherDataResponse.HourlyCondition h : wdResponse.locations.city.values){
            activeDates.add(Utilities.cleanDateTime(h.datetimeStr).date());
        }
        List<Hourly_Forecast__c> existingForecasts = [SELECT Id,Location__r.Id FROM Hourly_Forecast__c WHERE
                                                      Date__c IN :activeDates AND
                                                      Location__r.Name=:wdResponse.locations.city.address];
        Hourly_Forecast__c currentForecast;
        Location__c newLoc;
        List<Forecast_Entry__c> forecastEntries = new List<Forecast_Entry__c>();
        if(existingForecasts.size()!=0) {
            newLoc = existingForecasts[0].Location__r;
        } else {
            newLoc= new Location__c(Name=wdResponse.locations.city.address);
            INSERT newLoc;
        }
        currentForecast = new Hourly_Forecast__c(Location__c=newLoc.Id, Date__c=Date.today());
        //I don't want to preserve the old forecast entries, and a cascading delete is the easiest way to get rid of them
        DELETE existingForecasts;
        UPSERT currentForecast;
        Map<Date,Hourly_Forecast__c> availableForecasts = new Map<Date,Hourly_Forecast__c>();
        for(Integer i=1;i<7;i++){
            availableForecasts.put(Date.today().addDays(i),new Hourly_Forecast__c(Location__c=newLoc.Id, Date__c=Date.today().addDays(i)));
        }
        availableForecasts.put(currentForecast.Date__c,currentForecast);
        UPSERT availableForecasts.values();
        INSERT Utilities.convertToCurrentWeather(currentForecast,wdResponse.locations.city.currentConditions);
        for(WeatherDataResponse.HourlyCondition h : wdResponse.locations.city.values) {
            DateTime hoursDateTime = Utilities.cleanDateTime(h.datetimeStr);
            if(hoursDateTime.date()!=currentForecast.date__c) {
                currentForecast = availableForecasts.get(hoursDateTime.date());
            }
            forecastEntries.add(Utilities.convertToEntry(currentForecast,h));
        }
        INSERT foreCastEntries;


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