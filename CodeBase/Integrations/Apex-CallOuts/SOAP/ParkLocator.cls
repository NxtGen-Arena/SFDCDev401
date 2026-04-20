public class ParkLocator 
{
	public static List<String> country(String countryName)
    {
       ParkService.ParksImplPort parksbyCountry = new ParkService.ParksImplPort();
       return parksbyCountry.byCountry(countryName);
    }
}