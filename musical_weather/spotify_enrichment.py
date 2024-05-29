import sys
import json
import spotify
import pandas as pd
import numpy as np
import time

from spotify_py_sdk import SpotifyApi, SdkConfig

from sklearn.preprocessing import StandardScaler, PowerTransformer, QuantileTransformer
from scipy.stats import skew

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


def get_best_transformations(playlist_data, highly_skewed_columns, numerical_cols): 
    best_transformations = {}

    # Assuming highly_skewed_columns is your list of highly skewed columns
    for column in highly_skewed_columns:
        transformations = {
            "original": playlist_data[column],
            "st_scale": playlist_data[column + "_st_scale"],
            "power_transform": playlist_data[column + "_power_transform"],
            "quantile_transform": playlist_data[column + "_quantile_transform"]
        }
        # Calculate skewness for each transformation and find the one with smallest skewness
        best_transform = min(transformations, key=lambda x: abs(skew(transformations[x])))
        best_transformations[column] = best_transform

    seen = set()
    best_transformations_no_duplicates = {}

    # Remove duplicate transformations
    for column, transform in best_transformations.items():
        if transform not in seen:
            best_transformations_no_duplicates[column] = transform
            seen.add(transform)
    # Replace column names in base_columns with their best transformations if necessary
    for i, column in enumerate(numerical_cols):
        if column in best_transformations and best_transformations[column] != 'original':
            numerical_cols[i] = column + '_' + best_transformations[column]
    # Select the columns from standardized_data
    selected_data = playlist_data[numerical_cols]
    # Drop the base columns from playlist_data
    playlist_data = playlist_data.drop(columns=numerical_cols, errors='ignore')
    # Concatenate playlist_data with selected_data
    playlist_data = pd.concat([playlist_data, selected_data], axis=1)

    return playlist_data

def get_all_transformations(playlist_df, numerical_cols):
    # Initialize the transformers
    scaler = StandardScaler()
    power_transformer = PowerTransformer()
    quantile_transformer = QuantileTransformer()

    # Calculate skewness of each numerical column
    skewness = playlist_df[numerical_cols].apply(lambda x: skew(x.dropna()))
    # Convert skewness values to boolean values by comparing with threshold
    skewness_bool = abs(skewness) > 0.5
    # Ensure that skewness and skewness_bool have the same index
    skewness_bool.index = skewness.index
    # Filter out columns with skewness greater than a threshold (e.g., 0.5)
    highly_skewed_columns = skewness[skewness_bool].index

    # Apply StandardScaler, PowerTransformer, and QuantileTransformer to highly skewed columns
    for column in highly_skewed_columns:
        playlist_df.loc[:, column + "_st_scale"] = scaler.fit_transform(playlist_df[[column]])
        playlist_df.loc[:, column + "_power_transform"] = power_transformer.fit_transform(playlist_df[[column]])
        playlist_df.loc[:, column + "_quantile_transform"] = quantile_transformer.fit_transform(playlist_df[[column]])
        
    # Get the best transformations for the highly skewed columns
    print("Getting best transformations for highly skewed columns")
    playlist_df = get_best_transformations(playlist_df, highly_skewed_columns, numerical_cols)

    return playlist_df

def remove_outliers(playlist_data):
    # Calculate Q1, Q3, and IQR
    Q1 = playlist_data['duration_ms'].quantile(0.25)
    Q3 = playlist_data['duration_ms'].quantile(0.75)
    IQR = Q3 - Q1

    # Define the outlier boundaries
    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR

    # Create a new DataFrame that contains only the outliers
    # outliers = playlist_data[(playlist_data['duration_ms'] < lower_bound) | (playlist_data['duration_ms'] > upper_bound)]

    # Drop the outliers from the original DataFrame
    playlist_data = playlist_data[(playlist_data['duration_ms'] >= lower_bound) & (playlist_data['duration_ms'] <= upper_bound)]

    return playlist_data

def transform_playlist_data(playlist_df, numerical_cols):
    # Create a new column 'is_precipitation' that is 1 if the event is 'Rain', 'Snow', 'Storm', or 'Drizzle', and 0 otherwise
    playlist_df['is_precipitation'] = playlist_df['event'].isin(['Rain', 'Snow', 'Storm', 'Drizzle']).fillna(False).astype(int)

    # Remove outliers from the 'duration_ms' column
    playlist_df = remove_outliers(playlist_df)

    # Get the list of numerical columns
    numerical_cols = playlist_df.select_dtypes(include=[np.number]).columns.tolist()

    print("Applying transformations to highly skewed columns")
    playlist_df = get_all_transformations(playlist_df, numerical_cols)

    return playlist_df

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

    return data_list

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

    print("Finalizing playlist data")
    playlist_df = pd.DataFrame(data_list)  # Create DataFrame after the playlist loop

    numerical_cols = playlist_df.select_dtypes(include=['int64', 'float64'])

    print("Enhancing music data")
    # Calculate base scores
    playlist_df = transform_playlist_data(playlist_df, numerical_cols)
    playlist_df = calculate_base_score(playlist_df)
    
    return playlist_df, playlists_without_track_info, playlists_without_data

# def spotify_main():
#     playlist_id = '37i9dQZF1DX4aYNO8X5RpR'  # replace with your playlist id
#     track_info = get_playlist_tracks(playlist_id)
    
#     for info in track_info:
#         song_measures = api.tracks.audio_features(info[1])
#         print(song_measures, info)

# if __name__ == '__main__':
#     spotify_main()
