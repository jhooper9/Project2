public class Utilities {
    public static Forecast_Entry__c convertToEntry(Hourly_Forecast__c hFore,
                                                   WeatherDataResponse.HourlyCondition hCon){
        return new Forecast_Entry__c(
            Hourly_Forecast__c = hFore.Id,
            Air_Pressure__c = hCon.sealevelpressure,
            Amount_of_Precipitation__c = hCon.precip,
            Chance_of_Precipitation__c = hCon.pop,
            Cloud_Cover__c = hCon.cloudcover,
            Conditions__c = hCon.conditions,
            Date__c = cleanDateTime(hCon.datetimeStr).date(),
            Heat_Index__c = hCon.heatindex,
            Humidity__c = hCon.humidity,
            Snow_Depth__c = hCon.snowdepth,
            Temperature__c = hCon.temp,
            Time__c = cleanDateTime(hCon.datetimeStr).time(),
            Wind_Chill__c = hCon.windchill,
            Wind_Gusts__c = hCon.wgust,
            Wind_Heading__c = hCon.wdir,
            Wind_Speed__c = hCon.wspd		 
        );
	}

    public static Current_Weather__c convertToCurrentWeather(Hourly_Forecast__c hFore,
                                                   WeatherDataResponse.currentConditions cCon){
        return new Current_Weather__c(
            Hourly_Forecast__c = hFore.Id,
            Air_Pressure__c = cCon.sealevelpressure,
            Amount_of_Precipitation__c = cCon.precip,
            Cloud_Cover__c = cCon.cloudcover,
            Sunrise__c = cleanDateTime(cCon.sunrise).time(),
            Sunset__c = cleanDateTime(cCon.sunset).time(),
            Heat_Index__c = cCon.heatindex,
            Humidity__c = cCon.humidity,
            Snow_Depth__c = cCon.snowdepth,
            Temperature__c = cCon.temp,
            Wind_Chill__c = cCon.windchill,
            Wind_Gust__c = cCon.wgust,
            Wind_Heading__c = cCon.wdir,
            Wind_Speed__c = cCon.wspd		 
        );
	}    
    public static DateTime cleanDateTime(String input){
        //This is the incoming format which is where this monster Regex is coming from
        //"2020-06-28T05:14:26-07:00"
        //System.debug(input);
        Pattern p = Pattern.compile('(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2}):(\\d{2})(-?\\d{2}):\\d{2}');
        Matcher pm = p.matcher(input);
        DateTime output;
        if( pm.matches() ){
            Integer year = Integer.valueOf(pm.group(1));
            Integer month = Integer.valueOf(pm.group(2));
            Integer day = Integer.valueOf(pm.group(3));
            Integer hour = Integer.valueOf(pm.group(4));
            //System.debug(pm.group(4));
            Integer minute = Integer.valueOf(pm.group(5));
            Integer second = Integer.valueOf(pm.group(6));
            Integer difference = Integer.valueOf(pm.group(7));
            output = DateTime.newInstanceGmt(year, month, day, hour - difference, minute, second);
        }
        //Mar 8 - Nov 1
        //DST is a thing -_-
        DateTime dstStart = DateTime.newInstance(Date.today().year(), 3, 8);
        DateTime dstEnd = DateTime.newInstance(Date.today().year(), 11, 1);
        Integer dstModifier = 0;
        //if(output>dstStart && output<dstEnd) dstModifier=1;
        //System.debug(output);
        return output;
    }
}