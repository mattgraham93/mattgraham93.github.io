import movielist_2d
# Starting file for Exercise 6.2 from our textbook

# Be sure to follow the instructions in our book to complete this lab activity.

# Additionally, add a program title to the output please for the best user experience.
import time


def display_menu():

    print("---------------------------THE TEMPORARY MOVIE STORAGE SYSTEM---------------------------------\n")
    print("Happy day! What a time to be alive, eh? :) Take a look around and see how we can help.")
    print("Temporarily......\n")
    print("list - List all movies")
    print("find - Search movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print()
    print("---------------------------------------------------------------------------------------------\n")


def list(movie_list):
    if len(movie_list) == 0:
        # catch empty list
        print("There are no movies in the list.\n")
        return
    else:
        i = 1
        # iterate through movies
        for movie in movie_list:
            row = movie
            # print price as requested
            print(str(i) + ". " + row[0] + " (" + str(row[1]) + ")" + " @ $" + str(row[2]))
            i += 1
        print()


def add(movie_list):
    name = input("Name: ")
    while True:
        # make sure year is an integer
        year = int(input("Year: "))
        if year > 1920 or year < 2022:
            price = input("Price: ")
            # append movie to movie list
            movie = [name, year, price]
            movie_list.append(movie)
            # print confirmation
            print(movie[0] + " was added.\n")
            break
        else:
            print("Please enter a valid year.\n")


# delete by position
def delete(movie_list):
    # catch out of bounds
    number = int(input("Number: "))
    if number < 1 or number > len(movie_list):
        print("Invalid movie number.\n")
    else:
        movie = movie_list.pop(number - 1)
        print(movie[0] + " was deleted.\n")


def find(movie_list):
    while True:
        # convert entry to integer
        year = int(input("Enter a year: "))
        # validate year entry
        if year > 1920 or year < 2022:
            for movie in movie_list:
                if movie[1] == year:
                    print(movie[0])
            break
        else:
            print("Please enter a valid year\n")


def main():
    movie_list = [["Monty Python and the Holy Grail", 1975, 8.99],
                  ["On the Waterfront", 1954, 7.99],
                  ["Cat on a Hot Tin Roof", 1958, 6.99]]

    display_menu()
    while True:
        command = input("Command: ")
        command = command.lower()
        if command == "list":
            list(movie_list)
        elif command == "add":
            add(movie_list)
        elif command == "del":
            delete(movie_list)
        elif command == "find":
            find(movie_list)
        elif command == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("\n---------------------------------------------------------------------------------------------")
    print("\nThank you for using our program! We won't remember you next time! :)")


if __name__ == "__main__":
    main()
