public class WeatherServicesEngineQueuable implements Queueable,Database.AllowsCallouts
{
    private Id accountId;
    private String city;
    
    public WeatherServicesEngineQueuable(Id accntId,String cityName)
    {
        this.accountId = accntId;
        this.city = cityName;
    }
    
    public void execute(QueueableContext context)
    {
        //HTTP -  Main class to perform thee callouts
        HTTP varHTTP = new HTTP();
        
        /* HTTPRequest - Request structure for HTTP
         * HTTP Method - GET,POST,PUT,PATCH,DELETE
         * Endpoint - url to hit
         * Header - authentication type
         * body - POST or Put 
         * Timeouts - connection timeout
       */
       HttpRequest req = new HttpRequest();
        req.setEndPoint('https://api.openweathermap.org/data/2.5/weather?q='+ city+ '&appid=090c53bd7cff5c830257c849c78ed051');
        req.setMethod('GET');
        req.setTimeout(2000);
        
        /* HTTPResponse
         * StatusCode - 200 SUCCESS
         * Status Msg
         * Headers
         * Body
        */
		
        try
        {
            Httpresponse res = varHTTP.send(req);
            
            //parse the json response
            if(res.getStatusCode() == 200)  //success
            {
               // return res.getBody();
              // Deserialize json - converts json formatted response string into apex object
              // JSON.deserialize(jsonstring,apextype.class)
              WeatherResponse result = (WeatherResponse)JSON.deserialize(res.getBody(),WeatherResponse.class);
              
              Decimal temp = result.main.temp;
              Decimal humidity = result.main.humidity;
              
              //weatherconditions
              String weatherConditions;
              if(result.weatherResponses != null && !result.weatherResponses.isEmpty())
              {
                  weatherConditions = result.weatherResponses[0].main;
              }
                
              Account acc = new Account();
                acc.Id = this.accountId;
                acc.Temperature__c = temp;
                acc.Humidity__c = humidity;
                acc.Weather_Conditions__c = weatherConditions;
                
                update acc;
            }
            else
            {
                throw new CalloutException('Failed with status code ' + res.getStatusCode());
            }
        }
        catch(Exception ex)
        {
            system.debug('Exception in callout >>>'+ ex.getMessage());
            throw ex;
        }
    }
}
