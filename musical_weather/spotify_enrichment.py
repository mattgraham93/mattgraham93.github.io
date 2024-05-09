import sys
import json
import spotify

from spotify_py_sdk import SpotifyApi, SdkConfig

from dotenv import load_dotenv
load_dotenv()

filename = r"D:\Backup\repos\auth.json"

with open(filename) as file:
    data = json.load(file)
    CLIENT_ID = data['spotify_client_id']
    CLIENT_SECRET = data['spotify_client_secret']

config = SdkConfig() # optional; can create custom methods
api: SpotifyApi = SpotifyApi(CLIENT_ID, CLIENT_SECRET, config)


def get_song_uri(song, artist):
    # search for the song
    print(f"Getting song info for {song}")
    songs = api.search.execute(f"{song},{artist}", ["track", "artist"])
    song_id = songs['tracks']['items'][0]['id']
    song_uri = songs['tracks']['items'][0]['uri']
    song_popularity = songs['tracks']['items'][0]['popularity']
    return [song_uri, song_id, song_popularity]
    

def spotify_main():
    song_location = get_song_uri('california', 'chappell roan')
    song_id = song_location[1]
    song_measures = api.tracks.audio_features(song_id)
    
    return song_measures, song_location

if __name__ == '__main__':
    spotify_main()