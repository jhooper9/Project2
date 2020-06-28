public class WeatherDataResponse {
    public Location locations {get;set;}
    
    public class Location {
        public City city {get;set;}
    }
    public class  City {
        public String address {get;set;}
        public String name {get;set;}
        public Decimal latitude {get;set;}
        public Decimal longitude {get;set;}
        public List<hourlyCondition> values {get;set;}
        public CurrentConditions currentConditions {get;set;}
    }
    public class CurrentConditions {
        public Decimal visibility {get;set;}
        public Decimal dew {get;set;}
        public String sunrise {get;set;}
        public String sunset {get;set;}
        public Decimal wdir {get;set;}
        public Decimal temp {get;set;}
        public Decimal wspd {get;set;}
        public Decimal heatindex {get;set;}
        public Decimal cloudcover {get;set;}
        public Decimal windchill {get;set;}
        public Decimal humidity {get;set;}
        public Decimal wgust {get;set;}
        public Decimal sealevelpressure {get;set;}
        public Decimal precip {get;set;}
        public Decimal snowdepth {get;set;}
    }
    public class HourlyCondition {
        public decimal wdir {get;set;}
        public decimal temp {get;set;}
        public decimal wspd {get;set;}
        public decimal humidity {get;set;}
        public decimal wgust {get;set;}
        public decimal windchill {get;set;}
        public decimal precip {get;set;}
        public decimal sealevelpressure {get;set;}
        public decimal snowdepth {get;set;}
        public decimal cloudcover {get;set;}
        public String datetimeStr {get;set;}
        public Decimal heatindex {get;set;}
        public Decimal pop {get;set;}
        public String conditions {get;set;}
    }
}

/*
public String conditions {get;set;}
public String datetimeStr {get;set;}
public Integer pop {get;set;}
*/