import openmeteo_requests

import requests_cache
import pandas as pd
from retry_requests import retry

# Setup the Open-Meteo API client with cache and retry on error
cache_session = requests_cache.CachedSession('.cache', expire_after = -1)
retry_session = retry(cache_session, retries = 5, backoff_factor = 0.2)
openmeteo = openmeteo_requests.Client(session = retry_session)

# Make sure all required weather variables are listed here
# The order of variables in hourly or daily is important to assign them correctly below
url = "https://archive-api.open-meteo.com/v1/archive"

def get_historical_weather(start, end):
	params = {
	"latitude": 52.52,
	"longitude": 13.41,
	"start_date": start,
	"end_date": end,
	"daily": ["weather_code", "temperature_2m_max", "temperature_2m_min", "temperature_2m_mean", "apparent_temperature_max", "apparent_temperature_min", "apparent_temperature_mean", "sunrise", "sunset", "daylight_duration", "sunshine_duration", "precipitation_sum", "rain_sum", "snowfall_sum", "precipitation_hours", "wind_speed_10m_max", "wind_gusts_10m_max", "wind_direction_10m_dominant", "shortwave_radiation_sum"],
	"temperature_unit": "fahrenheit",
	"wind_speed_unit": "mph",
	"precipitation_unit": "inch"
	}
	responses = openmeteo.weather_api(url, params=params)

	# Process first location. Add a for-loop for multiple locations or weather models
	response = responses[0]
	print(f"Coordinates {response.Latitude()}°N {response.Longitude()}°E")
	print(f"Elevation {response.Elevation()} m asl")
	print(f"Timezone {response.Timezone()} {response.TimezoneAbbreviation()}")
	print(f"Timezone difference to GMT+0 {response.UtcOffsetSeconds()} s")

	# Process daily data. The order of variables needs to be the same as requested.
	daily = response.Daily()
	daily_weather_code = daily.Variables(0).ValuesAsNumpy()
	daily_temperature_2m_max = daily.Variables(1).ValuesAsNumpy()
	daily_temperature_2m_min = daily.Variables(2).ValuesAsNumpy()
	daily_temperature_2m_mean = daily.Variables(3).ValuesAsNumpy()
	daily_apparent_temperature_max = daily.Variables(4).ValuesAsNumpy()
	daily_apparent_temperature_min = daily.Variables(5).ValuesAsNumpy()
	daily_apparent_temperature_mean = daily.Variables(6).ValuesAsNumpy()
	daily_sunrise = daily.Variables(7).ValuesAsNumpy()
	daily_sunset = daily.Variables(8).ValuesAsNumpy()
	daily_daylight_duration = daily.Variables(9).ValuesAsNumpy()
	daily_sunshine_duration = daily.Variables(10).ValuesAsNumpy()
	daily_precipitation_sum = daily.Variables(11).ValuesAsNumpy()
	daily_rain_sum = daily.Variables(12).ValuesAsNumpy()
	daily_snowfall_sum = daily.Variables(13).ValuesAsNumpy()
	daily_precipitation_hours = daily.Variables(14).ValuesAsNumpy()
	daily_wind_speed_10m_max = daily.Variables(15).ValuesAsNumpy()
	daily_wind_gusts_10m_max = daily.Variables(16).ValuesAsNumpy()
	daily_wind_direction_10m_dominant = daily.Variables(17).ValuesAsNumpy()
	daily_shortwave_radiation_sum = daily.Variables(18).ValuesAsNumpy()

	historical_weather = {"date": pd.date_range(
		start = pd.to_datetime(daily.Time(), unit = "s", utc = True),
		end = pd.to_datetime(daily.TimeEnd(), unit = "s", utc = True),
		freq = pd.Timedelta(seconds = daily.Interval()),
		inclusive = "left"
	)}
	historical_weather["weather_code"] = daily_weather_code
	historical_weather["temperature_2m_max"] = daily_temperature_2m_max
	historical_weather["temperature_2m_min"] = daily_temperature_2m_min
	historical_weather["temperature_2m_mean"] = daily_temperature_2m_mean
	historical_weather["apparent_temperature_max"] = daily_apparent_temperature_max
	historical_weather["apparent_temperature_min"] = daily_apparent_temperature_min
	historical_weather["apparent_temperature_mean"] = daily_apparent_temperature_mean
	historical_weather["sunrise"] = daily_sunrise
	historical_weather["sunset"] = daily_sunset
	historical_weather["daylight_duration"] = daily_daylight_duration
	historical_weather["sunshine_duration"] = daily_sunshine_duration
	historical_weather["precipitation_sum"] = daily_precipitation_sum
	historical_weather["rain_sum"] = daily_rain_sum
	historical_weather["snowfall_sum"] = daily_snowfall_sum
	historical_weather["precipitation_hours"] = daily_precipitation_hours
	historical_weather["wind_speed_10m_max"] = daily_wind_speed_10m_max
	historical_weather["wind_gusts_10m_max"] = daily_wind_gusts_10m_max
	historical_weather["wind_direction_10m_dominant"] = daily_wind_direction_10m_dominant
	historical_weather["shortwave_radiation_sum"] = daily_shortwave_radiation_sum

	historical_weatherframe = pd.DataFrame(data = historical_weather)
	historical_weatherframe.set_index("date", inplace = True)
	# historical_weatherframe.to_csv("daily_weather.csv")
	return historical_weather
