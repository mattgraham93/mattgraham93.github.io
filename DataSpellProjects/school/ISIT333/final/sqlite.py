import sqlite3
import random as rand


def connect(db_name):
    # connect to database and return connection and cursor to main
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()
    return conn, cursor


def create_table(cursor, table_name):
    # create the table if it doesn't already exist
    # note that primary keys are automatically created in sqlit3 and referenced as rowid -- noted!
    cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} "
                   f"(employee_ID INTEGER, first_name TEXT, last_name TEXT, address TEXT, "
                   "city TEXT, state TEXT, zipcode TEXT, email TEXT, phone TEXT, hourly_rate REAL, department TEXT)")

    employees = {
        1: ["Matt", "last", "address", "city", "state", 83193, "email", "phone", 19.23, "department"],
        2: ["Matt", "last", "address", "city", "state", 83193, "email", "phone", 19.23, "department"]
    }

    # create baseline records of data
    add_employee(cursor, table_name, mode="load", **employees)


def add_employee(cursor, table_name, mode, **employees):
    if mode == "user":
        employee_id = rand.randint(1000, 9999)
        user_firstname = input("First name: ")
        user_lastname = input("Last name: ")
        user_address = input("Address: ")
        user_city = input("City: ")
        user_state = input("State: ")
        user_zipcode = input("Zipcode: ")
        user_email = input("Email: ")
        user_phone = input("Phone: ")
        hourly_rate = input("Hourly rate: $")
        department = input("Department: ")
    elif mode == "load":
        for employee in employees:
            employee_id = employees[employee]
            user_firstname = employee[0]
            user_lastname = employee[1]
            user_address = employee[2]
            user_city = employee[3]
            user_state = employee[4]
            user_zipcode = employee[5]
            user_email = employee[6]
            user_phone = employee[7]
            hourly_rate = employee[8]
            department = employee[9]

            sql = f"""
                    INSERT INTO {table_name} (employee_id, first_name, last_name, address, city, state, zipcode, email, 
                    phone, hourly_rate, department)
                    VALUES (?,?,?,?,?,?,?,?,?,?,?)
                """

            cursor.execute(table_name, (employee_id, user_firstname, user_lastname, user_address,
                                        user_city, user_state, user_zipcode, user_email, user_phone, hourly_rate,
                                        department))
