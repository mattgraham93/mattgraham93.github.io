import pickle

FILENAME = "movies.bin"

def write_movies(movies):
    with open(FILENAME, "wb") as file:
        pickle.dump(movies, file)

def read_movies():
    with open(FILENAME, "rb") as file:
        movies = pickle.load(file)
    return movies

def list_movies():
    movies = read_movies()
    for i in range(len(movies)):
        movie = movies[i]
        print(str(i+1) + ". " + movie[0] + " (" + str(movie[1]) + ")")
    print()

def add_movie():
    name = input("Name: ")
    year = input("Year: ")
    movie = []
    movie.append(name)
    movie.append(year)
    movie_list = read_movies()
    movie_list.append(movie)
    write_movies(movie_list)
    print(name + " was added.\n")

def delete_movie():
    index = int(input("Number: "))
    movie_list = read_movies()
    movie = movie_list.pop(index - 1)
    write_movies(movie_list)
    print(movie[0] + " was deleted.\n")
        
def display_menu():
    print("The Movie List program")
    print()
    print("COMMAND MENU")
    print("list - List all movies")
    print("add -  Add a movie")
    print("del -  Delete a movie")
    print("exit - Exit program")
    print()

def main():
    display_menu()
    while True:        
        command = input("Command: ")
        if command.lower() == "list":
            list_movies()     
        elif command.lower() == "add":
            add_movie()
        elif command.lower() == "del":
            delete_movie()       
        elif command.lower() == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")

if __name__ == "__main__":
    main()
