@isTest
public class WeatherMock implements HttpCalloutMock {

    public HTTPResponse respond(HTTPRequest req){

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');

        res.setBody('{"name":"Pune","main":{"temp":30,"humidity":60}}');
        res.setStatusCode(200);

        return res;
    }
}
