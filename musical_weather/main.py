import weather
import pprint

def main():
    # DONE: get and store weather data
    # gets and stores weather data
    weather_db = weather.weather_main() # future improvement to allow for cities to be entered
    print('Weather stored for Seattle')
    seattle_weather = weather.get_stored_weather(weather_db, 'seattle')
    print('Example for Seattle')
    print(pprint.pprint(seattle_weather))

    
    # TODO: plot and normalize weather data

    # TODO: determine weather events and normal weather

    # TODO: get music data or define genres and relevant weather events
    '''
    https://www.accuweather.com/en/press/63672538
    https://www.thomann.de/blog/en/how-the-weather-affects-our-music-listening/

    https://www.kaggle.com/code/varunsaikanuri/spotify-data-visualization/input?select=songs_normalize.csv

    '''
    # TODO: combine weather and music data on weather event and music genre

    # TODO: develop a model to recommend music based on weather
    # TODO: validate the model

    # TODO: make model reach out to last.fm for top artists and songs in Seattle
    # TODO: make model find artists and songs 1 or 2 degrees of separation from top artists
    # TODO: test the model with different weather data

    # TODO: output the recommended music
    
    # optional steps
    # TODO: output playlist to Spotify or Tidal
    # TODO: make model reach out to Spotify for top artists and songs in Seattle
    # TODO: make model reach out to Tidal for top artists and songs in Seattle
    # TODO: make model reach out to Spotify for recommendations
    # TODO: make model reach out to Tidal for recommendations
    print(1)

if __name__ == "__main__":
    # Add an indented block of code here
    main()
    pass
