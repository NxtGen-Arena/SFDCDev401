@isTest
private class WeatherServicesEngineRSS_Test 
{
	//simple mock creation for callout to api - jSON response
	
	private class SuccessMock implements HttpcalloutMock
    {
        private final Integer statusCode;
        private final String body;
        private final Map<string,string> headers;
        
        SuccessMock(Integer statusCode, String body)
        {
            this.statusCode = statuscode;
            this.body = body;
            this.headers = new Map<string,String>{'Content-Type' => 'application/json'};
        }
        
        public HTTPResponse respond(HTTPRequest req)
        {
            HttpResponse res = new httpResponse();
            res.setStatusCode(statusCode);
            res.setBody(body);
            for(String key : headers.keyset())
            {
                res.setHeader(key, headers.get(key));
            }
            return res;
        }
    }
    
    //mock for error response
    private class ErrorMock implements HttpcalloutMock
    {
        private final Integer statusCode;
        private final String message;
        
        ErrorMock(Integer statusCode, String message)
        {
            this.statusCode = statuscode;
            this.message = message;
        }
        
        public HTTPResponse respond(HTTPRequest req)
        {
            HttpResponse res = new httpResponse();
            res.setStatusCode(statusCode);
            res.setBody(message !=null ? message : '');
            return res;
        }
    }
    
    //create a sample payload jason
    private static String sampleSuccessPayload(String city)
    {
        return JSON.serialize(new Map<String,Object>{
            'name' => city,
                'main' => new Map<String ,Object>{
                    'temp' => 298.15,
                    'humidity' => 65
                }
        });
    }
    
    static testMethod void getWeatherForCityNamedCred_success()
    {
        String city = 'Pune';
        Test.setMock(HttpcalloutMock.class, new SuccessMock(200,sampleSuccessPayload(city)));
        
        //execute
        Test.startTest();
        WeatherServicesEngineRSS.WeatherResponse res = WeatherServicesEngineRSS.getWeatherForCityNamedCred(city);
        Test.stopTest();
        
        //assert
        System.assertNotEquals(null,res,'response should not be null');
        System.assertEquals(city,res.name,'City should match the param');
        System.assertNotEquals(null,res.main,'Main Block should be present in json response');
        System.assertEquals(298.15,res.main.temp,'Temp should match payload');
        
    }
}
