# import pandas
import pandas as pd

# set max column width
pd.options.display.max_columns = 10

# save csv to variable "pokemon"
pokemon = pd.read_csv("../../../data/pokemon.csv")
# simplify the dataset for easier printing
poke_reduce = pokemon[["Name", "Type 1", "Type 2", "HP", "Attack", "Defense", "Generation", "Legendary"]]


# 1 - Print out a report with only the following fields displaying - Name, Type, Generation
def poke_gen():
    print(pokemon[["Name", "Type 1", "Type 2", "Generation"]])


# 2 - Print out a report displaying the name, HP, Attack, Defense, Speed
def poke_stat():
    print(pokemon[["Name", "HP", "Attack", "Defense", "Speed"]])


# 3 - Create a dataFrame displaying all of the GRASS type Pokemon in the csv file
# create compressed dataframe
def poke_grass():
    df_grass = (poke_reduce["Type 1"] == "Grass") | (poke_reduce["Type 2"] == "Grass")
    print(poke_reduce[df_grass])


# 4 - Create a dataFrame displaying all of the Pokemon in order of HP (highest to lowest)
def poke_hp_sort():
    print(poke_reduce.sort_values("HP", ascending=False))


# 5 - Create a dataFrame displaying all of the Pokemon in order of NAME A-Z
def poke_name_sort():
    print(poke_reduce.sort_values("Name", ascending=True))


# 6 - Create a dataFrame of all the LEGENDARY Pokemon.
def poke_legend():
    df_legendary = poke_reduce["Legendary"] == True
    print(poke_reduce[df_legendary])


# 7 - Create a search for a name of a Pokemon and return the data associated with the Pokemon. Do a try/except to
# catch any error or record not found. Allow the user to search multiple times until they choose to exit.
def poke_search():
    while True:
        try:
            # get user input
            user_pokemon = input("Type a Pokemon's name or [x] to quit: ")
            user_df = poke_reduce["Name"] == user_pokemon
            # check user input and if they want to quit
            if user_pokemon.lower() == 'x':
                break
            # raise an error when the dataframe is empty
            if poke_reduce[user_df].empty:
                raise RuntimeError("Pokemon does not exist")
            else:
                # otherwise print the dataframe
                print(poke_reduce[user_df])
            # try
            break
        except Exception as e:
            print(f"{e}. Please search again.")


def nav_menu(menu_select):
    print(menu_select)


def menu():
    print("--------- MENU --------")
    print("[1] - View all Pokemon, their type(s), and their lineage")
    print("[2] - View all Pokemon and their stats")
    print("[3] - View all Grass Pokemon")
    print("[4] - View all Pokemon and their HP in descending order")
    print("[5] - View all Pokemon and their stats")
    print("[6] - View all Pokemon and their stats")
    print("[7] - Search all Pokemon")
    print("[x] - Quit the program")


def main():
    print("Hello and welcome to the Pokemon database!")
    menu()

    while True:
        menu_select = input("Select an item: ")

        try:
            if menu_select.lower() == "x":
                break
            else:
                menu_select = int(menu_select)
                nav_menu(menu_select)
        except TypeError:
            pass
    print("Thank you for using our pandas Pokemon program!")


if __name__ == "__main__":
    main()
