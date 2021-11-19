import sqlite3

print("SQLite Practice - Example User Table\n")
conn = sqlite3.connect("C:/mattgraham93.github.io/DataSpellProjects/data/ISIT333.db")
print("Successfully connected\n")

cursor = conn.cursor()

# check if the user table already exists, if so, drop it so we can start with a new table
cursor.execute("DROP TABLE IF EXISTS user;")

# create the table if it doesn't already exist
# note that primary keys are automatically created in sqlit3 and referenced as rowid
cursor.execute("CREATE TABLE user (first_name TEXT, last_name TEXT, email TEXT)")

# create some records of data
cursor.execute("INSERT INTO user VALUES (\"Tony\", \"Stark\", \"ironman@stark.com\")")
cursor.execute("INSERT INTO user VALUES (\"Carol\", \"Danvers\", \"marvel@stark.com\")")

# query the table including the rowid primary key value
cursor.execute("SELECT rowid, first_name, last_name, email FROM user")

# store the results of a the query to a list called users
users = cursor.fetchall()


# now we can loop through the results of the query
for this_user in users:
    print(this_user[0], this_user[1], this_user[2], this_user[3])

# save the updates to the database - if you don't commit any updates/inserts to the database will not be saved
conn.commit()

# close the connection
conn.close()
