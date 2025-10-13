from objects import DataAccessError
import csv

FILENAME = "movies2.csv"

def read_movies():
    try:
        movies = []
        with open(FILENAME, newline="") as file:
            reader = csv.reader(file)
            for row in reader:
                movies.append(row)
        return movies
    except FileNotFoundError:
        raise DataAccessError("Data source not found.")
    except Exception:
        raise DataAccessError("Error accessing data source.")

def write_movies(movies):
    try:
        with open(FILENAME, "w", newline="") as file:
            writer = csv.writer(file)
            writer.writerows(movies)
    except Exception:
        raise DataAccessError("Error accessing data source.")

def add_movie(movies, movie):
    movies.append(movie)
    write_movies(movies)

def delete_movie(movies, index):
    movie = movies.pop(index)
    write_movies(movies)
    return movie
