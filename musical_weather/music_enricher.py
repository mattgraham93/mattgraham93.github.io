import senitment_analysis
import requests
import json
from lyricsgenius import Genius

filename = r"D:\Backup\repos\auth.json"

with open(filename) as file:
    data = json.load(file)
    genius_client_access_token = data['genius_client_access_token']

genius = Genius(genius_client_access_token, 
                verbose=False, 
                remove_section_headers=True
                )

def get_lyrics(artist, song):
    print(f"Getting lyrics for {song} by {artist}")
    artist = genius.search_artist(artist, max_songs=3)
    song = genius.search_song(song, artist.name)
    return song.lyrics

def main():
    artist = "chappell roan"
    song = "california"
    lyrics = get_lyrics(artist, song)
    print(f("Getting score for {song} by {artist}"))
    lyric_score = senitment_analysis.get_score(lyrics)
    # print(lyrics)
    print(f"Score for {song}: {lyric_score}")

if __name__ == '__main__':
    main()
