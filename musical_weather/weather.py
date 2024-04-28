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


def get_latest_weather(start, end):
    # Get Monthly data
    data = meteostat.Daily('72793', start, end)
    data = data.fetch()
    # reset the index to get dates for storage
    return data.reset_index()

def store_weather_data(data):
    mongo_client = mongodb.get_client()
    weather_db = mongo_client.client['weather']
    collection = weather_db['seattle']
    collection.insert_many(data.to_dict('records'))  # https://stackoverflow.com/questions/20167194/insert-a-pandas-dataframe-into-mongodb-using-pymongo
    return weather_db

def get_stored_weather(weather_db, city):
    collection = weather_db[city]
    return collection.find_one()

def get_weather_score(weather_event):
    # get the sentiment score
    return sa.get_score(weather_event)

def weather_codes():
    weather_codes = {}
    wc_df = pd.DataFrame()
    
    with urlopen('https://gist.githubusercontent.com/stellasphere/9490c195ed2b53c707087c8c2db4ec0c/raw/76b0cb0ef0bfd8a2ec988aa54e30ecd1b483495d/descriptions.json') as response:
        weather_codes = json.load(response)

    for key in weather_codes.keys():
        wc_df = pd.concat([wc_df, pd.DataFrame(weather_codes[key]['day'], index=[key])])
        
    wc_df['weather_score'] = wc_df['description'].apply(get_weather_score)
    wc_df.index.name = 'weather_code'
    
    print(wc_df)
        # print(key, weather_codes[key]['day'])

def weather_main():
    # Set time period
    # start = datetime(2000, 1, 1)
    # end = datetime(2018, 12, 31)
    # # get and store latest data
    # print('Getting weather data for Seattle')
    # data = get_latest_weather(start, end)
    # print('Weather retrieved successfully')
    # weather_db = store_weather_data(data)
    # print('Storing weather data for Seattle')
    # return weather_db
    weather_codes()
              

if __name__ == '__main__':
    # weather_db = weather_main()
    # pprint.pprint(get_stored_weather(weather_db, 'seattle'))
    # print('Weather data retrieved successfully')
    weather_main()
