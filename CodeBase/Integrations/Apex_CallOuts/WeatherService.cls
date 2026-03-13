public with sharing class WeatherService {

    public class WeatherResponse {
        public String name;
        public Main main;
    }

    public class Main {
        public Decimal temp;
        public Integer humidity;
    }

    public static WeatherResponse getWeather(String city) {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        try {

            req.setEndpoint('callout:Weather_API/data/2.5/weather?q=' + city + '&appid=YOUR_KEY');
            req.setMethod('GET');
            req.setTimeout(2000);

            HttpResponse res = http.send(req);

            if(res.getStatusCode() == 200){

                WeatherResponse result =
                    (WeatherResponse) JSON.deserialize(res.getBody(), WeatherResponse.class);

                return result;

            } else {

                throw new CalloutException(
                    'Error: ' + res.getStatusCode() + ' Body: ' + res.getBody()
                );

            }

        } catch(System.CalloutException e){

            System.debug('Callout failed: ' + e.getMessage());
            throw e;

        } catch(Exception ex){

            System.debug('Unexpected error: ' + ex.getMessage());
            throw new AuraHandledException('Weather service failed');

        }

    }

}
