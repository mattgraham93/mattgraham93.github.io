# Matt Graham
# ISIT 333 - Lab 7 - Part 2
# 11/10/2021

# TODO
#  run code
#  modify main to list dictionaries using name as key for the movies year -- done
#  modify list function to use the correct key to get the name and year of the movie -- done
#  modify add function to use dictionary instead of list -- done
#   use a list to store the list of the movies. use dictionary to store date -- done
#  modify delete to use dictionary -- done
#  add title/greeting, exit messages
#  test and debug
#  comment your shit


def display_menu():
    print("Select a command")
    print("----------------------------")
    print("list - List all movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print("----------------------------")
    print()


def list(movie_list):
    if len(movie_list) == 0:
        print("There are no movies in the list.\n")
        return
    else:
        i = 1
        for row in movie_list:
            print(str(i) + ". " + row["name"] + " (" + str(row["year"]) + ")")
            i += 1
        print()


def add(movie_list):
    name = input("Name: ")
    year = input("Year: ")
    # set name and year to key pair in dictionary
    movie = {
        "name": name,
        "year": year
    }
    movie_list.append(movie)
    print(movie["name"] + " was added.\n")


def delete(movie_list):
    number = int(input("Number: "))
    if number < 1 or number > len(movie_list):
        print("Invalid movie number.\n")
    else:
        movie = movie_list.pop(number - 1)
        print(movie["name"] + " was deleted.\n")


def main():
    print("Welcome to the movie dictionary program!")
    movie_list = [
        {"name": "Monty Python and the Holy Grail",
         "year": 1975},
        {"name": "On the Waterfront",
         "year": 1954},
        {"name": "Cat on a Hot Tin Roof",
         "year": 1958}
    ]

    display_menu()
    while True:
        command = input("Command: ")
        if command == "list":
            list(movie_list)
        elif command == "add":
            add(movie_list)
        elif command == "del":
            delete(movie_list)
        elif command == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Thank you for letting us try a new data type with you!")


if __name__ == "__main__":
    main()