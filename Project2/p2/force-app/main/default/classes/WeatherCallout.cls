public class WeatherCallout {
    public static void fetchCurrentData(){
        Http httpController = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('x-rapidapi-host', 'community-open-weather-map.p.rapidapi.com');
        request.setHeader('x-rapidapi-key', 'abc224bcd8mshea53e7a216e28cep148300jsn3fcaea9545fd');
        request.setEndpoint('https://community-open-weather-map.p.rapidapi.com/weather?q=Orlando%2cUS');
        //request.setEndpoint('https://community-open-weather-map.p.rapidapi.com/weather?units=%22imperial%22&q=London%2Cuk');
        request.setMethod('GET');
        HttpResponse response =httpController.send(request);
        Map<String,Object> fullResponseBody = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        System.debug(fullResponseBody.keySet());
        /*
        "coord":{"lon":-0.13,"lat":51.51}
        "weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}]
        "base":"stations"
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