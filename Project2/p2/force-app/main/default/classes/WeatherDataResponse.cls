public class WeatherDataResponse {
	public String address {get;set;}
	public String name {get;set;}
	public Decimal latitude {get;set;}
	public Decimal longitude {get;set;}
	public List<CurrentConditions> valuesList {get;set;}
	public CurrentConditions currentCondition {get;set;}

	public WeatherDataResponse(JSONParser parser){
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String fieldName = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if(fieldName == 'values') {
						valuesList.add(new CurrentConditions(parser));
					}
					else if (fieldName == 'address') {
						address = parser.getText();
					}
					else if (fieldName == 'name') {
						name = parser.getText();
					}
					else if (fieldName == 'latitude') {
						latitude = parser.getDecimalValue();
					}
					else if (fieldName == 'longitude') {
						longitude = parser.getDecimalValue();
					}
					else if (fieldName == 'currentConditions') {
						currentCondition = new CurrentConditions(parser);
					}
				}
			}
		}
	}
}