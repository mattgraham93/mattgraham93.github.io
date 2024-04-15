import pandas as pd
import urllib3
import re

artist_url = "https://www.last.fm/tag/seattle/artists?page=1"
albums_url = "https://www.last.fm/tag/seattle/albums?page=1"


# spin up ambiguous connection
http = urllib3.PoolManager()

# added user-agent per advice from June --> need to learn more as to why we need this / how we found this answer
user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)'
# "GET" request to get page contents, passing user agent string
resp = http.request('GET', artist_url, headers={'User-Agent': user_agent})
# store page contents as string for later parsing
datastring = str(resp.data, "utf-8")
print(f"Page response: {resp.status}, with a total page length of {len(datastring)} characters")

# # store tested regex in list to iterate through, used from assignment 1 after validation and some extra fixes

# top artists
artist_reg_vals = {
    'artist': '<a\s+href=\"/music/.*?\"\s+class=\"link-block-target\"\s+itemprop=\"url\">(.*?)</a>',  
    'listeners': "<p class=\"big-artist-list-listeners\">\s+(.*)\s<"
}

# URL for kumarion: https://www.last.fm/music/Kumarion (pass in artist name)
# need to get genres of artists
# need to get similar to artists
# need to get top tracks and play counts

# top albums
album_reg_vals = {
    'album': 'class=\"link-block-target\">\s+(.*)\s</a>',  
    'artist': '<span itemprop=\"name\">\s+<a href=\"/music/(.*?)\" itemprop=\"url\">(.*?)</a>\s+</span>',  
    'listeners': "class=\"resource-list--release-list-item-aux-text resource-list--release-list-item-listeners\">\s+(\d+,\d+)",
    'releasedate': "class=\"resource-list--release-list-item-aux-text\">\s+(.*?)\s·",
    'tracks': "class=\"resource-list--release-list-item-aux-text\">\s+(.*?)\s·\s+(.*?) " # need to split this into track and release date
}

# establish dataframe object for storage
df = pd.DataFrame()

# iterate through reg_vals, get designated regex for each key, and store name
for val in artist_reg_vals:
    # get regex to pass to regex finder
    regx_str = artist_reg_vals.get(val)
    print(f"Searching for {val} with regex: {regx_str}")
    # establish pandas series and get all values searched from regex, name=val=reg_vals.key(i)
    sers = pd.Series(re.findall(regx_str, datastring), name=val)
    print(f"Found {len(sers)} values")
    # concat column to growing dataframe
    df = pd.concat([df, sers], axis=1)

# show dataframe
print(df.head())

for val in album_reg_vals:
    # get regex to pass to regex finder
    regx_str = album_reg_vals.get(val)
    print(f"Searching for {val} with regex: {regx_str}")
    # establish pandas series and get all values searched from regex, name=val=reg_vals.key(i)
    sers = pd.Series(re.findall(regx_str, datastring), name=val)
    print(f"Found {len(sers)} values")
    # concat column to growing dataframe
    df = pd.concat([df, sers], axis=1)

# show dataframe
print(df.head())

