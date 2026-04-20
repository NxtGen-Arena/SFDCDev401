@isTest
private class ParkLocatorTest 
{
	@isTest
    static void testGermanyParks()
    {
        Test.setMock(WebserviceMock.class, new ParkServiceMock());
        String countryName = 'Germany';
        List<String> germanyParks = ParkLocator.country(countryName);
        Assert.areEqual(germanyParks,new List<String>{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'});
    }
}