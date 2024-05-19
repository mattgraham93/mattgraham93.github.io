from datetime import datetime
import matplotlib.pyplot as plt
import mongodb
import json
from urllib.request import urlopen
import pandas as pd
import numpy as np
import senitment_analysis as sa
import weather_historical as wh
import weather_today as wt
from datetime import datetime


def get_historical_scores(historical_weather):
    # Calculate the weather score       
    historical_weather['weather_score'] = historical_weather['weather_score'].fillna(0).astype(int)

    historical_weather['base'] = historical_weather['daylight_duration'] + historical_weather['temperature_2m_mean']
    historical_weather['good'] = historical_weather['sunshine_duration'] + historical_weather['shortwave_radiation_sum']
    
    historical_weather['bad'] = (historical_weather['daylight_duration'] - historical_weather['sunshine_duration']
        ) + (
            historical_weather['rain_sum'] * historical_weather['precipitation_hours']
            ) + (
                (historical_weather['snowfall_sum'] * historical_weather['precipitation_hours'])**2
                )

    historical_weather['weight'] = historical_weather['base'] + historical_weather['good'] - historical_weather['bad']

    historical_weather['weight'] = np.where((historical_weather['precipitation_sum'] > 0) & (historical_weather['weight'] > 0), 
                                historical_weather['weight'] * -1 ,
                                historical_weather['weight']
                                ) 

    historical_weather['weather_score_weighted'] = np.where(historical_weather['weather_score'] < 0,
                                    (historical_weather['weather_score'] * abs(historical_weather['weight'])) + historical_weather['weight'],
                                    (historical_weather['weather_score'] * historical_weather['weight']) + historical_weather['weight']
                                   )

    historical_weather.drop(columns=['base', 'good', 'bad'], inplace=True)
    return historical_weather.sort_values('weather_score_weighted', ascending=False)

def analyze_condensed_weather(historical_weather):
    condensed = pd.DataFrame(
            historical_weather.groupby(['description', 'season']).agg(
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
    condensed = get_historical_scores(condensed)
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

def weather_weight_model(historical_weather):
    pass

def map_weather(description):
    if 'Sunny' in description:
        return 'Sun'
    elif 'Cloud' in description:
        return 'Cloud'
    elif 'Snow' in description:
        return 'Snow'
    elif 'Rain' in description or 'Heavy Drizzle' in description:
        return 'Rain'
    elif 'Drizzle' in description:
        return 'Drizzle'
    else:
        return 'Storm'  # If none of the above conditions are met, return 'Storm'

def get_season(date):
    now = (date.month, date.day)
    if (3, 1) <= now < (5, 31):
        season = 'spring'
    elif (6, 1) <= now < (8, 30):
        season = 'summer'
    elif (9, 1) <= now < (11, 30):
        season = 'fall'
    else:
        season = 'winter'
    return season

def weather_main():
    # Set time period
    start = '2018-01-01'
    end = '2024-04-30'
    # # get and store latest data
    print('Getting weather data for Seattle')
    historical_weather = wh.get_historical_weather(start, end)
    historical_weather['season'] = pd.Series(historical_weather['date']).apply(lambda date: get_season(date.date()))
    # get stored data
    # weather_db = weather_main()
    # print('Weather data retrieved successfully')

    historical_weather = pd.DataFrame(historical_weather)
    # print(f'{historical_weather.head(5)}')
    historical_weather['weather_code'] = historical_weather['weather_code'].astype(int)
    print(f'Getting weather codes')
    weather_codes = get_weather_codes()
    weather_codes['weather_code'] = weather_codes['weather_code'].astype(int)
    weather_codes.drop(columns='image', inplace=True)
    print(f'Analyzing and weighing weather data')
    joined = historical_weather.merge(weather_codes, on='weather_code', how='left')
    # condensed = analyze_condensed_weather(joined)
        # print(f"Top 5 weather conditions for Seattle:")
    # print(condensed.head(5))

    historical_weather = get_historical_scores(joined)
    condensed = analyze_condensed_weather(joined)

    final_cols = ['date', 'description', 'season', 'weather_score_weighted', 'weight', 'weather_score', 
                        'weather_code', 'temperature_2m_mean', 'temperature_2m_min', 'temperature_2m_max',
                        'precipitation_sum', 'rain_sum', 'snowfall_sum',
                        'daylight_duration', 'sunshine_duration', 'precipitation_hours', 
                        'wind_speed_10m_max', 'wind_gusts_10m_max', 'shortwave_radiation_sum'
                        ]

    historical_weather = historical_weather[final_cols]
    # print(f"Weather data for Seattle:")
    # print(historical_weather[['date', 'season', 'weather_code']].head(5))
    return historical_weather, condensed

# if __name__ == '__main__':
#     weather_main()
