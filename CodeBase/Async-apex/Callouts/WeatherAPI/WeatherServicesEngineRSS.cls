public class WeatherServicesEngineRSS 
{
    private static final string WEATHER_API_DEFAULT = 'Weather_API';
    public class WeatherResponse
    {
        public string name;
        public Main main;
    }
    
    public class Main
    {
        public Decimal temp;
        public Integer humidity;
    }
    
    public static WeatherResponse getWeatherForCityNamedCred(String city)
    {
        //declare the HTTP class
        Http varHttp = new HTTP();
        
        //generate a request to be sent
        HttpRequest req = new HttpRequest();
        try
        {
            //while using remote site settings
            req.setEndPoint('callout:Weather_API/data/2.5/weather?q='+city+'&appid=775521cd8ce711fd3c581c12c9243f0c');
            
            //make a request
            req.setMethod('GET');
            req.setTimeout(2000);
            
            //fetch the response
            HttpResponse res = varHttp.send(req);
            
            //process the response
            if(res.getStatusCode() == 200) //success
            {
                //
               WeatherResponse result = (WeatherResponse)JSON.deserialize(res.getBody(),WeatherResponse.class);
                return result;
            }
            else
            {
                throw new CallOutException('Error Code '+ res.getStatusCode());
            }
        }
        catch(CalloutException e)
        {
         	system.debug('callout failed >>>'+ e.getMessage());
            throw e;
        }
        catch(Exception ex)
        {
            system.debug('Exception in callout >>>'+ ex.getMessage());
            throw ex;
        }
    }
    
	public static String getWeatherForCityRSS(String city)
    {
        //declare the HTTP class
        Http varHttp = new HTTP();
        
        //generate a request to be sent
        HttpRequest req = new HttpRequest();
        try
        {
            //while using remote site settings
            req.setEndPoint('https://api.openweathermap.org/data/2.5/weather?q='+city+'&appid=775521cd8ce711fd3c581c12c9243f0c');
            
            //make a request
            req.setMethod('GET');
            req.setTimeout(2000);
            
            //fetch the response
            HttpResponse res = varHttp.send(req);
            
            //process the response
            if(res.getStatusCode() == 200) //success
            {
                return res.getBody();
            }
            else
            {
                throw new CallOutException('Failed with status '+ res.getStatusCode());
            }
        }
        catch(Exception ex)
        {
            system.debug('Exception in callout >>>'+ ex.getMessage());
            throw ex;
        }
        
        
    }
}
