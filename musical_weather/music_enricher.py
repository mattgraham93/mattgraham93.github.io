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
    artist = genius.search_artist(artist, max_songs=3)
    song = genius.search_song(song, artist.name)
    return song.lyrics

def main():
    artist = "chappell roan"
    song = "california"
    lyrics = get_lyrics(artist, song)
    lyric_score = senitment_analysis.get_score(lyrics)
    # print(lyrics)
    print(lyric_score)

if __name__ == '__main__':
    main()
