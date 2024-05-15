import sys
import json
import spotify
import pandas as pd
import time
import threading

from spotify_py_sdk import SpotifyApi, SdkConfig  # https://github.com/Ananya2001-an/spotify-py-sdk

from dotenv import load_dotenv
load_dotenv()

filename = r"D:\Backup\repos\auth.json"

with open(filename) as file:
    data = json.load(file)
    CLIENT_ID = data['spotify_client_id']
    CLIENT_SECRET = data['spotify_client_secret']

config = SdkConfig() # optional; can create custom methods

class SpotifyHandler:
    def __init__(self, client_id, client_secret, config):
        self.api = SpotifyApi(client_id, client_secret, config)
        threading.Thread(target=self.refresh_connection).start()

    def refresh_connection(self):
        while True:
            print("Refreshing connection with Spotify API...")
            self.api = SpotifyApi(CLIENT_ID, CLIENT_SECRET, config)
            time.sleep(600)  # Wait for 10 minutes

    def get_song_uri(self, song, artist):
        print(f"Getting song info for {song}")
        songs = self.api.search.execute(f"{song},{artist}", ["track", "artist"])

        if 'tracks' not in songs or not songs['tracks']['items']:
            print(f"No tracks found for {song} by {artist}")
            return None, None

        song_id = songs['tracks']['items'][0]['id']
        song_uri = songs['tracks']['items'][0]['uri']
        song_popularity = songs['tracks']['items'][0]['popularity']

        return song_uri, song_id, song_popularity 

    def get_playlist_tracks(self, playlist_id):
        print(f"Getting tracks for playlist {playlist_id}")
        tracks = self.api.playlists.get_playlist_items(playlist_id)

        if 'items' not in tracks:
            print(f"No tracks found for playlist {playlist_id}")
            return None

        track_info = []
        for item in tracks['items']:
            track = item['track']
            if track is not None:
                track_uri = track.get('uri')
                track_id = track.get('id')
                track_popularity = track.get('popularity')
                artist = track['artists'][0]['name'] if track.get('artists') else None
                artist_id = track['artists'][0]['id'] if track.get('artists') else None
                genres = self.api.artists.get(artist_id)['genres'] if artist_id else None
                track_title = track.get('name')
                if None not in [track_uri, track_id, track_popularity, artist, track_title, genres]:
                    track_info.append((artist, track_title, track_uri, track_id, track_popularity, genres))

        return track_info
    
    def process_playlists(self, playlists):
        season_playlist_df = pd.DataFrame()

        # Initialize the dictionary
        playlists_without_track_info = {'playlistid': []}

        for i in range(len(playlists['playlistid'])):
            print(f"Playlist {i+1}/{len(playlists['playlistid'])}")
            # Get the playlist id, event, and type
            playlist_id = playlists['playlistid'][i]
            event = playlists['event'][i]
            type_ = playlists['type'][i]

            # Get track info for the playlist
            track_info = self.get_playlist_tracks(playlist_id)

            # Check if track_info is not None before proceeding
            if track_info is not None:
                for info in track_info:
                    artist, track_title, track_uri, track_id, track_popularity, genres = info
                    song_measures = self.api.tracks.audio_features(track_id)
                    numeric_values_dict = {k: v for k, v in song_measures.items() if isinstance(v, (int, float))}
                    numeric_values_dict['song'] = track_title
                    numeric_values_dict['artist'] = artist
                    numeric_values_dict['event'] = event
                    numeric_values_dict['type'] = type_
                    numeric_values_dict['popularity'] = track_popularity
                    numeric_values_dict['genres'] = genres
                    numeric_values_dict['track_uri'] = track_uri
                    numeric_values_df = pd.Series(numeric_values_dict).to_frame().T
                    season_playlist_df = pd.concat([season_playlist_df, numeric_values_df], ignore_index=True)
                    print(f"Song: {track_title} - Artist: {artist}", end='\r', flush=True)
                    time.sleep(0.1)  # Optional: add a small delay for better visualization
            else:
                # Append the playlist id to the dictionary
                playlists_without_track_info['playlistid'].append(playlist_id)
                print(f"No track info available for playlist {playlist_id}")

        return season_playlist_df, playlists_without_track_info
    
# Now you can use spotify_handler.get_song_uri, spotify_handler.get_playlist_tracks, etc.