/* I've made the choice to switch to a different API. Great timing, I know.
 * Most of this should still be useful, but that's why there isn't a ton of polish atm
 */
public class WeatherCallout {
    private static HttpResponse callSetup(String endpoint){
        Http httpController = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('x-rapidapi-host', 'community-open-weather-map.p.rapidapi.com');
        request.setHeader('x-rapidapi-key', 'abc224bcd8mshea53e7a216e28cep148300jsn3fcaea9545fd');
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        return httpController.send(request);

    }
    public static String fetchCurrentData(String city, String country, Boolean metric){
        if(city.containsWhitespace()) {city = city.replace(' ', '%20');}
        System.debug(city);
        String units = '';
        if(metric) {units='units=%22metric%22';}
        else {units='units=%22imperial%22';}
        //%22metric%22 or %22imperial%22
        String inputString = 'https://community-open-weather-map.p.rapidapi.com/weather?'+
        units + '&q=' + city + '%2c' + country;
        HttpResponse response =callSetup(inputString);
        JSONParser parser = JSON.createParser(response.getBody());
        List<Forecast_Entry__c> fList = new List<Forecast_Entry__c>();
        Location__c testLocation = new Location__c();
        UPSERT testLocation;
        while(parser.nextToken() !=null){
            if(parser.getCurrentToken()==JSONToken.FIELD_NAME && parser.getText()=='temp'){
                parser.nextToken();
                fList.add(new Forecast_Entry__c(
                    Temperature__c = (parser.getDecimalValue()-273.15)*9/5+32,
                	Location__c = testLocation.id
                ));
            }
        }
        UPSERT fList;
        return fList[0].id;
    }
}