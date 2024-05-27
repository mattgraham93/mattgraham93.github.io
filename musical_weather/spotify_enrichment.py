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

def scale_score(weather_score, track_score, is_preciptitation):
    return weather_score * track_score

def calculate_base_score(playlist_data):
    playlist_data['base_score'] = playlist_data['duration_ms'] / playlist_data['tempo']

    playlist_data['best'] = (playlist_data['energy'] / 0.001) + (playlist_data['valence'] / 0.001)
    playlist_data['good'] = abs((playlist_data['danceability'] / 0.01) + (playlist_data['energy'] / 0.01))
    playlist_data['bad'] = -1 * ((playlist_data['acousticness'] / 0.01) + (playlist_data['liveness'] / 0.01))

    # Calculate the score, subtracting 'is_precipitation'
    playlist_data['score'] = playlist_data['base_score'] + playlist_data['best'] + playlist_data['good'] - playlist_data['bad']

    # If 'is_precipitation' is 1, multiply the score by -1
    playlist_data.loc[playlist_data['is_precipitation'] == 1, 'score'] *= -1

    playlist_data['score'] = playlist_data['score'].astype(float)

    playlist_data.drop(columns=['base_score', 'best', 'good', 'bad'], inplace=True)

    return playlist_data

def get_track_info(tracks):
    track_info = []
    for item in tracks['items']:
        track = item['track']
        if track is not None:
            track_id = track.get('id')
            track_popularity = track.get('popularity')
            artist = track['artists'][0]['name'] if track.get('artists') else None
            track_title = track.get('name')
            if None not in [artist, track_title, track_id, track_popularity]:
                track_info.append((artist, track_title, track_id, track_popularity))

    return track_info

def process_track_info(track_info, event, type_, api):
    # Initialize the data list and song counter
    data_list = []
    song_counter = 0

    # Collect all track ids from the playlist
    track_ids = [info[2] for info in track_info if info is not None]

    # Split track_ids into chunks of 100
    track_ids_chunks = [track_ids[i:i + 100] for i in range(0, len(track_ids), 100)]

    for track_ids_chunk in track_ids_chunks:
        print(f"Getting audio features for track ids {track_ids_chunk}")
        song_measures_list = api.tracks.audio_features(track_ids_chunk)  # Get audio features for multiple tracks

        # Get the corresponding chunk of track_info
        track_info_chunk = track_info[track_ids.index(track_ids_chunk[0]):track_ids.index(track_ids_chunk[-1])+1]

        for song_measures, info in zip(song_measures_list, track_info_chunk):
            if song_measures is not None and info is not None:
                numeric_values_dict = {k: v for k, v in song_measures.items() if isinstance(v, (int, float))}
                numeric_values_dict['song'] = info[0]  # Assuming info[0] is 'track_title'
                numeric_values_dict['track_id'] = info[2]  # Assuming info[2] is 'track_id'
                numeric_values_dict['artist'] = info[1]  # Assuming info[1] is 'artist'
                numeric_values_dict['event'] = event
                numeric_values_dict['type'] = type_
                numeric_values_dict['popularity'] = info[3]  # Assuming info[3] is 'track_popularity'
                data_list.append(numeric_values_dict)
                song_counter += 1  # Increment song counter
                print(f"\rProcessed Song {song_counter}: {info[0]} - Artist: {info[1]}", end="")

    # Convert data_list to DataFrame
    playlist_data = pd.DataFrame(data_list)
    
    # Create a new column 'is_precipitation' that is True if the event is 'Rain', 'Snow', 'Storm', or 'Drizzle'
    playlist_data.loc[:, 'is_precipitation'] = playlist_data['event'].isin(['Rain', 'Snow', 'Storm', 'Drizzle'])

    # Fill NaN values with 0
    playlist_data['is_precipitation'] = playlist_data['is_precipitation'].fillna(0)

    # Convert the boolean values to integers (True becomes 1, False becomes 0)
    playlist_data.loc[:, 'is_precipitation'] = playlist_data['is_precipitation'].astype(int)

    # Call calculate_base_score function
    playlist_data = calculate_base_score(playlist_data)

    return playlist_data

def get_playlist_tracks(playlist_id):
    print(f"Getting tracks for playlist {playlist_id}")
    tracks = api.playlists.get_playlist_items(playlist_id)

    if 'items' not in tracks:
        print(f"No tracks found for playlist {playlist_id}")
        return None

    return get_track_info(tracks)


def process_playlists(playlists):
    # Initialize the dictionaries
    playlists_without_track_info = {'playlistid': []}
    playlists_without_data = {'playlistid': []}
    data_list = []  # Initialize data_list before the playlist loop

    for i in range(len(playlists['playlistid'])):
        print(f"Processing Playlist {i+1}/{len(playlists['playlistid'])}")
        # Get the playlist id, event, and type
        playlist_id = playlists['playlistid'][i]
        event = playlists['event'][i]
        type_ = playlists['type'][i]

        print(f"Getting track info for playlist {playlist_id}")
        # Get track info for the playlist
        try:
            track_info = get_playlist_tracks(playlist_id)
        except json.JSONDecodeError:
            print(f"No data returned for playlist {playlist_id}")
            playlists_without_data['playlistid'].append(playlist_id)
            continue  # Skip the rest of the loop for this playlist

        if not track_info:  # If track_info is None or an empty list
            print(f"No track info found for playlist {playlist_id}")
            playlists_without_track_info['playlistid'].append(playlist_id)
            continue  # Skip the rest of the loop for this playlist

        data_list.extend(process_track_info(track_info, event, type_, api))  # Use extend instead of =

        print(f"\nFinished processing playlist {playlist_id}")
        time.sleep(0.35)  # Add a delay of 0.33 seconds after each request

    print("Creating DataFrame")
    season_playlist_df = pd.DataFrame(data_list)  # Create DataFrame after the playlist loop

    return season_playlist_df, playlists_without_track_info, playlists_without_data

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