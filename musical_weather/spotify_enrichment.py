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
    track_ids = []
    for item in tracks['items']:
        track = item['track']
        if track is not None:
            track_uri = track.get('uri')
            track_id = track.get('id')
            track_popularity = track.get('popularity')
            artist = track['artists'][0]['name'] if track.get('artists') else None
            track_title = track.get('name')
            if None not in [artist, track_title, track_id, track_popularity]:
                track_info.append({
                    'artist': artist,
                    'track_title': track_title,
                    'track_id': track_id,
                    'track_popularity': track_popularity
                })
                track_ids.append(track_id)

    # Get audio features for all tracks
    audio_features = api.tracks.audio_features(track_ids)
    if audio_features is None:
        print(f"No audio features found for tracks in playlist {playlist_id}")
        return None

    for i, features in enumerate(audio_features):
        if features is not None:
            track_info[i].update(features)

    return pd.DataFrame(track_info)

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
        print(track_info)
        # Check if track_info is not None before proceeding
        if track_info is not None:
            for info in track_info:
                artist, track_title, track_id, track_popularity = info
                song_measures = api.tracks.audio_features(track_id)
                print(song_measures, info)
                numeric_values_dict = {k: v for k, v in song_measures.items() if isinstance(v, (int, float))}
                numeric_values_dict['song'] = track_title
                numeric_values_dict['artist'] = artist
                numeric_values_dict['event'] = event
                numeric_values_dict['type'] = type_
                numeric_values_dict['popularity'] = track_popularity
                numeric_values_df = pd.Series(numeric_values_dict).to_frame().T
                season_playlist_df = pd.concat([season_playlist_df, numeric_values_df], ignore_index=True)
                print(f"Song: {track_title} - Artist: {artist}", end='\r', flush=True)
                time.sleep(0.1)  # Optional: add a small delay for better visualization
        else:
            # Append the playlist id to the dictionary
            playlists_without_track_info['playlistid'].append(playlist_id)
            print(f"No track info available for playlist {playlist_id}")

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