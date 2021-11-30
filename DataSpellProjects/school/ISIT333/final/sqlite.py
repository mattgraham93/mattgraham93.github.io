import sqlite3


def connect(db_name):
    # connect to database and return connection and cursor to main
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    return conn, cursor


def create_table(cursor, table_name):
    # create the table if it doesn't already exist
    # note that primary keys are automatically created in sqlit3 and referenced as rowid -- noted!
    cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} (first_name TEXT, last_name TEXT, email TEXT, phone TEXT, address TEXT, "
                   "city TEXT, state TEXT, zipcode TEXT)")

    # create baseline records of data
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Mia\", \"Wallace\", \"miwall@bandapart.com\",\"2068675309\",\"8660 NE 165th St\",\"Redmond\",\"WA\",\"98052\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Vincent\", \"Vega\", \"vvega@bandapart.com\",\"4258765309\",\"1342 Mission St\",\"San Francisco\",\"CA\",\"94016\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Jules\", \"Winnfield\", \"jwinn@bandapart.com\",\"8048765309\",\"321 S Cherry St\",\"Richmond\",\"VA\",\"23220\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Marsellus\", \"Wallace\", \"mawall@bandapart.com\",\"7578765309\",\"4918 SE Salmon St\",\"Portland\",\"OR\",\"97086\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Butch\", \"Coolidge\", \"bcool@bandapart.com\",\"3018765309\",\"123 Sad Lane\",\"Great Mills\",\"MD\",\"20634\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Captain\", \"Koons\", \"ckoon@bandapart.com\",\"2028765309\",\"1600 Pennsylvania Avenue\",\"Distict of Columbia\",\"DC\",\"20002\")")
