## Create Named Credential

for this Demo we are going to use the weatherAPI's. 

### architectural flow

```
Apex Code
   |
   |  callout:Weather_API
   |
Named Credential
   |
   |  Authentication handled here
   |
External API
```

### How to test the service

```
WeatherService.WeatherResponse weather =
    WeatherService.getWeather('Pune');

System.debug(weather.main.temp);
```
