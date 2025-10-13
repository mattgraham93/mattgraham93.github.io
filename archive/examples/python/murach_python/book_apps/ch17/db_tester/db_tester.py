# import the modules and classes
import sqlite3
from contextlib import closing

# connect to the database and set the row factory
conn = sqlite3.connect("movies.sqlite")
conn.row_factory = sqlite3.Row

# execute a SELECT statement - with exception handling
try:
    with closing(conn.cursor()) as c:
        query = '''SELECT * FROM Movie
                  WHERE minutes < ?'''
        c.execute(query, (90,))
        movies = c.fetchall()

except sqlite3.OperationalError as e:
    movies = None
    print("Error reading database -", e)    

# display the results
if movies != None:
    for movie in movies:
        print(movie["name"], "|", movie["year"], "|", movie["minutes"])
    print()

# execute an INSERT statement
name = "A Fish Called Wanda"
year = 1988
minutes = 108
categoryID = 1
with closing(conn.cursor()) as c:
    query = '''INSERT INTO Movie
               (name, year, minutes, categoryID)
               VALUES (?, ?, ?, ?)'''
    c.execute(query, (name, year, minutes, categoryID))
    conn.commit()
print(name, "inserted.")

# execute an UPDATE statement
minutes = 81
with closing(conn.cursor()) as c:
    query = '''UPDATE Movie
               SET minutes = ?
               WHERE name = ?'''
    c.execute(query, (minutes, name))
    conn.commit()
print(name, "updated.")

# execute a DELETE statement
with closing(conn.cursor()) as c:
    query =  '''DELETE FROM Movie
                WHERE name = ?'''
    c.execute(query, (name,))
    conn.commit()
print(name, "deleted.")
