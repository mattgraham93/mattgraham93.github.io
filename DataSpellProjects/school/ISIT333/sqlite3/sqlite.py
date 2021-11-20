import sqlite3

print("SQLite Practice - Example User Table\n")


def connect(db_name):
    conn = sqlite3.connect(db_name)
    print("Successfully connected\n")

    cursor = conn.cursor()

    # check if the user table already exists, if so, drop it so we can start with a new table
    cursor.execute("DROP TABLE IF EXISTS user;")

    # create the table if it doesn't already exist
    # note that primary keys are automatically created in sqlit3 and referenced as rowid
    cursor.execute("CREATE TABLE user (first_name TEXT, last_name TEXT, email TEXT, phone TEXT, address TEXT, "
                   "city TEXT, state TEXT, zipcode TEXT)")

    # create some records of data
    cursor.execute(
        "INSERT INTO user VALUES (\"Mia\", \"Wallace\", \"miwall@bandapart.com\",\"2068675309\",\"address\",\"city\",\"WA\",\"98052\")")
    cursor.execute(
        "INSERT INTO user VALUES (\"Vincent\", \"Vega\", \"vvega@bandapart.com\",\"4258765309\",\"address\",\"city\",\"CA\",\"zipcode\")")
    cursor.execute(
        "INSERT INTO user VALUES (\"Jules\", \"Winnfield\", \"jwinn@bandapart.com\",\"8048765309\",\"321 S Cherry St\",\"Richmond\",\"VA\",\"23220\")")
    cursor.execute(
        "INSERT INTO user VALUES (\"Marsellus\", \"Wallace\", \"mawall@bandapart.com\",\"7578765309\",\"4918 SE Salmon St\",\"Portland\",\"OR\",\"zipcode\")")
    cursor.execute(
        "INSERT INTO user VALUES (\"Butch\", \"Coolidge\", \"bcool@bandapart.com\",\"3018765309\",\"123 Sad Lane\",\"Great Mills\",\"MD\",\"20634\")")
    cursor.execute(
        "INSERT INTO user VALUES (\"Captain\", \"Koons\", \"ckoon@bandapart.com\",\"2028765309\",\"1600 Pennsylvania Avenue\",\"Distict of Columbia\",\"Distict of Columbia\",\"zipcode\")")

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
