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
    # get all user input for new user
    user_firstname = input("First name: ")
    user_lastname = input("Last name: ")
    user_email = input("Email: ")
    user_phone = input("Phone: ")
    user_address = input("Address: ")
    user_city = input("City: ")
    user_state = input("State: ")
    user_zipcode = input("Zipcode: ")

    # pass in table name and establish query
    # would like to dynamically insert into all columns regardless of table
    # like, "this table's columns"
    sql = f"""
        INSERT INTO {table_name} (first_name, last_name, email, phone, address, city, state, zipcode)
        VALUES (?,?,?,?,?,?,?,?)
    """

    cursor.execute(sql, (user_firstname, user_lastname, user_email, user_phone,
                         user_address, user_city, user_state, user_zipcode))

    print(f"{user_firstname} has been added!")
    # ALL CHANGES ARE COMMITTED AFTER USER FORMALLY EXITS PROGRAM


def report_query(cursor, sql):
    # execute sql command from main, pass users to print
    cursor.execute(sql)
    users = cursor.fetchall()
    print_query(users)


def print_query(users):
    # print headers and fields
    print("{0:<3} {1: <15} {2: <20} {3: <25} {4: <12} {5: <30} {6: <20} {7: <7} {8: <5}".format(
        "ID", "First name", "Last name", "Email", "Phone #", "Address", "City", "State", "Zipcode"
    )
    )
    for this_user in users:
        print("{0:<3} {1: <15} {2: <20} {3: <25} {4: <12} {5: <30} {6: <20} {7: <7} {8: <5}".format(
            this_user[0], this_user[1], this_user[2], this_user[3],
            this_user[4], this_user[5], this_user[6], this_user[7], this_user[8]
        )
        )
    print()
