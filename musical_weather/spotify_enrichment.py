import sys
import json
import spotify
import pandas as pd
import time

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
    print(f"Getting song info for {song}")
    songs = api.search.execute(f"{song},{artist}", ["track", "artist"])

    if 'tracks' not in songs or not songs['tracks']['items']:
        print(f"No tracks found for {song} by {artist}")
        return None, None

    song_id = songs['tracks']['items'][0]['id']
    song_uri = songs['tracks']['items'][0]['uri']
    song_popularity = songs['tracks']['items'][0]['popularity']

    return song_uri, song_id, song_popularity    

def get_playlist_tracks(playlist_id):
    print(f"Getting tracks for playlist {playlist_id}")
    tracks = api.playlists.get_playlist_items(playlist_id)

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
            track_title = track.get('name')
            if None not in [artist, track_title, track_id, track_popularity]:
                track_info.append((artist, track_title, track_id, track_popularity))

    return track_info


def process_playlists(playlists):
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
        track_info = get_playlist_tracks(playlist_id)

        track_ids = [info[2] for info in track_info if info is not None]  # Get track ids from track_info
        track_ids_chunks = [track_ids[i:i + 100] for i in range(0, len(track_ids), 100)]  # Split track_ids into chunks of 100

        for track_ids_chunk in track_ids_chunks:
            song_measures_list = api.tracks.audio_features(track_ids_chunk)  # Get audio features for multiple tracks

            for song_measures in song_measures_list:
                if song_measures is not None:
                    numeric_values_dict = {k: v for k, v in song_measures.items() if isinstance(v, (int, float))}
                    numeric_values_dict['song'] = song_measures['name']
                    numeric_values_dict['track_id'] = song_measures['id']
                    numeric_values_dict['artist'] = song_measures['artists'][0]['name']
                    numeric_values_dict['event'] = event
                    numeric_values_dict['type'] = type_
                    numeric_values_dict['popularity'] = song_measures['popularity']
                    numeric_values_df = pd.Series(numeric_values_dict).to_frame().T
                    season_playlist_df = pd.concat([season_playlist_df, numeric_values_df], ignore_index=True)
                    print(f"Song: {song_measures['name']} - Artist: {song_measures['artists'][0]['name']}", end='\r', flush=True)

        time.sleep(0.35)  # Add a delay of 0.33 seconds after each request

    return season_playlist_df, playlists_without_track_info

# def spotify_main():
#     playlist_id = '37i9dQZF1DX4aYNO8X5RpR'  # replace with your playlist id
#     track_info = get_playlist_tracks(playlist_id)
    
#     for info in track_info:
#         song_measures = api.tracks.audio_features(info[1])
#         print(song_measures, info)

# if __name__ == '__main__':
#     spotify_main()

# def spotify_main():
#     song_location = get_song_uri('california', 'chappell roan')
#     song_id = song_location[1]
#     song_measures = api.tracks.audio_features(song_id)
    
#     return song_measures, song_location

# if __name__ == '__main__':
#     spotify_main()