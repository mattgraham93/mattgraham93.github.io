# Matt Graham
# ISIT 333 - Lab 7 - Part 2
# 11/10/2021

# TODO
#  run code
#  modify main to list dictionaries using name as key for the movies year
#  modify list function to use the correct key to get the name and year of the movie
#  modify add function to use dictionary instead of list
#   use a list to store the list of the movies. use dictionary to store date
#  modify delete to use dictionary
#  add title/greeting, exit messages
#  test and debug
#  comment your shit

movie = {
    "Title": {
        "Release year": "XXXX"
    }
}
movies = [1, movie]


def display_menu():
    print("COMMAND MENU")
    print("list - List all movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print()


def list(movie_list):
    if len(movie_list) == 0:
        print("There are no movies in the list.\n")
        return
    else:
        i = 1
        for movie in movie_list:
            row = movie
            print(str(i) + ". " + row[0] + " (" + str(row[1]) + ")")
            i += 1
        print()


def add(movie_list):
    name = input("Name: ")
    year = input("Year: ")
    movie = []
    movie.append(name)
    movie.append(year)
    movie_list.append(movie)
    print(movie[0] + " was added.\n")


def delete(movie_list):
    number = int(input("Number: "))
    if number < 1 or number > len(movie_list):
        print("Invalid movie number.\n")
    else:
        movie = movie_list.pop(number - 1)
        print(movie[0] + " was deleted.\n")


def main():
    movie_list = [["Monty Python and the Holy Grail", 1975],
                  ["On the Waterfront", 1954],
                  ["Cat on a Hot Tin Roof", 1958]]

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
    print("Bye!")


if __name__ == "__main__":
    main()
