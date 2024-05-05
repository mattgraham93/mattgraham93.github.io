# Import Meteostat library and dependencies
from datetime import datetime
import matplotlib.pyplot as plt
import meteostat
import pprint
import mongodb
import json
from urllib.request import urlopen
import pandas as pd
import senitment_analysis as sa
import weather_historical as wh
import weather_today as wt
import numpy as np

def analyze_weather(historical_weather):
    # Analyze the weather data
    condensed = pd.DataFrame(
            historical_weather.groupby('description').agg(
            {'temperature_2m_max': 'mean', 
            'temperature_2m_min': 'mean', 
            'temperature_2m_mean': 'mean',
            'precipitation_sum': 'mean', 
            'rain_sum': 'mean',
            'daylight_duration': 'mean',  
            'sunshine_duration': 'mean',
            'precipitation_hours': 'mean',
            'wind_speed_10m_max': 'mean', 
            'wind_gusts_10m_max': 'mean', 
            'shortwave_radiation_sum': 'mean',
            'snowfall_sum': 'mean',
            'weather_score': 'mean'}
            ).reset_index()
        )
    
    condensed['weather_score'] = condensed['weather_score'].fillna(1).astype(int)

    condensed['base'] = condensed['daylight_duration'] + condensed['temperature_2m_mean']
    condensed['good'] = condensed['sunshine_duration'] + condensed['shortwave_radiation_sum']
    
    condensed['bad'] = (condensed['daylight_duration'] - condensed['sunshine_duration']
        ) + (
            condensed['rain_sum'] * condensed['precipitation_hours']
            ) + (
                condensed['snowfall_sum'] * condensed['precipitation_hours']**2
                )

    condensed['weight'] = condensed['base'] + condensed['good'] - condensed['bad']

    condensed['weight'] = np.where((condensed['precipitation_sum'] > 0) & (condensed['weight'] > 0), 
                                condensed['weight'] * -1 ,
                                condensed['weight']
                                ) 

    condensed['weather_score_weighted'] = np.where(condensed['weather_score'] < 0,
                                    (abs(condensed['weather_score']) * condensed['weight']) + condensed['weight'],
                                    (condensed['weather_score'] * condensed['weight']) + condensed['weight']
                                   )

    # condensed[['description', 
    #            'weather_score', 
    #            'good', 
    #            'bad', 
    #            'weight', 
    #            'weather_score_weighted']
    #            ].sort_values('weather_score_weighted', ascending=False)

    return condensed.sort_values('weather_score_weighted', ascending=False)

def store_weather_data(data):
    mongo_client = mongodb.get_client()
    weather_db = mongo_client.client['weather']
    collection = weather_db['seattle']
    df = pd.DataFrame(data)  # Convert the dictionary to a DataFrame
    collection.insert_many(df.to_dict('records'))  # Now you can call to_dict on df
    return weather_db

def get_stored_weather(weather_db, city):
    collection = weather_db[city]
    return collection.find_one()

def get_weather_score(weather_event):
    # get the sentiment score
    return sa.get_score(weather_event)

def get_weather_codes():
    weather_codes = {}
    wc_df = pd.DataFrame()
    
    with urlopen('https://gist.githubusercontent.com/stellasphere/9490c195ed2b53c707087c8c2db4ec0c/raw/76b0cb0ef0bfd8a2ec988aa54e30ecd1b483495d/descriptions.json') as response:
        weather_codes = json.load(response)

    for key in weather_codes.keys():
        wc_df = pd.concat([wc_df, pd.DataFrame(weather_codes[key]['day'], index=[key])])
    wc_df = wc_df.reset_index()
    wc_df.columns = ['weather_code', 'description', 'image']
    wc_df['weather_score'] = wc_df['description'].apply(get_weather_score)
    return wc_df

def weather_main():
    # Set time period
    start = '2018-01-01'
    end = '2024-04-30'
    # # get and store latest data
    print('Getting weather data for Seattle')
    historical_weather = wh.get_historical_weather(start, end)
    # store_weather_data(historical_weather)
    # print('Weather data stored successfully')

    # get stored data
    # weather_db = weather_main()
    # print('Weather data retrieved successfully')

    historical_weather = pd.DataFrame(historical_weather)
    historical_weather['weather_code'] = historical_weather['weather_code'].astype(int)
    print(f'Getting weather codes')
    weather_codes = get_weather_codes()
    weather_codes['weather_code'] = weather_codes['weather_code'].astype(int)
    weather_codes.drop(columns='image', inplace=True)
    print(f'Analyzing weather data')
    joined = historical_weather.merge(weather_codes, on='weather_code', how='left')
    condensed = analyze_weather(joined)
    print(f"Top 5 weather conditions for Seattle:")
    print(condensed.head(5))
    return condensed

if __name__ == '__main__':
    # weather_db = weather_main()
    # pprint.pprint(get_stored_weather(weather_db, 'seattle'))
    # print('Weather data retrieved successfully')
    weather_main()
