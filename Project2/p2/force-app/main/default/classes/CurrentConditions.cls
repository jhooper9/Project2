public class CurrentConditions {
	
	public String conditions {get;set;}
	public Decimal visibility {get;set;}
	public Decimal dew {get;set;}
	public DateTime sunrise {get;set;}
	public DateTime sunset {get;set;}
	public Integer wdir {get;set;}
	public Decimal temp {get;set;}
	public Decimal wspd {get;set;}
	public String datetimeStr {get;set;}
	public Decimal cloudcover {get;set;}
	public Decimal heatindex {get;set;}
	public Integer pop {get;set;}
	public Decimal precip {get;set;}
	public Decimal sealevelpressure {get;set;}
	public Decimal snowdepth {get;set;}
	public Decimal humidity {get;set;}
	public Decimal wgust {get;set;}
	public Decimal windchill {get;set;}

	public CurrentConditions(JSONParser parser){
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String fieldName = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (fieldName == 'conditions'){
						conditions = parser.getText();
					}
					else if (fieldName == 'visibility'){
						visibility = parser.getDecimalValue();
					}
					else if (fieldName == 'dew'){
						dew = parser.getDecimalValue();
					}
					else if (fieldName == 'sunrise'){
						sunrise = parser.getDateTimeValue();
					}
					else if (fieldName == 'sunset'){
						sunset = parser.getDateTimeValue();
					}
					else if (fieldName == 'wdir'){
						wdir = parser.getIntegerValue();
					}
					else if (fieldName == 'temp'){
						temp = parser.getDecimalValue();
					}
					else if (fieldName == 'wspd'){
						wspd = parser.getDecimalValue();
					}
					else if (fieldName == 'datetimeStr'){
						datetimeStr = parser.getText();
					}
					else if (fieldName == 'cloudcover'){
						cloudcover = parser.getDecimalValue();
					}
					else if (fieldName == 'heatindex'){
						heatindex = parser.getDecimalValue();
					}
					else if (fieldName == 'pop'){
						pop = parser.getIntegerValue ();
					}
					else if (fieldName == 'precip'){
						precip = parser.getDecimalValue ();
					}
					else if (fieldName == 'sealevelpressure'){
						sealevelpressure = parser.getDecimalValue();
					}
					else if (fieldName == 'snowdepth'){
						snowdepth = parser.getDecimalValue();
					}
					else if (fieldName == 'humidity'){
						humidity = parser.getDecimalValue  ();
					}
					else if (fieldName == 'wgust'){
						wgust = parser.getDecimalValue ();
					}
					else if (fieldName == 'windchill'){
						windchill = parser.getDecimalValue();
					}
				}
			}
		}
	}
    
    public Forecast_Entry__c convertToEntry(Location__c loc){
        return new Forecast_Entry__c(
             Air_Pressure__c = sealevelpressure,
              Time__c = DateTime.parse(datetimeStr).time(),
              Date__c = DateTime.parse(datetimeStr).date(),
              Humidity__c = humidity,
              Sunrise__c = sunrise.time(),
              Sunset__c = sunset.time(),
              Temperature__c = temp,
              Wind_Heading__c = wdir,
              Wind_Speed__c = wspd		 
        );
        
        
            
            /*
    Location__c
    Low__c
    Feels_Like__c
    High__c = 
	
	public String conditions {get;set;}
	public Decimal visibility {get;set;}
	public Decimal dew {get;set;}
	public String datetimeStr {get;set;}
	public Decimal cloudcover {get;set;}
	public Decimal heatindex {get;set;}
	public Integer pop {get;set;}
	public Decimal precip {get;set;}
	public Decimal snowdepth {get;set;}
	public Decimal wgust {get;set;}
	public Decimal windchill {get;set;}
*/

    }
}