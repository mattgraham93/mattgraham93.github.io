import csv

# a file in the current directory
FILENAME = "movies.csv"

def write_movies(movies):
    with open(FILENAME, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows(movies)   

def read_movies():
    movies = []
    with open(FILENAME, newline="") as file:
        reader = csv.reader(file)
        for row in reader:
            movies.append(row)
    return movies

def list_movies(movies):
    for i in range(len(movies)):
        movie = movies[i]
        print(str(i+1) + ". " + movie[0] + " (" + movie[1] + ")")
    print()

def add_movie(movies):
    name = input("Name: ")
    year = input("Year: ")
    movie = []
    movie.append(name)
    movie.append(year)
    movies.append(movie)
    write_movies(movies)
    print(name + " was added.\n")

def delete_movie(movies):
    index = int(input("Number: "))   
    movie = movies.pop(index - 1)
    write_movies(movies)
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
    movies = read_movies()
    while True:        
        command = input("Command: ")
        if command.lower() == "list":
            list_movies(movies)     
        elif command.lower() == "add":
            add_movie(movies)
        elif command.lower() == "del":
            delete_movie(movies)       
        elif command.lower() == "exit":
            break
        else:
            print("Not a valid command. Please try again.\n")
    print("Bye!")

if __name__ == "__main__":
    main()
