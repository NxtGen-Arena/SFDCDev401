@isTest
public class WeatherServiceTest {

    @isTest
    static void testWeatherCallout(){

        Test.setMock(HttpCalloutMock.class, new WeatherMock());

        Test.startTest();

        WeatherService.WeatherResponse res =
            WeatherService.getWeather('Pune');

        Test.stopTest();

        System.assertEquals('Pune', res.name);
        System.assertEquals(30, res.main.temp);

    }

}
