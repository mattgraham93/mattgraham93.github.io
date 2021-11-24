import pandas as pd

url = "https://query.data.world/s/tkj5pda6fyph6anrrynfpzn4jges7w"

data = pd.read_csv(url)
# see all columns on print
pd.options.display.max_columns = None
# see all or specfic number of rows
pd.options.display.max_rows = 20

# show head
# print(data.head())
# show all data
# print(data)
#
# print(data.info())
# show row and column count
# print(data.shape)
# show basic statistics
# print(data.describe())




