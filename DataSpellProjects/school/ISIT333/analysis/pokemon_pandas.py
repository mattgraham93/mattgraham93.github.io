# first import pandas
import pandas as pd

pd.options.display.max_columns = 10

# then save data to a variable "pokemon"
pokemon = pd.read_csv("../../../data/pokemon.csv")

## EXAMPLE DATA CALLS - COMMENT OR REMOVE lines 7 - 25 BEFORE SUBMITTING

# # print first 5 records
# print()
# print("First 5 records\n")
# print(pokemon.head(5))
#
# # print information about csv data
# print()
# print("Basic information about the Pokemon data\n")
# print(pokemon.info())
#
# # print statistical information about all records in the data file
# print()
# print("Basic statistical information about the Pokemon data\n")
# print(pokemon.describe())
#
# # print the minimum value of HP column - note this should align with the data in the describe() function
# print("The minimum HP value is", pokemon["HP"].min())
#
# ASSIGNMENT INSTRUCTIONS ---

# BUILD A MENU SYSTEM WITH OPTIONS FOR THE FOLLOWING OPTIONS

# 1 - Print out a report with only the following fields displaying - Name, Type, Generation

print(pokemon[["Name", "Type 1", "Type 2", "Generation"]])

# 2 - Print out a report displaying the name, HP, Attack, Defense, Speed

print(pokemon[["Name", "HP", "Attack", "Defense", "Speed"]])

# 3 - Create a dataFrame displaying all of the GRASS type Pokemon in the csv file

poke_reduce = pokemon[["Name", "Type 1", "Type 2", "HP", "Attack", "Defense", "Speed", "Generation", "Legendary"]]
df_grass = (poke_reduce["Type 1"] == "Grass") | (poke_reduce["Type 2"] == "Grass")
print(poke_reduce[df_grass])

# 4 - Create a dataFrame displaying all of the Pokemon in order of HP (highest to lowest)

print(poke_reduce.sort_values("HP", ascending=False))

# 5 - Create a dataFrame displaying all of the Pokemon in order of NAME A-Z

print(poke_reduce.sort_values("Name", ascending=True))

# 6 - Create a dataFrame of all the LEGENDARY Pokemon.

df_legendary = poke_reduce["Legendary"] == True
print(poke_reduce[df_legendary])

# 7 - Create a search for a name of a Pokemon and return the data associated with the Pokemon. Do a try/except to
# catch any error or record not found. Allow the user to search multiple times until they choose to exit.
while True:
    try:
        user_pokemon = input("Type a Pokemon's name or [x] to quit: ")
        user_df = poke_reduce["Name"] == user_pokemon
        if user_pokemon.lower() == 'x':
            break
        if poke_reduce[user_df].empty:
            raise RuntimeError("Pokemon does not exist")
        else:
            print(poke_reduce[user_df])
        # break
    except Exception as e:
        print(f"{e}. Please search again.")

print("Thank you for using our pandas Pokemon program!")
