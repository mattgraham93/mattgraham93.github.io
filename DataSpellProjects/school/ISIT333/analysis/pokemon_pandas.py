f# Matt Graham
# 11/24/21
# ISIT - Lab 9

import pandas as pd

# set max column width
pd.options.display.max_columns = 10

# save csv to variable "pokemon"
pokemon = pd.read_csv("../../../data/pokemon.csv")
# simplify the dataset for easier printing
poke_reduce = pokemon[["Name", "Type 1", "Type 2", "HP", "Attack", "Defense", "Generation", "Legendary"]]


def reset_error():
    return -1


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
            user_pokemon = input("Type a Pokemon's name or [x] to return to the menu: ")
            user_df = poke_reduce["Name"] == user_pokemon
            # check user input and if they want to quit
            if user_pokemon.lower() == 'x':
                # return False to return to the menu
                return False
            # raise an error when the dataframe is empty
            if poke_reduce[user_df].empty:
                raise RuntimeError("Pokemon does not exist")
            else:
                # otherwise print the dataframe
                print(poke_reduce[user_df])
                # return true to continue looping through search feature
                return True
        except Exception as e:
            print(f"{e}. Please search again.")


def menu():
    print()
    print("--------- MENU --------")
    print("[1] - View all Pokemon, their type(s), and their lineage")
    print("[2] - View all Pokemon and their stats")
    print("[3] - View all Grass Pokemon")
    print("[4] - View all Pokemon and their HP in descending order")
    print("[5] - View all Pokemon in alphabetical order")
    print("[6] - View all legendary Pokemon")
    print("[7] - Search all Pokemon")
    print("[x] - Quit the program")


def main():
    print("Hello and welcome to the Pokemon database!")

    # track user error to print menu
    user_error = -1

    while True:
        # print the menu each time user error is reset or exceeds
        if user_error == -1 or user_error >= 4:
            menu()
            # reset user_error + 1 count if user has failed many times to avoid continuous menu printing
            if user_error >= 4:
                user_error = 0

        # get menu selection
        menu_select = input("\nSelect an item: ")

        try:
            if menu_select.lower() == "x":
                # end the program when the user requests
                break
            else:
                # try converting string to integer
                menu_select = int(menu_select)
                if menu_select == 1:
                    poke_gen()
                    user_error = reset_error()
                elif menu_select == 2:
                    poke_stat()
                    user_error = reset_error()
                elif menu_select == 3:
                    poke_grass()
                    user_error = reset_error()
                elif menu_select == 4:
                    poke_hp_sort()
                    user_error = reset_error()
                elif menu_select == 5:
                    poke_name_sort()
                    user_error = reset_error()
                elif menu_select == 6:
                    poke_legend()
                    user_error = reset_error()
                elif menu_select == 7:
                    cont = True
                    while cont:
                        cont = poke_search()
                    user_error = reset_error()
                else:
                    # if any value not expected, incorrect selection and increase user error count
                    print("Please enter a valid menu option")
                    user_error += 1
        # if not an integer, throw an exception and increase user error count
        except ValueError:
            print(f"Please enter a valid menu option")
            user_error += 1
            # pass to continue looping through until user is done
            pass
    print("Thank you for using our pandas Pokemon program!")


if __name__ == "__main__":
    main()
