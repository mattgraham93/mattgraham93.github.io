# Import Meteostat library and dependencies
from datetime import datetime
import matplotlib.pyplot as plt
import meteostat
import pprint
import mongodb

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


def weather_main():
    # Set time period
    start = datetime(2000, 1, 1)
    end = datetime(2018, 12, 31)
    # get and store latest data
    print('Getting weather data for Seattle')
    data = get_latest_weather(start, end)
    print('Weather retrieved successfully')
    weather_db = store_weather_data(data)
    print('Storing weather data for Seattle')
    return weather_db
