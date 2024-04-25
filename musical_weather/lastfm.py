import json
import requests

filename = r"D:\Backup\repos\auth.json"

with open(filename) as file:
    data = json.load(file)
    API_KEY = data['lastfm_key']
    # API_SECRET = data['lastfm_secret']

USER_AGENT = 'musical_weather'

def get_payload():
    payload = {
        'api_key': API_KEY,
        'format': 'json'
    }
    headers = {
        'user-agent': USER_AGENT
        }
    url = 'https://ws.audioscrobbler.com/2.0/'
    return payload, headers, url

def lastfm_get_album(method, artist, album):
    payload, headers, url = get_payload()
    payload['method'] = method
    payload['artist'] = artist
    payload['album'] = album

    response = requests.get(url, headers=headers, params=payload)
    return response

def lastfm_get_geo(method, country, city):
    payload, headers, url = get_payload()
    payload['method'] = method
    payload['country'] = country
    payload['location'] = city
    payload['limit'] = 100

    response = requests.get(url, headers=headers, params=payload)
    return response


def lastfm_get_artist(method, artist):
    payload, headers, url = get_payload()
    payload['method'] = method
    payload['artist'] = artist

    response = requests.get(url, headers=headers, params=payload)
    return response

def lastfm_get(api_call):
    payload, headers, url = get_payload()
    payload['method'] = api_call

    response = requests.get(url, headers=headers, params=payload)
    return response

def jprint(obj):
    text = json.dumps(obj, sort_keys=True, indent=4)
    print(text)

# def main():
#     methods = ['chart.gettopartists', 'chart.gettoptracks']
#     for method in methods:
#         print(f"Getting data for {method}")
#         call = lastfm_get(method)
#         print(call.status_code)
#         jprint(call.json())

# if __name__ == '__main__':
    # main()
# Compare this snippet from musical_weather/weather.py: