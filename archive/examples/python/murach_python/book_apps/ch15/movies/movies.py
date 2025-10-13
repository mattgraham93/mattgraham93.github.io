from objects import DataAccessError
import db
import sys

def display_welcome():
    print("The Movie List program")
    print()
    print("COMMAND MENU")
    print("list - List all movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print()    

def display_movies(movies):
    for i in range(0, len(movies)):
        movie = movies[i]
        print(str(i+1) + ". " + movie[0] + " (" + movie[1] + ")")
    print()

def get_movie():
    name = input("Name: ")
    year = input("Year: ")
    movie = []
    movie.append(name)
    movie.append(year)
    return movie    
        
def get_movie_number(movies):
    while True:
        try:
            number = int(input("Number: "))
        except ValueError:
            print("Invalid integer. Please try again.")
            continue

        if number < 1 or number > len(movies):
            print("There is no movie with that number. " +
                  "Please try again.")
            continue

        return number        

def main():
    display_welcome()
    try:
        movies = db.read_movies()
    except DataAccessError as e:
        print("DataAccessError:", e)
        print("Terminating program.")
        sys.exit()
        
    while True:        
        command = input("Command: ")
        if command == "list":
            display_movies(movies)
        elif command == "add":
            movie = get_movie()
            db.add_movie(movies, movie)
            print(movie[0] + " was added.\n")
        elif command == "del":
            number = get_movie_number(movies)
            movie = db.delete_movie(movies, number-1)
            print(movie[0] + " was deleted.\n")
        elif command == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")

if __name__ == "__main__":
    main()
