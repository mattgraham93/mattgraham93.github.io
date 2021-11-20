import sqlite3


def connect(db_name):
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    return conn, cursor


def create_table(cursor, table_name):
    # check if the user table already exists, if so, drop it so we can start with a new table
    cursor.execute(f"DROP TABLE IF EXISTS {table_name};")

    # create the table if it doesn't already exist
    # note that primary keys are automatically created in sqlit3 and referenced as rowid
    cursor.execute(f"CREATE TABLE {table_name} (first_name TEXT, last_name TEXT, email TEXT, phone TEXT, address TEXT, "
                   "city TEXT, state TEXT, zipcode TEXT)")

    # create baseline records records of data
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Mia\", \"Wallace\", \"miwall@bandapart.com\",\"2068675309\",\"address\",\"city\",\"WA\",\"98052\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Vincent\", \"Vega\", \"vvega@bandapart.com\",\"4258765309\",\"address\",\"city\",\"CA\",\"zipcode\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Jules\", \"Winnfield\", \"jwinn@bandapart.com\",\"8048765309\",\"321 S Cherry St\",\"Richmond\",\"VA\",\"23220\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Marsellus\", \"Wallace\", \"mawall@bandapart.com\",\"7578765309\",\"4918 SE Salmon St\",\"Portland\",\"OR\",\"zipcode\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Butch\", \"Coolidge\", \"bcool@bandapart.com\",\"3018765309\",\"123 Sad Lane\",\"Great Mills\",\"MD\",\"20634\")")
    cursor.execute(
        f"INSERT INTO {table_name} VALUES (\"Captain\", \"Koons\", \"ckoon@bandapart.com\",\"2028765309\",\"1600 Pennsylvania Avenue\",\"Distict of Columbia\",\"DC\",\"zipcode\")")

    # WOULD LIKE TO ITERATE THROUGH DICTIONARY OF VALUES TO INPUT INTO SQL
    # pulp_fiction: {
    #     "Mia Wallace": {
    #         "email": "",
    #         "phone": "",
    #         "address": "",
    #         "city": "",
    #         "state": "",
    #         "zipcode": ""
    #     }
    # }


def add_user(cursor, table_name):
    user_firstname = input("First name: ")
    user_lastname = input("Last name: ")
    user_email = input("Email: ")
    user_phone = input("Phone: ")
    user_address = input("Address: ")
    user_city = input("City: ")
    user_state = input("State: ")
    user_zipcode = input("Zipcode: ")

    # pass in table name and establish query - would like to dynamically insert into all columns regardless of table
    # like, "this table's columns"
    sql = f"""
        INSERT INTO {table_name} (first_name, last_name, email, phone, address, city, state, zipcode)
        VALUES (?,?,?,?,?,?,?,?)
    """

    cursor.execute(sql, (user_firstname, user_lastname, user_email, user_phone,
                         user_address, user_city, user_state, user_zipcode))

    print(f"{user_firstname} has been added!")


def print_table(cursor, table_name):
    # query the table including the rowid primary key value
    cursor.execute(f"SELECT rowid, first_name, last_name, email, phone, address, city, state, zipcode FROM {table_name}")

    # store the results of a the query to a list called users
    users = cursor.fetchall()
    print("{0:<3} {1: <15} {2: <20} {3: <25} {4: <12} {5: <30} {6: <20} {7: <7} {8: <5}".format(
        "ID", "First name", "Last name", "Email", "Phone #", "Address", "City", "State", "Zipcode"
        )
    )
    # now we can loop through the results of the query
    for this_user in users:
        print("{0:<3} {1: <15} {2: <20} {3: <25} {4: <12} {5: <30} {6: <20} {7: <7} {8: <5}".format(
            this_user[0], this_user[1], this_user[2], this_user[3],
            this_user[4], this_user[5], this_user[6], this_user[7], this_user[8]
            )
        )
    print()