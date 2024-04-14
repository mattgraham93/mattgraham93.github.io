# Import Meteostat library and dependencies
from datetime import datetime
import matplotlib.pyplot as plt
from meteostat import Stations, Monthly
import mongodb

# Set time period
start = datetime(2000, 1, 1)
end = datetime(2018, 12, 31)

# Get Monthly data
data = Monthly('72793', start, end)
data = data.fetch()
data = data.reset_index()

# Plot line chart including average, minimum and maximum temperature
# data.plot(y=['tavg', 'tmin', 'tmax'])
# plt.show()


# print(type(data))
mongo_client = mongodb.get_client()
weather_db = mongo_client.client['weather']
collection = weather_db['seattle']
collection.insert_many(data.to_dict('records'))
doc_count = collection.count_documents({})

print(doc_count)
