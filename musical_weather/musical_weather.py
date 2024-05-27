import spotify_enrichment
import weather
import pandas as pd
import numpy as np
import json


def get_weather_historical():
    historical_weather, condensed = weather.weather_main()
    return historical_weather, condensed

def get_song_uri(song, artist):
    return spotify_enrichment.get_song_uri(song, artist)

def get_track_info(tracks):
    return spotify_enrichment.get_track_info(tracks)

def process_track_info(track_info, event, type_, api):
    return spotify_enrichment.process_track_info(track_info, event, type_, api)

def scale_score(weather_score, track_score):
    return spotify_enrichment.scale_score(weather_score, track_score)


def main():
    api = spotify_enrichment.api

    historical_weather, condensed = get_weather_historical()
    historical_weather = historical_weather.reset_index(drop=True)
    condensed = condensed.reset_index(drop=True)

    print(historical_weather.head())
    print(condensed.head())

if __name__ == "__main__":
    main()