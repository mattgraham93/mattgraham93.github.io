import pandas as pd
import urllib3
import re
import mongodb
import lastfm

def get_connection():
    http = urllib3.PoolManager()
    # added user-agent per advice from June --> need to learn more as to why we need this / how we found this answer
    user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)'

    return http, user_agent

def debug_save_html(datastring):
    with open('datastring.txt', 'w', encoding='utf-8') as f:
            f.write(datastring)

def get_html(http_pm, user_agent, url):
    # "GET" request to get page contents, passing user agent string
    resp = http_pm.request('GET', url, headers={'User-Agent': user_agent})
    # store page contents as string for later parsing
    datastring = str(resp.data, "utf-8")
    # print(f"Page response: {resp.status}, with a total page length of {len(datastring)} characters")
    return datastring

def get_values(vals, datastring):
    # create empty dataframe to store values
    df = pd.DataFrame()
    # iterate through reg_vals, get designated regex for each key, and store name
    for val in vals:
        # get regex to pass to regex finder
        regx_str = vals.get(val)
        # print(f"Searching for {val} with regex: {regx_str}")
        # establish pandas series and get all values searched from regex, name=val=reg_vals.key(i)
        sers = pd.Series(re.findall(regx_str, datastring), name=val)
        # print(sers)
        # print(f"Found {len(sers)} values")
        # concat column to growing dataframe
        df = pd.concat([df, sers], axis=1)

    return df

def get_artist_details(artists):
    method = 'artist.getinfo'
    artist_info = pd.DataFrame()
    for artist in artists['artist']:
        # debug_save_html(artist_page)
        results = lastfm.lastfm_get_artist(method, artist)
        artist_info = pd.concat([artist_info, lastfm.lastfm_get_artist(artist)])
    return artist_info


def get_album_details(http_pm, user_agent, albums):
    album_page_regs = {'totalscrobbles':'<div class=\"header-new-info-mobile\">\s+.*\s+.*\s+.*>\s+.*\s+</h4>\s+.*\s+.*\s+\">\s+<p\s+>.*\s+.*\s+</div>\s+</li>\s+.*\s+.*\s+Scrobbles\s+.*\s+.*\s+.*\s+.*\s+.*\s+><abbr class=\"intabbr js-abbreviated-counter\" title=\"([\d,]+)\">',
                   'duration': '<div class=\"metadata-column hidden-xs\">\s+.*\s+.*\s+<dd\s+class=\"catalogue-metadata-description\">\s.+,\s+(.*?)\s+</dd>'
                    }   
    
    album_info = pd.DataFrame()

    for url in albums['albumurl']:
        album_url = f"https://www.last.fm/music/{url}" # already has /music/ in the url
        album_page = get_html(http_pm, user_agent, album_url)
        # debug_save_html(album_page)
        album_info = pd.concat([album_info, get_values(album_page_regs, album_page)])
    
    debug_save_html(album_page)

    return album_info


def get_city_artists(http_pm, user_agent, city_artist_url):
    # tested and verified regex for artist name and listeners
    artist_reg_vals = {
    'artist': 'class=\"link-block-target\"\s*itemprop=\"url\"\s*>(.*?)</a>',  
    'listeners': "<p class=\"big-artist-list-listeners\">\s+(.*)\s<",
    'artisturl': '\s+<a\s+href="\/music\/(.*?)"'
    }
    # datastring is raw html from page
    datastring = get_html(http_pm, user_agent, city_artist_url)
    # debug_save_html(datastring)
    # use regex to extract data and store in dataframe

    artist_info = get_values(artist_reg_vals, datastring)
    artist_info.reset_index(drop=True, inplace=True)  # Reset index of artist_info

    # artist_details = get_artist_details(artist_info)
    # artist_details.reset_index(drop=True, inplace=True)  # Reset index of artist_details

    # artist_info = pd.concat([artist_info, artist_details], axis=1)

    return artist_info

def get_city_albums(http_pm, user_agent, album_url):
    # tested and verified regex for album statistics and information
    album_reg_vals = {
        'album': 'class=\"link-block-target\"\s*>\s*(.*?)</a>',  
        'artist': 'itemprop=\"url\"\s*>\s*(.*?)</a>',  
        'listeners': "class=\"resource-list--release-list-item-aux-text resource-list--release-list-item-listeners\">\s+(\d+,\d+)",
        'releasedate': "class=\"resource-list--release-list-item-aux-text\">\s+(.*?)\s·",
        'tracks': "(\d+)\s+tracks",
        'albumurl': '<h3\s+class=\"resource-list--release-list-item-name\"\s+.*\s+<a\s+href=\"/music/(.*?)\"\s+itemprop=\"url\"'
        }
    datastring = get_html(http_pm, user_agent, album_url)
    # debug_save_html(datastring)

    album_info = get_values(album_reg_vals, datastring)
    album_info.reset_index(drop=True, inplace=True)  # Reset index of album_info

    # album_details = get_album_details(http_pm, user_agent, album_info)
    # album_details.reset_index(drop=True, inplace=True)  # Reset index of artist_details

    # album_info = pd.concat([album_info, album_details], axis=1)
    
    return album_info

def store_city_data(city, artist_df, album_df):
    # store data in mongoDB
    mongodb.store_collection('lastfm', f'{city}_artists', artist_df)
    mongodb.store_collection('lastfm', f'{city}_albums', album_df)


def get_stored_weather(lastfm_db, city, type):
    collection = lastfm_db[f'{city}_{type}']
    
    return collection.find_one()

def main():
    # URL for kumarion: https://www.last.fm/music/Kumarion (pass in artist name)
    # need to get genres of artists
    # need to get similar to artists
    # need to get top tracks and play counts

    artist_df = pd.DataFrame()
    album_df = pd.DataFrame()
    http_pm, user_agent = get_connection()

    city = "seattle"
    pages = range(1, 15)

    # cities = ['','','']
    # for city in cities:
    #     for page in pages:
    #         artist_url = f"https://www.last.fm/tag/{city}/artists?page={page}"
    #         # album_url = f"https://www.last.fm/tag/{city}/albums?page={page}"

    #         artist_df = pd.concat([artist_df, get_city_artists(http_pm, user_agent, artist_url)])
    #         # album_df = pd.concat([artist_df, get_city_artists(http_pm, user_agent, artist_url)])
    
    print(f"Getting data for {city}")
    for page in pages:
        print(f"Getting artists on page {page} of {max(pages)}")
        artist_url = f"https://www.last.fm/tag/{city}/artists?page={page}"
        artist_df = pd.concat([artist_df, get_city_artists(http_pm, user_agent, artist_url)])
        print(f"Getting albums on page {page} of {max(pages)}")
        album_url = f"https://www.last.fm/tag/{city}/albums?page={page}"
        album_df = pd.concat([album_df, get_city_albums(http_pm, user_agent, album_url)])

    print(f"Storing data for {city}")
    store_city_data(city, artist_df, album_df)
    print(f"Data stored for {city}")

    print(f"Retrieving data for {city}")
    artist_df_mongo = mongodb.get_stored_data('lastfm', f'{city}_artists')
    album_df_mongo = mongodb.get_stored_data('lastfm', f'{city}_albums')

    # print(artist_df_mongo)

    return artist_df_mongo, album_df_mongo

    # print(len(artist_df))
    # print(artist_df.head())
    # print(artist_df['genreurls'])\
        

if __name__ == "__main__":
    main()
