import pylast
import pprint

# You have to have your own unique two values for API_KEY and API_SECRET
# Obtain yours from https://www.last.fm/api/account/create for Last.fm
API_KEY = "32bc74061d0eb6e2c15d98f78d4d65fb"  # this is a sample key
API_SECRET = "dd51a6fef83f42869bc7fa55cf70672e"

network = pylast.LastFMNetwork(
    api_key=API_KEY,
    api_secret=API_SECRET
)

country = network.get_country(country_name="United States")
print(country)

tracks = network.get_geo_top_tracks(country, location = "Seattle")
print(tracks)