# first import pandas
import pandas as pd

pd.options.display.max_columns = 10

# then save data to a variable "pokemon"
pokemon = pd.read_csv("../../../data/pokemon.csv")
poke_reduce = pokemon[["Name", "Type 1", "Type 2", "HP", "Attack", "Defense", "Generation", "Legendary"]]

# EXAMPLE DATA CALLS - COMMENT OR REMOVE lines 7 - 25 BEFORE SUBMITTING

# print first 5 records
print()
print("First 5 records\n")
print(pokemon.head(5))

# print information about csv data
print()
print("Basic information about the Pokemon data\n")
print(pokemon.info())

# print statistical information about all records in the data file
print()
print("Basic statistical information about the Pokemon data\n")
print(pokemon.describe())

# print the minimum value of HP column - note this should align with the data in the describe() function
print("The minimum HP value is", pokemon["HP"].min())
