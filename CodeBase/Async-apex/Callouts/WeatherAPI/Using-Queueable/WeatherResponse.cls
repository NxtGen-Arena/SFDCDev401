public class WeatherResponse 
{
    public string name;
    public Main main;
    public List<Weather> weatherResponses;
    
    public class Main
    {
        public Decimal temp;
        public Decimal humidity;
    }
    
    public class Weather
    {
        public String main;
    }
}
