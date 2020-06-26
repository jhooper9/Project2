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
    public static void fetchCurrentData(String city, String country, Boolean metric){
        String units = '';
        if(metric) {units='units=%22metric%22';}
        else {units='units=%22imperial%22';}
        //%22metric%22 or %22imperial%22
        String inputString = 'https://community-open-weather-map.p.rapidapi.com/weather?'+
        units + '&q=' + city + '%2c' + country;
        HttpResponse response =callSetup(inputString);
        Map<String,Object> fullResponseBody = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(fullResponseBody.keySet());
        /*
        humidity":40

        "coord":{"lon":-0.13,"lat":51.51}
        "weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}]
        "main":{"temp":302.3
            "feels_like":300.05
            "temp_min":300.93
            "temp_max":303.15
            "pressure":1008,"humidity":40}
        "visibility":10000
        "wind":{"speed":5.1,"deg":180}
        "clouds":{"all":85}
        "dt":1593180586
        "sys":{"type":1
            "id":1414
            "country":"GB"
            "sunrise":1593143092
            "sunset":1593202909}
        */
    }
}