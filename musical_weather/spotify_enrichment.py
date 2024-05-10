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
            if None not in [track_uri, track_id, track_popularity, artist, track_title]:
                track_info.append((artist, track_title, track_uri, track_id, track_popularity))

    return track_info

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